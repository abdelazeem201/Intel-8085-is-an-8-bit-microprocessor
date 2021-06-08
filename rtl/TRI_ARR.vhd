------------------------------------------------------------ 
--DESIGN TRI_ARR BEGINS here 
------------------------------------------------------------ 
library ieee; 
use ieee.std_logic_1164.all; 

entity TRI_ARR is 

   port( data_out : out std_logic_vector(7 downto 0) ; 
         EN : in std_ulogic; 
         data_in : in std_logic_vector(7 downto 0)); 
end TRI_ARR; 

architecture behav of TRI_ARR is 
 begin 
  process(EN,data_in) 
     variable data_out_var : std_logic_vector(7 downto 0); 
         begin 
           if(EN = '1') then 
             data_out_var := data_in ; 
           else 
             data_out_var := "ZZZZZZZZ"; 
           end if ; 
data_out <= data_out_var ; 
 end process ; 
end behav ; 
------------------------------------------------------------ 
--DESIGN TRI_ARR ENDS here 
------------------------------------------------------------ 