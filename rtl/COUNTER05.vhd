------------------------------------------------------------ 
--DESIGN COUNTER05 BEGINS here 
------------------------------------------------------------ 
library ieee; 
use ieee.std_logic_1164.all; 

entity COUNTER05 is 
  generic ( s : integer := 4 ); 
  port(clk         :   in std_logic ; 
       zero_en     :   in std_logic ; 
       c_en        :   in std_logic ; 
       clrn        :   in std_logic ; 
       C_OUT       :   out std_logic_vector(s downto 0)); 
end COUNTER05 ; 

architecture behav of COUNTER05 is 
     signal C_OUT_sig : std_logic_vector(s downto 0); 
  begin 
    process(c_en,zero_en,clrn,clk) 
         variable toggle_bit_inr : std_logic_vector(s downto 0 ) ; 
      begin 
        if(clrn = '0') then 
          C_OUT_sig <= (others => '0') ; 
        elsif(rising_edge(clk)) then 
          toggle_bit_inr(0) := c_en ; 

           for j in 1 to s loop 
                  toggle_bit_inr(j) := toggle_bit_inr(j-1) and C_OUT_sig(j-1); 
           end loop ; 

           for j in 0 to s loop 
                      if (toggle_bit_inr(j) = '1') then 
                         C_OUT_sig(j) <= not (C_OUT_sig(j)) ; 
                      end if ; 
           end loop ; 
         if(zero_en = '1') then 
           C_OUT_sig <= (others => '0') ; 
         end if ; 
        end if ; 
    end process ; 
C_OUT <= C_OUT_sig ; 
end behav ; 
------------------------------------------------------------ 
--DESIGN COUNTER05 ENDS here 
------------------------------------------------------------