------------------------------------------------------------ 
--DESIGN SP BEGINS here: It is the stack pointer register(16 bits) 
--Features: Async Reset(clear),Can count up,Can count Down,Load parallel data 
------------------------------------------------------------ 
library ieee; 
use ieee.std_logic_1164.all; 

entity SP is 
  port(c_en : in std_logic ;  -- it enables count(up or down) 
       clk  : in std_logic ; 
       lo_hi   : in std_logic ; 
       lo_lo   : in std_logic ; 
       clrn : in std_logic ; 
       dat_in : in std_logic_vector(7 downto 0 ); -- parallel data 
       SPL_OUT : out std_logic_vector(7 downto 0 ); 
       SPH_OUT : out std_logic_vector(7 downto 0 )); 
end SP ; 

architecture behav of SP is 
         signal c_out_var  : std_logic_vector(15 downto 0 ) ; 
  begin 
    process(clk,c_en,clrn,lo_hi,lo_lo,dat_in) 
         variable toggle_bit_inr : std_logic_vector(15 downto 0 ) ; 
         variable toggle_bit_dcr : std_logic_vector(15 downto 0 ) ; 
         variable sel            : std_logic_vector(2 downto 0 ) ; 
        begin 
         if(clrn = '0') then 
              c_out_var <= "0000000000000000" ; 
          else if(rising_edge(clk)) then 
              toggle_bit_inr(0) := c_en ; 
              toggle_bit_dcr(0) := c_en ; 
              for j in 1 to 15 loop 
                  toggle_bit_inr(j) := toggle_bit_inr(j-1) and c_out_var(j-1); 
                  toggle_bit_dcr(j) := toggle_bit_dcr(j-1) or  c_out_var(j-1); 
              end loop ; 

              for j in 0 to 15 loop 
                      if (toggle_bit_inr(j) = '1' or toggle_bit_dcr(j) = '0') then 
                         c_out_var(j) <= not (c_out_var(j)); 
                      end if ; 
              end loop ; 
          sel := lo_hi&lo_lo&c_en ; 
          case sel is 
            when "011" => 
              for i in 7 downto 0 loop 
               c_out_var(i) <= dat_in(i) ; 
               c_out_var(i+8) <= c_out_var(i+8) ; 
              end loop ; 
            when "101" => 
              for i in 7 downto 0 loop 
               c_out_var(i+8) <= dat_in(i) ; 
               c_out_var(i) <= c_out_var(i) ; 
              end loop ; 
            when "000"  => 
               c_out_var <= c_out_var ; 
            when others  => 
               null ; 
          end case ; 
          end if ; 
         end if ; 
    end process ; 
          SPL_OUT <= c_out_var(7)&c_out_var(6)&c_out_var(5)&c_out_var(4)&c_out_var(3)&c_out_var(2)&c_out_var(1)&c_out_var(0); 
          SPH_OUT <= c_out_var(15)&c_out_var(14)&c_out_var(13)&c_out_var(12)&c_out_var(11)&c_out_var(10)&c_out_var(9)&c_out_var(8); 
end behav ; 
------------------------------------------------------------ 
--DESIGN SP ENDS here 
------------------------------------------------------------ 