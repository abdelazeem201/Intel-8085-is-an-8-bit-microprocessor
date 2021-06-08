------------------------------------------------------------ 
--DESIGN MUX2X1_VEC BEGINS here 
------------------------------------------------------------ 
library ieee; 
use ieee.std_logic_1164.all; 

entity MUX2X1_VEC is 

   port( dat_out : out std_logic_vector(7 downto 0); 
         EN : in std_logic; 
         dat_in_b : in std_logic_vector(7 downto 0); 
         data_in : in std_logic_vector(7 downto 0)); 

end MUX2X1_VEC; 

architecture behav of MUX2X1_VEC is 
  begin 
   process(EN ,dat_in_b ,data_in) 
     variable EN_v : std_logic ; 
       begin 
           EN_v := EN ; 
           if(EN_v = '0') then 
             dat_out <= data_in ; 
           elsif(EN_v = '1') then 
             dat_out <= dat_in_b ; 
           end if ; 
   end process ; 
end behav ; 
------------------------------------------------------------ 
--DESIGN MUX2X1_VEC ENDS here 
------------------------------------------------------------ 