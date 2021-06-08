------------------------------------------------------------ 
--DESIGN REG_ARR BEGINS here 
------------------------------------------------------------ 
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all ; 
entity REG_ARR is 
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
end REG_ARR ; 

architecture behav of REG_ARR is 
component SP 
  port(c_en : in std_logic ; 
       clk  : in std_logic ; 
       lo_hi   : in std_logic ; 
       lo_lo   : in std_logic ; 
       clrn : in std_logic ; 
       dat_in : in std_logic_vector(7 downto 0 ); 
       SPL_OUT : out std_logic_vector(7 downto 0 ); 
       SPH_OUT : out std_logic_vector(7 downto 0 )); 
end component ; 

component reg8 
--       generic (n: integer:= 7); 
       port(data_in    : in std_logic_vector(n downto 0); 
            load       : in std_logic; 
            clrn       : in std_logic; 
            clk        : in std_logic; 
            data_out   : out std_logic_vector(n downto 0)); 
end component ; 

component pch 
   generic( n : Integer := 7); 
   port( count_out : out std_logic_vector (7 downto 0); 
         count_en, clk, clrn : in std_logic; 
         dat_in : in std_logic_vector (7 downto 0);  load_en :in std_logic); 
end component; 
  

component pcl 
     generic ( n : integer := 7 ); 
              port(count_out : out std_logic_vector(n downto 0) ; 
                   OUT_to_PCH  : out std_logic; 
                   count_en  : in std_logic ; 
                   clk       : in std_logic ; 
                   clrn      : in std_logic ; 
                   dat_in    : in std_logic_vector(n downto 0) ; 
                   load_en   : in std_logic ); 
end component ; 
  

signal load_A : std_logic ; 
signal dat_out_regA : std_logic_vector(n downto 0); 

--signal load_F : std_logic ; 
signal dat_out_regF : std_logic_vector(n downto 0); 

signal load_B : std_logic ; 
signal dat_out_regB : std_logic_vector(n downto 0); 

signal load_C : std_logic ; 
signal dat_out_regC : std_logic_vector(n downto 0); 

signal load_D : std_logic ; 
signal dat_out_regD : std_logic_vector(n downto 0); 

signal load_E : std_logic ; 
signal dat_out_regE : std_logic_vector(n downto 0); 

signal load_H : std_logic ; 
signal dat_out_regH : std_logic_vector(n downto 0); 

signal load_L : std_logic ; 
signal dat_out_regL : std_logic_vector(n downto 0); 

signal load_SPL : std_logic ; 
signal dat_out_regSPL : std_logic_vector(n downto 0); 

signal load_SPH : std_logic ; 
signal dat_out_regSPH : std_logic_vector(n downto 0); 

signal load_PCL : std_logic ; 
signal dat_out_regPCL : std_logic_vector(n downto 0); 

signal load_PCH : std_logic ; 
signal dat_out_regPCH : std_logic_vector(n downto 0); 

signal load_W : std_logic ; 
signal dat_out_regW : std_logic_vector(n downto 0); 

signal load_Z : std_logic ; 
signal dat_out_regZ : std_logic_vector(n downto 0); 

--signal load_VECTOR : std_logic_vector(13 downto 0); 

signal INR_PCH : std_logic ; 
--signal DCR_SPH : std_logic ; 
begin 

 REG_A:reg8 port map (data_in   => DAT_IN,   --1 
                      load      => load_A , 
                      clrn      => clrn , 
                      clk       => clk , 
                      data_out  => dat_out_regA ) ; 

 REG_F:reg8 port map (data_in   => DAT_IN_FL,  --2 
                      load      => load_FL , 
                      clrn      => clrn , 
                      clk       => clk , 
                      data_out  => dat_out_regF ) ; 

 REG_B:reg8 port map (data_in   => DAT_IN,   --3 
                      load      => load_B , 
                      clrn      => clrn , 
                      clk       => clk , 
                      data_out  => dat_out_regB ) ; 

 REG_C:reg8 port map (data_in   => DAT_IN,   --4 
                      load      => load_C , 
                      clrn      => clrn , 
                      clk       => clk , 
                      data_out  => dat_out_regC ) ; 

 REG_D:reg8 port map (data_in   => DAT_IN,   --5 
                      load      => load_D , 
                      clrn      => clrn , 
                      clk       => clk , 
                      data_out  => dat_out_regD ) ; 

 REG_E:reg8 port map (data_in   => DAT_IN,   --6 
                      load      => load_E , 
                      clrn      => clrn , 
                      clk       => clk , 
                      data_out  => dat_out_regE ) ; 

 REG_H:reg8 port map (data_in   => DAT_IN,   --7 
                      load      => load_H , 
                      clrn      => clrn , 
                      clk       => clk , 
                      data_out  => dat_out_regH ) ; 

 REG_L:reg8 port map (data_in   => DAT_IN,   --8 
                      load      => load_L , 
                      clrn      => clrn , 
                      clk       => clk , 
                      data_out  => dat_out_regL ) ; 
  

