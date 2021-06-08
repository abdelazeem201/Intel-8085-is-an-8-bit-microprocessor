------------------------------------------------------------ 
--DESIGN adder8 BEGINS here : 8 bit adder using FULLADD as basic CELL 
------------------------------------------------------------ 
library ieee; 
use ieee.std_logic_1164.all; 

entity adder8 is 
  generic(n:integer := 7 ) ; 
  port( A_in : in std_logic_vector(n downto 0 ); 
        B_in : in std_logic_vector(n downto 0 ); 
        SUM  : out std_logic_vector(n downto 0 ); 
        cin  : in std_logic ; 
        ACY  : out std_logic ; 
        cout : out std_logic ) ; 
end adder8 ; 

architecture struct of adder8 is 
   component FULLADD 

   port( 
      Z                              :  out   STD_LOGIC; 
      CO                             :  out   STD_LOGIC; 
      A                              :  in    STD_LOGIC; 
      B                              :  in    STD_LOGIC; 
      CI                             :  in    STD_LOGIC); 
end component; 

   signal A_in_s :std_logic_vector(n downto 0 ); 
   signal B_in_s :std_logic_vector(n downto 0 ); 
   signal SUM_s  :std_logic_vector(n downto 0 ); 
   signal cin_s  :std_logic_vector(n downto 0 ); 
   signal cout_s :std_logic_vector(n downto 0 ); 
    begin 
   cin_s(0)  <= cin ; 
      ADD0: FULLADD port map (  Z   => SUM_s(0) , 
                            CO  => cout_s(0) , 
                            A   => A_in_s(0) , 
                            B   => B_in_s(0) , 
                            CI  => cin_s(0)) ; 
   G1 : for i in n downto 1 generate 
        ADD1: FULLADD port map( Z   => SUM_s(i) , 
                            CO  => cout_s(i) , 
                            A   => A_in_s(i) , 
                            B   => B_in_s(i) , 
                            CI  => cout_s(i-1)) ; 
     end generate ; 
SUM <= SUM_S ; 
cout <= cout_s(7) ; 
A_in_s <= A_in ; 
B_in_s <= B_in ; 
ACY <= cout_s(3) ; 
end struct ; 
------------------------------------------------------------ 
--DESIGN adder8 ENDS here 
------------------------------------------------------------ 
  