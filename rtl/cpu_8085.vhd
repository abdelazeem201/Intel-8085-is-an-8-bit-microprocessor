------------------------------------------------------------ 
--DESIGN cpu_8085 BEGINS here 
------------------------------------------------------------ 
LIBRARY IEEE; 
use ieee.std_logic_1164.all; 

entity cpu_8085 is 
  port(data_bus   : inout std_logic_vector(7 downto 0) ; 
       add_bus    : out std_logic_vector(7 downto 0) ; 
       cpu_reset  :in std_logic ; 
       s0         : out std_logic ; 
       s1         : out std_logic ; 
       iomn       : out std_logic ; 
       ALE        : out std_logic ; 
       RESETOUT   : out std_logic ; 
       CLK_OUT    : out std_logic ; 
       clk        : in std_logic ; 
       X1         : in std_logic ; 
       X2         : in std_logic ; 
       SOD        : in std_logic ; 
       SID        : in std_logic ; 
       HOLD       : in std_logic ; 
       HOLDA      : out std_logic ; 
       TRAP       : in std_logic ; 
       RST7_5     : in std_logic ; 
       RST6_5     : in std_logic ; 
       RST5_5     : in std_logic ; 
       INTR       : in std_logic ; 
       INTA       : out std_logic ; 
       READY      : in std_logic ; 
       RDn        : out std_logic ; 
       WRn        : out std_logic 
      ) ; 
end cpu_8085 ; 

architecture behav of cpu_8085 is 
signal LOAD_LOW_ADD   : std_logic ;  --cw item 
signal EN_IN_BUS      : std_logic ;  --cw item 
signal EN_OUT_BUS     : std_logic ;  --cw item 
signal EN_FROM_OUT    : std_logic ;  --cw item 
signal SEL_DATAOUT_ALU_OUT  : std_logic ;  --cw item 
signal T_STATES       : std_logic_vector(4 downto 0);-- := "11111";  --cw item 
signal logic_one      : std_logic ;    --:= '1';  --cw item 
signal ZERO_SEQ_COUNTER: std_logic ;  --cw item 
signal LOAD_REG_T     : std_logic ;  --cw item 
signal LOAD_REG_ID    : std_logic ;  --cw item 
signal INR_PC         : std_logic ;  --cw item 
signal DCR_SP         : std_logic ;  --cw item 
signal OP_SEL         : std_logic_vector(3 downto 0) ;  --cw item 
signal LOW_ADD        : std_logic_vector(7 downto 0) ; 
signal INSIDE_BUS     : std_logic_vector(7 downto 0) ; 
signal IN_BUS_RES     : std_logic_vector(7 downto 0) ; 
signal A_OUT_S        : std_logic_vector(7 downto 0) ; 
signal B_OUT_S        : std_logic_vector(7 downto 0) ; 
signal C_OUT_S        : std_logic_vector(7 downto 0) ; 
signal D_OUT_S        : std_logic_vector(7 downto 0) ; 
signal E_OUT_S        : std_logic_vector(7 downto 0) ; 
signal F_OUT_S        : std_logic_vector(7 downto 0) ; 
signal H_OUT_S        : std_logic_vector(7 downto 0) ; 
signal L_OUT_S        : std_logic_vector(7 downto 0) ; 
signal T_OUT_S        : std_logic_vector(7 downto 0) ; 
signal SPH_OUT_S      : std_logic_vector(7 downto 0) ; 
signal ID_OUT_S       : std_logic_vector(7 downto 0) ; 
signal SEL_IN         : std_logic_vector(4 downto 0) ; 
signal SEL_OUT        : std_logic_vector(4 downto 0) ; 
signal CY_S           : std_logic; 
signal ACY_S          : std_logic; 
signal SIGN_S         : std_logic; 
signal PARITY_S       : std_logic; 
signal ZERO_S         : std_logic; 
signal CIN_S          : std_logic; 
signal DAT_IN_FL_S     : std_logic_vector(7 downto 0); 
signal LOAD_FL_S       : std_logic; 
signal ADD_HIGH_S      : std_logic_vector(7 downto 0); 
signal SEL_S           : std_logic_vector(2 downto 0); 
signal clkn            : std_logic; 
signal REG_ARR_OUT_BUS : std_logic_vector(7 downto 0 ); 
signal ALU_BUS         : std_logic_vector(7 downto 0 ); 

