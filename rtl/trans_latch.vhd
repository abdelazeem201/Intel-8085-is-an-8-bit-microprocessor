------------------------------------------------------------ 
--DESIGN trans_latch BEGINS here 
------------------------------------------------------------ 
library ieee; 
use ieee.std_logic_1164.all; 
entity trans_latch is 
  port(in_dat : in std_logic_vector(7 downto 0); 
       load   : in std_logic ; 
       dat_out: out std_logic_vector(7 downto 0)); 
end trans_latch ; 

architecture behav of trans_latch is 
  begin 
   process(load) 
   begin 
      if(load = '1')then 
        dat_out <= in_dat; 
      end if ; 
  end process ; 
end behav ; 
------------------------------------------------------------ 
--DESIGN trans_latch ENDS here 
------------------------------------------------------------ 