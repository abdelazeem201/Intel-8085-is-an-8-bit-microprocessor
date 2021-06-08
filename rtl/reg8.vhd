------------------------------------------------------------ 
--DESIGN reg8 BEGINS here: SIMPLE n BIT REGISTER WITH Async Reset(Clear) 
------------------------------------------------------------ 
LIBRARY IEEE; 
use ieee.std_logic_1164.all; 

entity reg8 is 
     generic (n: integer:= 7); 
       port(data_in    : in std_logic_vector(n downto 0); 
            load       : in std_logic; 
            clrn       : in std_logic; 
            clk        : in std_logic; 
            data_out   : out std_logic_vector(n downto 0)); 
end reg8; 
  
  

architecture behav of reg8 is 
   begin 
     process(clk,clrn) 
     variable dat_all_1:std_logic_vector(n downto 0) ; 
     variable data_out_sig:std_logic_vector(n downto 0) ; 
         begin 
               if(clrn = '1') then 
                       if(clk = '1') and (clk'event) then -- +ive edge triggred 
                           if(load = '1')then 
                             data_out <= data_in ; 
                           end if; 
                       end if; 
                  elsif(clrn = '0') then  -- for async reset 
                     data_out <= (others => '0') ; 
                  end if; 
     end process; 
end behav ; 
------------------------------------------------------------ 
--DESIGN reg8 ENDS here 
------------------------------------------------------------ 