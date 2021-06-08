------------------------------------------------------------ 
--DESIGN pcl BEGINS here: PROGRAM COUNTER REGISTER LSBits 
------------------------------------------------------------ 
LIBRARY IEEE; 
use ieee.std_logic_1164.all; 

entity pcl is 
     generic ( n : integer := 7 ); 
              port(count_out : out std_logic_vector(n downto 0) ; 
                   OUT_to_PCH  : out std_logic; 
                   count_en  : in std_logic ; 
                   clk       : in std_logic ; 
                   clrn      : in std_logic ; 
                   dat_in    : in std_logic_vector(n downto 0) ; 
                   load_en   : in std_logic ); 
end pcl ; 

architecture struct of pcl is 
component CELLPC 
   port( C : out std_logic; 
         load_en, 
         count_en, 
         data_in, 
         clrn, 
         clk : in std_logic); 
end component ; 

signal count_out_sig : std_logic_vector(n downto 0) ; 
signal count_en_sig : std_logic_vector(n downto 0) ; 
   begin 
count_en_sig(0) <= count_en ; 
PC1: CELLPC port map( C         =>   count_out_sig(0) , 
                     load_en   =>   load_en , 
                     count_en  =>   count_en , 
                     data_in   =>   dat_in(0) , 
                     clrn      =>   clrn , 
                     clk       =>   clk ) ; 
  

G1: for i in n downto 1 generate 
    PC1: CELLPC port map( C         =>   count_out_sig(i) , 
                     load_en   =>   load_en , 
                     count_en  =>   count_en_sig(i) , 
                     data_in   =>   dat_in(i) , 
                     clrn      =>   clrn , 
                     clk       =>   clk ) ; 

count_en_sig(i) <= count_out_sig(i-1) and count_en_sig(i-1) ; 
   end generate ; 
OUT_to_PCH <= count_out_sig(7) and count_en_sig(7) ; 
count_out <= count_out_sig ; 
end struct ; 
------------------------------------------------------------ 
--DESIGN pcl ENDS here 
------------------------------------------------------------ 