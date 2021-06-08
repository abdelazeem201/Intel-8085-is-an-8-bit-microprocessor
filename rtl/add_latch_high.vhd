------------------------------------------------------------ 
--DESIGN add_latch_high BEGINS here 
------------------------------------------------------------ 
library ieee; 
use ieee.std_logic_1164.all; 

entity add_latch_high is 
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
end add_latch_high ; 

architecture behav of add_latch_high is 

component reg8 
--       generic (n: integer:= 7); 
       port(data_in    : in std_logic_vector(n downto 0); 
            load       : in std_logic; 
            clrn       : in std_logic; 
            clk        : in std_logic; 
            data_out   : out std_logic_vector(n downto 0)); 
end component ; 

  signal data_reg8 :std_logic_vector(n downto 0) ; 
  signal data_reg8_in :std_logic_vector(n downto 0) ; 

 begin 

LATCH_1:reg8 port map (data_in => data_reg8 , 
                       load    => load , 
                       clrn    => clrn , 
                       clk     => clk , 
                       data_out    => data_out ); 

   process(clk,sel,dat_pch,dat_H,dat_B,dat_D) 
    variable data_reg8_var : std_logic_vector(n downto 0);-- := "00000000"; 
      begin 
       case sel is 
         when  "000" => 
      data_reg8_var :=  dat_pch ; 

         when  "001" => 
      data_reg8_var :=  dat_B ; 

         when  "010" => 
      data_reg8_var :=  dat_D ; 

         when  "011" => 
      data_reg8_var :=  dat_H ; 

         when  "100" => 
      data_reg8_var :=  dat_SPH ; 

         when others => 
      data_reg8_var :=  "00000000"; 
       end case ; 
data_reg8 <= data_reg8_var ; 
   end process ; 
end behav ; 
------------------------------------------------------------ 
--DESIGN add_latch_high ENDS here 
------------------------------------------------------------ 