component trans_latch 

   port( in_dat  : in std_logic_vector (7 downto 0); 
         load    : in std_logic; 
         dat_out : out std_logic_vector (7 downto 0)); 

end component; 

component add_latch_high 
       generic (n: integer:= 7); 
 port(dat_pch : in std_logic_vector(7 downto 0) ; 
      dat_H   : in std_logic_vector(7 downto 0) ; 
      dat_B   : in std_logic_vector(7 downto 0) ; 
      dat_D   : in std_logic_vector(7 downto 0) ; 
      dat_SPH : in std_logic_vector(7 downto 0) ; 
      SEL     : in std_logic_vector(2 downto 0) ; 
      clk     : in std_logic ; 
      clrn    : in std_logic ; 
      load    : in std_logic ; 
      data_out   : out std_logic_vector(7 downto 0) ); 
end component ; 

component MUX2X1_VEC 
   port( dat_out : out std_logic_vector(7 downto 0); 
         EN : in std_logic; 
         dat_in_b : in std_logic_vector(7 downto 0); 
         data_in : in std_logic_vector(7 downto 0)); 

end component; 

component cpu_control 
    port( 
        ID_OUT_S     : in std_logic_vector(7 downto 0) ; 
        DEC5X32_IN     : in std_logic_vector(4 downto 0) ; 
        clk                  : in std_logic ; 

       s0         : out std_logic ; 
       s1         : out std_logic ; 
       iomn       : out std_logic ; 
       RESETOUT   : out std_logic ; 
       CLK_OUT    : out std_logic ; 
       SOD        : in std_logic ; 
       SID        : in std_logic ; 
       HOLD       : in std_logic ; 
       HOLDA      : out std_logic ; 
       TRAP       : in std_logic ; 
       RST7_5     : in std_logic ; 
       RST6_5     : in std_logic ; 
       RST5_5     : in std_logic ; 
       INTR       : in std_logic ; 
       INTA       : out std_logic ; 
       ACY        : in std_logic ; 
       SIGN       : in std_logic ; 
       PARITY     : in std_logic ; 
       ZERO       : in std_logic ; 
       CY         : in std_logic ; 
       CIN        : out std_logic ; 
       LOAD_FL    : out std_logic ; 
       SEL_HI_ADD : out std_logic_vector(2 downto 0 ) ; 

        LATCH_LOW_ADD          : out std_logic ; 
        ZERO_SEQ_COUNTER     : out std_logic ; 
        ALE     : out std_logic ; 
        RDn     : out std_logic ; 
        WRn     : out std_logic ; 
        OP_SEL : out std_logic_vector(3 downto 0) ; 
        SEL_DATAOUT_ALU_OUT     : out std_logic ; 
        EN_FROM_OUT     : out std_logic ; 
       LOAD_REG_T     : out std_logic ; 
       LOAD_REG_ID     : out std_logic ; 
       INR_PC     : out std_logic ; 
       DCR_SP     : out std_logic ; 
       EN_OUT_BUS     : out std_logic ; 
       EN_IN_BUS     : out std_logic ; 
       clkn                   : out std_logic ; 
       SEL_IN    : out std_logic_vector(4 downto 0) ; 
       SEL_OUT   : out std_logic_vector(4 downto 0)) ; 
end component ; 

component TRI_ARR 
   port( data_out : out std_logic_vector(7 downto 0) ; 
         EN : in std_ulogic; 
         data_in : in std_logic_vector(7 downto 0)); 

end component; 

component alu 
      generic ( n : integer := 7 ; 
                s : integer := 3) ; 
      port(dat_a  : in std_logic_vector(n downto 0); 
           dat_b  : in std_logic_vector(n downto 0); 
           dat_out: out std_logic_vector(n downto 0); 
           cout   : out std_logic; 
           ACY   : out std_logic; 
           SIGN   : out std_logic; 
           PARITY   : out std_logic; 
           ZERO   : out std_logic; 
           CIN   : in std_logic; 
           op_sel : in std_logic_vector(s downto 0)); 
