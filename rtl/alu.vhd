------------------------------------------------------------ 
--DESIGN alu BEGINS here 
------------------------------------------------------------ 
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all ; 

entity alu is 
      generic ( n : integer := 7 ; 
                s : integer := 3) ; 
      port(dat_a  : in std_logic_vector(n downto 0); 
           dat_b  : in std_logic_vector(n downto 0); 
           dat_out: out std_logic_vector(n downto 0); 
           cout   : out std_logic; 
           ACY    : out std_logic; 
           SIGN   : out std_logic; 
           PARITY : out std_logic; 
           ZERO   : out std_logic; 
           cin    : in std_logic; 
           op_sel : in std_logic_vector(s downto 0)); 
end alu; 
  
  

architecture behav of alu is 
   signal nd    : std_logic_vector(n downto 0 ); 
   signal A_in_s    : std_logic_vector(n downto 0 ); 
   signal B_in_s    : std_logic_vector(n downto 0 ); 
   signal dat_b_n_s : std_logic_vector(n downto 0 ); 
   signal dat_a_n_s : std_logic_vector(n downto 0 ); 
   signal B_in_s_r  : std_logic_vector(n downto 0 ); 
   signal A_in_s_r  : std_logic_vector(n downto 0 ); 
   signal SUM_s     : std_logic_vector(n downto 0 ); 
   signal cout_s    : std_logic ; 
component ADDER8 
  port( A_in : in std_logic_vector(n downto 0 ); 
        B_in : in std_logic_vector(n downto 0 ); 
        SUM  : out std_logic_vector(n downto 0 ); 
        cin  : in std_logic ; 
        ACY  : out std_logic ; 
        cout : out std_logic ) ; 
end component; 

 begin 
A_in_s <= dat_a ; 
B_in_s <= dat_b ; 
dat_b_n_s <= not(dat_b) ; 
dat_a_n_s <= not(dat_a) ; 
A8_1 : adder8 port map (A_in => A_in_s_r , 
        B_in => B_in_s_r , 
        SUM  => SUM_s , 
        cin  => cin , 
        ACY  => ACY , 
        cout => cout_s) ; 

  process(dat_a,dat_b,op_sel,A_in_s,B_in_s,dat_b_n_s,SUM_s) 
  variable dat_xor_res:std_logic_vector(n downto 0) ; 
  variable dat_shr_res:std_logic_vector(n downto 0) ; 
  variable dat_xnor_res:std_logic_vector(n downto 0); 
  variable dat_and_res:std_logic_vector(n downto 0); 
  variable dat_nand_res:std_logic_vector(n downto 0); 
  variable dat_or_res:std_logic_vector(n downto 0); 
  variable dat_nor_res:std_logic_vector(n downto 0); 
  variable dat_out_var:std_logic_vector(n downto 0); 
  variable op_sel_int : integer := 0 ; 
  begin 
   op_sel_int := CONV_INTEGER(op_sel); 

  for i in n downto 0 loop 
   dat_xor_res(i) := dat_a(i) xor dat_b(i); 
  end loop; 

  for i in n-1 downto 0 loop 
   dat_shr_res(i) := dat_a(i+1) ; 
  end loop; 
   dat_shr_res(7) := '0' ; 

  for i in n downto 0 loop 
   dat_xnor_res(i) := not (dat_a(i) xor dat_b(i)); 
  end loop; 

  for i in n downto 0 loop 
   dat_and_res(i) := dat_a(i) and dat_b(i); 
  end loop; 

  for i in n downto 0 loop 
   dat_nand_res(i) := not (dat_a(i) and dat_b(i)); 
  end loop; 

  for i in n downto 0 loop 
   dat_or_res(i) := dat_a(i) or dat_b(i); 
  end loop; 

  for i in n downto 0 loop 
   dat_nor_res(i) := not (dat_a(i) or dat_b(i)); 
  end loop; 

case op_sel_int is 
  when 1 => 
   dat_out_var := dat_xor_res ; 
   B_in_s_r <= B_in_s ; 
   A_in_s_r <= A_in_s ; 
   cout <= '0' ; 
  when 2 => 
   dat_out_var := dat_xnor_res ; 
   B_in_s_r <= B_in_s ; 
   A_in_s_r <= A_in_s ; 
   cout <= '0' ; 
  when 3 => 
   dat_out_var := dat_and_res ; 
   B_in_s_r <= B_in_s ; 
   A_in_s_r <= A_in_s ; 
   cout <= '0' ; 
  when 4 => 
   dat_out_var := dat_nand_res ; 
   B_in_s_r <= B_in_s ; 
   A_in_s_r <= A_in_s ; 
   cout <= cout_s ; 
  when 5 => 
   dat_out_var := dat_or_res ; 
   B_in_s_r <= B_in_s ; 
   A_in_s_r <= A_in_s ; 
   cout <= '0' ; 
  when 6 => 
   dat_out_var := dat_nor_res ; 
   B_in_s_r <= B_in_s ; 
   A_in_s_r <= A_in_s ; 
   cout <= '0' ; 
  when 0 =>  -- add A + B 
   B_in_s_r <= B_in_s ; 
   dat_out_var := SUM_s ; 
   A_in_s_r <= A_in_s ; 
   cout <= cout_s ; 
  when 7 =>   -- sub A - B 
   B_in_s_r <= dat_b_n_s ; 
   dat_out_var := SUM_s ; 
   A_in_s_r <= A_in_s ; 
   cout <= cout_s ; 
  when 8 => -- not not(A) 
   B_in_s_r <= "00000000" ; 
   dat_out_var := SUM_s ; 
   A_in_s_r <= dat_a_n_s ; 
   cout <= cout_s ; 
  when 9 =>  -- inr REG + 1 
   B_in_s_r <= B_in_s ; 
   dat_out_var := SUM_s ; 
   A_in_s_r <= "00000000" ; 
   cout <= cout_s ; 
  when 10 =>  -- dcr REG - 1 
   B_in_s_r <= "11111110" ; 
   dat_out_var := SUM_s ; 
   A_in_s_r <= B_in_s; 
   cout <= cout_s ; 
  when 11 =>  -- shl A <- shl(A) 
   B_in_s_r <= A_in_s ; 
   dat_out_var := SUM_s ; 
   A_in_s_r <= A_in_s; 
   cout <= cout_s ; 
  when 12 =>  -- zero/clear 
   B_in_s_r <= "00000000" ; 
   dat_out_var := SUM_s ; 
   A_in_s_r <= "00000000"; 
   cout <= cout_s ; 
  when 13 => 
   dat_out_var := dat_shr_res ; -- SHR(A) 
   B_in_s_r <= B_in_s ; 
   A_in_s_r <= A_in_s ; 
   cout <= cout_s ; 
  when others => 
   dat_out_var := SUM_s ; 
   B_in_s_r <= "00000000" ; 
   A_in_s_r <= "00000000"; 
   cout <= cout_s ; 
end case ; 
dat_out <= dat_out_var ; 
PARITY <= dat_out_var(0) xor dat_out_var(1) xor dat_out_var(2) xor dat_out_var(3) xor dat_out_var(4) xor dat_out_var(5) xor dat_out_var(6) xor dat_out_var(7) ; 
nd <= dat_out_var ; 
end process; 
ZERO <= not (nd(0) and nd(1) and nd(2) and nd(3) and nd(4) and nd(5) and nd(6) and nd(7)) ; 
SIGN <= nd(7) ; 
end behav; 
------------------------------------------------------------ 
--DESIGN alu ENDS here 
------------------------------------------------------------ 