REG_SP : SP port map(c_en    => DCR_SP , 
                     clk     => clk , 
                     lo_hi   => load_SPH , 
                     lo_lo   => load_SPL , 
                     clrn    => clrn , 
                     dat_in  => DAT_IN , 
                     SPL_OUT => dat_out_regSPL , 
                     SPH_OUT => dat_out_regSPH ) ; 

 REG_PCL:pcl port map (dat_in    => DAT_IN,   --11 
                      OUT_to_PCH => INR_PCH , 
                      load_en    => load_PCL , 
                      count_en   => INR_PC , 
                      clrn       => clrn , 
                      clk        => clk , 
                      count_out  => dat_out_regPCL ) ; 

 REG_PCH:pch port map (dat_in   => DAT_IN,   --11 
                      load_en   => load_PCH , 
                      count_en  => INR_PCH , 
                      clrn      => clrn , 
                      clk       => clk , 
                      count_out => dat_out_regPCH ) ; 

 REG_W:reg8 port map (data_in   => DAT_IN,   --13 
                      load      => load_W , 
                      clrn      => clrn , 
                      clk       => clk , 
                      data_out  => dat_out_regW ) ; 

 REG_Z:reg8 port map (data_in   => DAT_IN,   --14 
                      load      => load_Z , 
                      clrn      => clrn , 
                      clk       => clk , 
                      data_out  => dat_out_regZ ) ; 

 process(DAT_IN,INR_PC,SEL_IN,SEL_OUT,clk,clrn) 
 variable load_VECTOR : std_logic_vector(13 downto 0); 
 variable DAT_OUT_var : std_logic_vector(n downto 0); 
 variable SEL_IN_INT : integer ;--:= 0 ; 
 variable SEL_OUT_INT : integer ;--:= 0 ; 
  begin 
   SEL_IN_INT := CONV_INTEGER(SEL_IN); 
   SEL_OUT_INT := CONV_INTEGER(SEL_OUT); 
   case SEL_IN_INT is 
     when 0 => 
     load_VECTOR := "00000000000001" ; 

     when 1 => 
     load_VECTOR := "00000000000010" ; 

     when 2 => 
     load_VECTOR := "00000000000100" ; 

     when 3 => 
     load_VECTOR := "00000000001000" ; 

     when 4 => 
     load_VECTOR := "00000000010000" ; 

     when 5 => 
     load_VECTOR := "00000000100000" ; 

     when 6 => 
     load_VECTOR := "00000001000000" ; 

     when 7 => 
     load_VECTOR := "00000010000000" ; 

--     when 8 => 
--     load_VECTOR := "00000100000000" ; 

     when 9 => 
     load_VECTOR := "00001000000000" ; 

     when 10 => 
     load_VECTOR := "00010000000000" ; 

     when 11 => 
     load_VECTOR := "00100000000000" ; 

     when 12 => 
     load_VECTOR := "01000000000000" ; 

     when 13 => 
     load_VECTOR := "10000000000000" ; 

     when 14 => 
     load_VECTOR := "00000000000000" ; 

     when others => 
     load_VECTOR := "00000000000000" ; 

end case ; 

   case SEL_OUT_INT is 
     when 7 => 
DAT_OUT_var := dat_out_regA ; 

     when 8 => 
DAT_OUT_var := dat_out_regF ; 

     when 0 => 
DAT_OUT_var := dat_out_regB ; 

     when 1 => 
DAT_OUT_var := dat_out_regC ; 

     when 2 => 
DAT_OUT_var := dat_out_regD ; 

     when 3 => 
DAT_OUT_var := dat_out_regE ; 

     when 4 => 
DAT_OUT_var := dat_out_regH ; 

     when 5 => 
DAT_OUT_var := dat_out_regL ; 

     when 9 => 
DAT_OUT_var := dat_out_regSPL ; 

     when 10 => 
DAT_OUT_var := dat_out_regSPH ; 

     when 11 => 
DAT_OUT_var := dat_out_regPCL ; 

     when 12 => 
DAT_OUT_var := dat_out_regPCH ; 

     when 13 => 
DAT_OUT_var := dat_out_regW ; 

     when 6 => 
DAT_OUT_var := dat_out_regZ ; 

     when others => 
DAT_OUT_var := dat_out_regPCL ; 

end case ; 
load_A   <= load_VECTOR(7) ; 
--load_F <= load_VECTOR(8) ; 
load_B   <= load_VECTOR(0) ; 
load_C   <= load_VECTOR(1) ; 
load_D   <= load_VECTOR(2) ; 
load_E   <= load_VECTOR(3) ; 
load_H   <= load_VECTOR(4) ; 
load_L   <= load_VECTOR(5) ; 
load_SPL <= load_VECTOR(9) ; 
load_SPH <= load_VECTOR(10) ; 
load_PCL <= load_VECTOR(11) ; 
load_PCH <= load_VECTOR(12) ; 
load_W   <= load_VECTOR(13) ; 
load_Z   <= load_VECTOR(6) ; 
DAT_OUT  <= DAT_OUT_var ; 

end process ; 

COUNT_OUT <= dat_out_regPCH ; 
A_OUT     <= dat_out_regA; 
B_OUT     <= dat_out_regB; 
C_OUT     <= dat_out_regC; 
D_OUT     <= dat_out_regD; 
E_OUT     <= dat_out_regE; 
F_OUT     <= dat_out_regF; 
H_OUT     <= dat_out_regH; 
SPH_OUT   <= dat_out_regSPH; 
L_OUT     <= dat_out_regL; 
end behav ; 
------------------------------------------------------------ 
--DESIGN REG_ARR ENDS here 
------------------------------------------------------------ 
  