end component; 

component REG_ARR 
generic ( n : integer := 7 ; 
          s : integer := 4); 
port ( DAT_IN    : in std_logic_vector(n downto 0) ; 
       DAT_IN_FL : in std_logic_vector(n downto 0) ; 
       LOAD_FL   : in std_logic ; 
       clrn      : in std_logic ; 
       clk       : in std_logic ; 
       INR_PC    : in std_logic ; 
       DCR_SP    : in std_logic ; 
       DAT_OUT   : out std_logic_vector(n downto 0) ; 
       COUNT_OUT : out std_logic_vector(n downto 0) ; 
       A_OUT     : out std_logic_vector(n downto 0) ; 
       B_OUT     : out std_logic_vector(n downto 0) ; 
       C_OUT     : out std_logic_vector(n downto 0) ; 
       D_OUT     : out std_logic_vector(n downto 0) ; 
       E_OUT     : out std_logic_vector(n downto 0) ; 
       F_OUT     : out std_logic_vector(n downto 0) ; 
       H_OUT     : out std_logic_vector(n downto 0) ; 
       L_OUT     : out std_logic_vector(n downto 0) ; 
       SPH_OUT   : out std_logic_vector(n downto 0) ; 
       SEL_IN    : in std_logic_vector(s downto 0) ; 
       SEL_OUT   : in std_logic_vector(s downto 0)) ; 
end component ; 

component reg8 
       port(data_in    : in std_logic_vector(7 downto 0); 
            load       : in std_logic; 
            clrn       : in std_logic; 
            clk        : in std_logic; 
            data_out   : out std_logic_vector(7 downto 0)); 
end component ; 

component COUNTER05 
   generic ( s : integer := 4) ; 
   port ( clk : in std_logic ; 
          zero_en: in std_logic ; 
          c_en: in std_logic ; 
          clrn: in std_logic ; 
          C_OUT   : out std_logic_vector(s downto 0)); 
end component ; 

begin 
logic_one <= '1' ; 
LOW_ADD_LATCH: trans_latch port map 
         (in_dat  => IN_BUS_RES , 
         load     => LOAD_LOW_ADD, 
         dat_out  => LOW_ADD ); 

COUNTER_1 : COUNTER05 port map (clk => clk , 
                                zero_en => ZERO_SEQ_COUNTER, 
                                c_en => READY , 
                                clrn => cpu_reset , 
                                C_OUT => T_STATES); 
  

ADD_LATCH_1: add_latch_high port map (dat_pch => ADD_HIGH_S, 
      dat_H   => H_OUT_S , 
      dat_B   => B_OUT_S , 
      dat_D   => D_OUT_S , 
      dat_SPH => SPH_OUT_S , 
      SEL     => SEL_S , 
      clk     => clk , 
      clrn    => cpu_reset, 
      load    => logic_one , 
      data_out => add_bus) ; 

REG_T : reg8 port map (data_in => REG_ARR_OUT_BUS , 
            load       => LOAD_REG_T , 
            clrn       => cpu_reset, 
            clk        => clkn, 
            data_out   => T_OUT_S); 

REG_ID : reg8 port map (data_in => INSIDE_BUS , 
            load       => LOAD_REG_ID , 
            clrn       => cpu_reset, 
            clk        => clk, 
            data_out   => ID_OUT_S); 

ALU_1 : alu port map (dat_a   => A_OUT_S, 
           dat_b   => T_OUT_S, 
           dat_out => ALU_BUS, 
           cout    => CY_S, 
           ACY     => ACY_S, 
           SIGN    => SIGN_S, 
           PARITY  => PARITY_S, 
           ZERO    => ZERO_S, 
           CIN     => CIN_S, 
           op_sel  => OP_SEL); 

