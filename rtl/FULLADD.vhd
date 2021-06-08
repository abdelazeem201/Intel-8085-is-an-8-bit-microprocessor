------------------------------------------------------------ 
--DESIGN FULLADD BEGINS here: One bit Full Adder 
------------------------------------------------------------ 
LIBRARY IEEE; 
use ieee.std_logic_1164.all; 
entity FULLADD is 
   port( 
      Z                              :  out   STD_LOGIC; 
      CO                             :  out   STD_LOGIC; 
      A                              :  in    STD_LOGIC; 
      B                              :  in    STD_LOGIC; 
      CI                             :  in    STD_LOGIC); 
end FULLADD; 

architecture behav of FULLADD is 
  begin 
    process(A,B,CI) 
      variable sel : std_logic_vector(2 downto 0) ; 
     begin 
      sel := A&B&CI ; 
      case sel is 
        when "000" => 
          CO <= '0' ; 
          Z  <= '0' ; 
        when "001" => 
          CO <= '0' ; 
          Z  <= '1' ; 
        when "010" => 
          CO <= '0' ; 
          Z  <= '1' ; 
        when "011" => 
          CO <= '1' ; 
          Z  <= '0' ; 
        when "100" => 
          CO <= '0' ; 
          Z  <= '1' ; 
        when "101" => 
          CO <= '1' ; 
          Z  <= '0' ; 
        when "110" => 
          CO <= '1' ; 
          Z  <= '0' ; 
        when "111" => 
          CO <= '1' ; 
          Z  <= '1' ; 
        when others => 
          CO <= 'X' ; 
          Z  <= 'X' ; 
      end case ; 
    end process ; 
end behav ; 
------------------------------------------------------------ 
--DESIGN FULLADD ENDS here 
------------------------------------------------------------ 
  