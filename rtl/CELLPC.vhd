------------------------------------------------------------ 
--DESIGN CELLPC BEGINS here : It is the basic building block of pch and pcl 
------------------------------------------------------------ 
library ieee; 
use ieee.std_logic_1164.all; 

entity CELLPC is 

   port( C        : out std_ulogic; 
         load_en  :in std_logic ; 
         count_en :in std_logic ; 
         data_in  :in std_logic ; 
         clrn     :in std_logic ; 
         clk      :in std_logic ); 

end CELLPC; 

architecture behav of CELLPC is 
signal C_sig: std_logic ; 

signal net20, net10 ,net16 : std_ulogic; 

begin 
  process(load_en,count_en,data_in,clrn,clk) 
      variable sel : std_logic_vector(1 downto 0) ; 
    begin 
      sel := load_en&count_en ; 
      if(clrn = '1') then 
        C_sig <= '0' ; 
      elsif(rising_edge(clk)) then 
        case sel is 
          when "00" => 
            C_sig <= C_sig; 
          when "01" => 
            C_sig <= not(C_sig); 
          when "10" => 
            C_sig <= data_in; 
          when "11" => 
            C_sig <= not(C_sig); 
          when others => 
            null ; 
        end case ; 
      end if ; 
  end process ; 
C <= C_sig ; 
end behav ; 
------------------------------------------------------------ 
--DESIGN CELLPC ENDS here 
------------------------------------------------------------ 