REGS_1 : REG_ARR 
       port map (DAT_IN    => INSIDE_BUS, 
       DAT_IN_FL => DAT_IN_FL_S , 
       LOAD_FL   => LOAD_FL_S, 
       clrn      => cpu_reset , 
       clk       => clk, 
       INR_PC    => INR_PC, 
       DCR_SP    => DCR_SP, 
       DAT_OUT   => REG_ARR_OUT_BUS, 
       COUNT_OUT   => ADD_HIGH_S, 
       A_OUT   => A_OUT_S, 
       B_OUT   => B_OUT_S, 
       C_OUT   => C_OUT_S, 
       D_OUT   => D_OUT_S, 
       E_OUT   => E_OUT_S, 
       F_OUT   => F_OUT_S, 
       H_OUT   => H_OUT_S, 
       L_OUT   => L_OUT_S, 
       SPH_OUT   => SPH_OUT_S, 
       SEL_IN    => SEL_IN, 
       SEL_OUT   => SEL_OUT); 

CONTROL_1 : cpu_control 
            port map ( 
        ID_OUT_S     => ID_OUT_S, 
        DEC5X32_IN   => T_STATES , 
        clk   =>   clk , 

       s0        =>  s0, 
       s1        =>  s1, 
       iomn      =>  iomn, 
       RESETOUT  =>  RESETOUT, 
       CLK_OUT   =>  CLK_OUT, 
       SOD       =>  SOD, 
       SID       =>  SID, 
       HOLD      =>  HOLD, 
       HOLDA     =>  HOLDA, 
       TRAP      =>  TRAP, 
       RST7_5    =>  RST7_5, 
       RST6_5    =>  RST6_5, 
       RST5_5    =>  RST5_5, 
       INTR      =>  INTR, 
       INTA      =>  INTA, 
       ACY       =>  F_OUT_S(4), 
       SIGN      =>  F_OUT_S(7), 
       PARITY    =>  F_OUT_S(2), 
       ZERO      =>  F_OUT_S(6), 
       CY        =>  F_OUT_S(0), 
       CIN       =>  CIN_S, 
       LOAD_FL   => LOAD_FL_S, 
       SEL_HI_ADD   => SEL_S, 

        LATCH_LOW_ADD    => LOAD_LOW_ADD, 
        ZERO_SEQ_COUNTER => ZERO_SEQ_COUNTER , 
        ALE => ALE, 
        RDn => RDn, 
        WRn => WRn, 
        OP_SEL => OP_SEL, 
        SEL_DATAOUT_ALU_OUT  => SEL_DATAOUT_ALU_OUT, 
        EN_FROM_OUT     => EN_FROM_OUT , 
       LOAD_REG_T   => LOAD_REG_T , 
       LOAD_REG_ID   => LOAD_REG_ID , 
       INR_PC   => INR_PC , 
       DCR_SP   => DCR_SP , 
       EN_OUT_BUS     => EN_OUT_BUS, 
       EN_IN_BUS     => EN_IN_BUS , 
       clkn => clkn , 
       SEL_IN    => SEL_IN , 
       SEL_OUT   => SEL_OUT); 

TRI_1 : TRI_ARR port map ( data_out => INSIDE_BUS , 
                           EN       => EN_IN_BUS, 
                           data_in  => IN_BUS_RES); 

TRI_2 : TRI_ARR port map ( data_out => data_bus , 
                           EN       => EN_OUT_BUS, 
                           --data_in  => IN_BUS_RES); 
                           data_in  => LOW_ADD); 

TRI_3 : TRI_ARR port map ( data_out => INSIDE_BUS , 
                           EN       => EN_FROM_OUT, 
                           data_in  => data_bus); 
MUX_SEL_1 : MUX2X1_VEC port map ( dat_out => IN_BUS_RES , 
                                  EN      => SEL_DATAOUT_ALU_OUT , 
                                  dat_in_b      => REG_ARR_OUT_BUS , 
                                  data_in      => ALU_BUS ); 

DAT_IN_FL_S(7) <= SIGN_S ; 
DAT_IN_FL_S(6) <= ZERO_S ; 
DAT_IN_FL_S(5) <= ZERO_S ; 
DAT_IN_FL_S(4) <= ACY_S ; 
DAT_IN_FL_S(3) <= ACY_S ; 
DAT_IN_FL_S(2) <= PARITY_S ; 
DAT_IN_FL_S(1) <= PARITY_S ; 
DAT_IN_FL_S(0) <= CY_S ; 

end behav ; 
------------------------------------------------------------ 
--DESIGN cpu_8085 ENDS here 
------------------------------------------------------------