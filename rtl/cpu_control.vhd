------------------------------------------------------------ 
--DESIGN cpu_control BEGINS here: HARD WIRED CONTROL UNIT 
------------------------------------------------------------ 
library ieee; 
use ieee.std_logic_1164.all; 

entity cpu_control is 
  port( 
        ID_OUT_S               : in std_logic_vector(7 downto 0) ; 
        DEC5X32_IN             : in std_logic_vector(4 downto 0) ; 
        clk                    : in std_logic ; 

       s0         : out std_logic ; 
       s1         : out std_logic ; 
       iomn       : out std_logic ; 
       RESETOUT   : out std_logic ; 
       CLK_OUT    : out std_logic ; 
       SOD        : in std_logic ; 
       SID        : in std_logic ; 
       HOLD       : in std_logic ; 
       HOLDA      : out std_logic ; 
       TRAP       : in std_logic ; 
       RST7_5     : in std_logic ; 
       RST6_5     : in std_logic ; 
       RST5_5     : in std_logic ; 
       INTR       : in std_logic ; 
       INTA       : out std_logic ; 
       ACY        : in std_logic ; 
       SIGN       : in std_logic ; 
       PARITY     : in std_logic ; 
       ZERO       : in std_logic ; 
       CY         : in std_logic ; 
       CIN        : out std_logic ; 
       LOAD_FL    : out std_logic ; 
       SEL_HI_ADD : out std_logic_vector(2 downto 0 ) ; 

        LATCH_LOW_ADD          : out std_logic ; 
        ZERO_SEQ_COUNTER       : out std_logic ; 
        ALE                    : out std_logic ; 
        RDn                    : out std_logic ; 
        WRn                    : out std_logic ; 
        OP_SEL                 : out std_logic_vector(3 downto 0) ; 
        SEL_DATAOUT_ALU_OUT    : out std_logic ; 
        EN_FROM_OUT            : out std_logic ; 
        LOAD_REG_T             : out std_logic ; 
        LOAD_REG_ID            : out std_logic ; 
        INR_PC                 : out std_logic ; 
        DCR_SP                 : out std_logic ; 
        EN_OUT_BUS             : out std_logic ; 
        EN_IN_BUS              : out std_logic ; 
        clkn                   : out std_logic ; 
        SEL_IN                 : out std_logic_vector(4 downto 0) ; 
        SEL_OUT                : out std_logic_vector(4 downto 0)) ; 
end cpu_control ; 

architecture behav of cpu_control is 
begin 
clkn <= not(clk) ; 
process(DEC5X32_IN,ID_OUT_S) 
variable CONTROL_WORD : std_logic_vector(35 downto 0) ; 
variable INTR_WORD    : std_logic_vector(4 downto 0) ; 
  begin 
    INTR_WORD := TRAP&RST7_5&RST6_5&RST5_5&INTR ; 
    case DEC5X32_IN is 
    when "00000" => 
    case ID_OUT_S is 
       when  "11001101" => --  CALL 
         CONTROL_WORD := "010001000111011000000011010110011010" ; 

    when others => 
        CONTROL_WORD := "010001000111001000000011111110101110" ; 
    end case ; 

    --     CONTROL_WORD := "010001000111001000000011111110101110" ; 
--                        al ef ei eo ip li lt op_s  rn sd s_in   s_ou   wr z 
    when "00001" => 
      CASE INTR_WORD is 
       when "00001" => 
         CONTROL_WORD := "000000001110100110000011111110101110" ; 
       when others => 
         CONTROL_WORD := "000001000110100110000001111110101110" ; 
      end CASE ; 
--                        al ef ei eo ip li lt op_s  rn sd s_in   s_ou   wr z 
--         CONTROL_WORD := "000001000110000110000001111110101110" ; 
--                        al ef ei eo ip li lt op_s  rn sd s_in   s_ou   wr z 
    when "00010" => 
      CASE INTR_WORD is 
       when "00001" => 
         CONTROL_WORD := "000000001110000000000011111110101110" ; 
       when others => 
         CONTROL_WORD := "000001000110000000000001111110101110" ; 
      end CASE ; 
--         CONTROL_WORD := "000001000110000010000001111110101110" ; 
--                        al ef ei eo ip li lt op_s  rn sd s_in   s_ou   wr z 
----------------------------------------------------------------- 
    when "00011" =>   -- 4th T STATE 
----------------------------------------------------------------- 
    case ID_OUT_S is 
       when  "01111111" => --  mov a,a 
         CONTROL_WORD := "000001000110010000000011001110011111" ; 
--                        aeeeili lt op_s  rn sd s_in   s_ou   wr z 
--                        lfiopi o  p  i 
       when  "01111000" => --  mov a,b 
         CONTROL_WORD := "000001000110010000000011001110000011" ; 

       when  "01111001" => --  mov a,c 
         CONTROL_WORD := "000001000110010000000011001110000111" ; 

       when  "01111010" => --  mov a,d 
         CONTROL_WORD := "000001000110010000000011001110001011" ; 

       when  "01111011" => --  mov a,e 
         CONTROL_WORD := "000001000110010000000011001110001111" ; 

       when  "01111100" => --  mov a,h 
         CONTROL_WORD := "000001000110010000000011001110010011" ; 

       when  "01111101" => --  mov a,l 
         CONTROL_WORD := "000001000110010000000011001110010111" ; 

       when  "01000111" => --  mov b,a 
         CONTROL_WORD := "000001000110010000000011000000011111" ; 

       when  "01000000" => --  mov b,b 
         CONTROL_WORD := "000001000110010000000011000000000011" ; 

       when  "01000001" => --  mov b,c 
         CONTROL_WORD := "000001000110010000000011000000000111" ; 

       when  "01000010" => --  mov b,d 
         CONTROL_WORD := "000001000110010000000011000000001011" ; 

       when  "01000011" => --  mov b,e 
         CONTROL_WORD := "000001000110010000000011000000001111" ; 

       when  "01000100" => --  mov b,h 
         CONTROL_WORD := "000001000110010000000011000000010011" ; 

       when  "01000101" => --  mov b,l 
         CONTROL_WORD := "000001000110010000000011000000010111" ; 

       when  "01001111" => --  mov c,a 
         CONTROL_WORD := "000001000110010000000011000010011111" ; 

       when  "01001000" => --  mov c,b 
         CONTROL_WORD := "000001000110010000000011000010000011" ; 

       when  "01001001" => --  mov c,c 
         CONTROL_WORD := "000001000110010000000011000010000111" ; 

       when  "01001010" => --  mov c,d 
         CONTROL_WORD := "000001000110010000000011000010001011" ; 

       when  "01001011" => --  mov c,e 
         CONTROL_WORD := "000001000110010000000011000010001111" ; 

       when  "01001100" => --  mov c,h 
         CONTROL_WORD := "000001000110010000000011000010010011" ; 

       when  "01001101" => --  mov c,l 
         CONTROL_WORD := "000001000110010000000011000010010111" ; 

       when  "01010111" => --  mov d,a 
         CONTROL_WORD := "000001000110010000000011000100011111" ; 

       when  "01010000" => --  mov d,b 
         CONTROL_WORD := "000001000110010000000011000100000011" ; 

       when  "01010001" => --  mov d,c 
         CONTROL_WORD := "000001000110010000000011000100000111" ; 

       when  "01010010" => --  mov d,d 
         CONTROL_WORD := "000001000110010000000011000100001011" ; 

       when  "01010011" => --  mov d,e 
         CONTROL_WORD := "000001000110010000000011000100001111" ; 

       when  "01010100" => --  mov d,h 
         CONTROL_WORD := "000001000110010000000011000100010011" ; 

       when  "01010101" => --  mov d,l 
         CONTROL_WORD := "000001000110010000000011000100010111" ; 

       when  "01011111" => --  mov e,a 
         CONTROL_WORD := "000001000110010000000011000110011111" ; 

       when  "01011000" => --  mov e,b 
         CONTROL_WORD := "000001000110010000000011000110000011" ; 

       when  "01011001" => --  mov e,c 
         CONTROL_WORD := "000001000110010000000011000110000111" ; 

       when  "01011010" => --  mov e,d 
         CONTROL_WORD := "000001000110010000000011000110001011" ; 

       when  "01011011" => --  mov e,e 
         CONTROL_WORD := "000001000110010000000011000110001111" ; 

       when  "01011100" => --  mov e,h 
         CONTROL_WORD := "000001000110010000000011000110010011" ; 

       when  "01011101" => --  mov e,l 
         CONTROL_WORD := "000001000110010000000011000110010111" ; 

       when  "01100111" => --  mov h,a 
         CONTROL_WORD := "000001000110010000000011001000011111" ; 

       when  "01100000" => --  mov h,b 
         CONTROL_WORD := "000001000110010000000011001000000011" ; 

       when  "01100001" => --  mov h,c 
         CONTROL_WORD := "000001000110010000000011001000000111" ; 

       when  "01100010" => --  mov h,d 
         CONTROL_WORD := "000001000110010000000011001000001011" ; 

       when  "01100011" => --  mov h,e 
         CONTROL_WORD := "000001000110010000000011001000001111" ; 

       when  "01100100" => --  mov h,h 
         CONTROL_WORD := "000001000110010000000011001000010011" ; 

       when  "01100101" => --  mov h,l 
         CONTROL_WORD := "000001000110010000000011001000010111" ; 

       when  "01101111" => --  mov l,a 
         CONTROL_WORD := "000001000110010000000011001010011111" ; 

       when  "01101000" => --  mov l,b 
         CONTROL_WORD := "000001000110010000000011001010000011" ; 

       when  "01101001" => --  mov l,c 
         CONTROL_WORD := "000001000110010000000011001010000111" ; 

       when  "01101010" => --  mov l,d 
         CONTROL_WORD := "000001000110010000000011001010001011" ; 

       when  "01101011" => --  mov l,e 
         CONTROL_WORD := "000001000110010000000011001010001111" ; 

       when  "01101100" => --  mov l,h 
         CONTROL_WORD := "000001000110010000000011001010010011" ; 

       when  "01101101" => --  mov l,l 
         CONTROL_WORD := "000001000110010000000011001010010111" ; 

       when  "00111110" => --  MVI A 
         CONTROL_WORD := "000001000110000000000011111110101110" ; 

       when  "00000110" => --  MVI B 
         CONTROL_WORD := "000001000110000000000011111110101110" ; 

       when  "00001110" => --  MVI C 
         CONTROL_WORD := "000001000110000000000011111110101110" ; 

       when  "00010110" => --  MVI D 
         CONTROL_WORD := "000001000110000000000011111110101110" ; 

       when  "00011110" => --  MVI E 
         CONTROL_WORD := "000001000110000000000011111110101110" ; 

       when  "00100110" => --  MVI H 
         CONTROL_WORD := "000001000110000000000011111110101110" ; 

       when  "00101110" => --  MVI L 
         CONTROL_WORD := "000001000110000000000011111110101110" ; 

       when  "01110111" => --  MOV M,A 
         CONTROL_WORD := "000111000110000000000011111110010110" ; 

       when  "11011010" => --  JC 
      if (CY = '1') then 
         CONTROL_WORD := "000001000110000000000011111110101110" ; 
      elsif (CY = '0') then 
         CONTROL_WORD := "000001000110000000000011111110101110" ; 
      end if ; 

       when  "11111010" => --  JM Jump on minus 
      if (SIGN = '1') then 
         CONTROL_WORD := "000001000110000000000011111110101110" ; 
      elsif (SIGN = '0') then 
         CONTROL_WORD := "000001000110000000000011111110101110" ; 
      end if ; 

       when  "11101010" => --  JPE 
      if (PARITY = '1') then 
         CONTROL_WORD := "000001000110000000000011111110101110" ; 
      elsif (PARITY = '0') then 
         CONTROL_WORD := "000001000110000000000011111110101110" ; 
      end if ; 

       when  "11001010" => --  JZ 
      if (ZERO = '1') then 
         CONTROL_WORD := "000001000110000000000011111110101110" ; 
      elsif (ZERO = '0') then 
         CONTROL_WORD := "000001000110000000000011111110101110" ; 
      end if ; 

       when  "11000010" => --  JNZ 
      if (ZERO = '0') then 
         CONTROL_WORD := "000001000110000000000011111110101110" ; 
      elsif (ZERO = '1') then 
         CONTROL_WORD := "000001000110000000000011111110101110" ; 
      end if ; 

       when  "11001101" => --  CALL 
         CONTROL_WORD := "000001000110000000000011010101111110" ; 

       when  "11001001" => --  RET 
         CONTROL_WORD := "100001000110000000000011111111111110" ; 

--       when  "11001001" => --  RST0 
 --        CONTROL_WORD := "100001000110000000000011111111111110" ; 
  

----------------------------------------------------------------- 
-- ARITHMATIC/LOGIC OPERATIONS FOLLOWS 
----------------------------------------------------------------- 
       when  "00111101" => --  DCR A 
         CONTROL_WORD := "000001110110010001101010001110011111" ; 

       when  "00000101" => --  DCR B 
         CONTROL_WORD := "000001110110010001101010000000000011" ; 

       when  "00001101" => --  DCR C 
         CONTROL_WORD := "000001110110010001101010000010000111" ; 

       when  "00010101" => --  DCR D 
         CONTROL_WORD := "000001110110010001101010000100001011" ; 

       when  "00011101" => --  DCR E 
         CONTROL_WORD := "000001110110010001101010000110001111" ; 

       when  "00100101" => --  DCR H 
         CONTROL_WORD := "000001110110010001101010001000010011" ; 

       when  "00101101" => --  DCR L 
         CONTROL_WORD := "000001110110010001101010001010010111" ; 

       when  "00111100" => --  INR A 
         CONTROL_WORD := "000001110110010001100110001110011111" ; 

       when  "00000100" => --  INR B 
         CONTROL_WORD := "000001110110010001100110000000000011" ; 

       when  "00001100" => --  INR C 
         CONTROL_WORD := "000001110110010001100110000010000111" ; 

       when  "00010100" => --  INR D 
         CONTROL_WORD := "000001110110010001100110000100001011" ; 

       when  "00011100" => --  INR E 
         CONTROL_WORD := "000001110110010001100110000110001111" ; 

       when  "00100100" => --  INR H 
         CONTROL_WORD := "000001110110010001100110001000010011" ; 

       when  "00101100" => --  INR L 
         CONTROL_WORD := "000001110110010001100110001010010111" ; 

       when  "10010111" => --  SUB A 
         CONTROL_WORD := "000001110110010001011110001110011111" ; 

       when  "10010000" => --  SUB B 
         CONTROL_WORD := "000001110110010001011110001110000011" ; 

       when  "10010001" => --  SUB C 
         CONTROL_WORD := "000001110110010001011110001110000111" ; 

       when  "10010010" => --  SUB D 
         CONTROL_WORD := "000001110110010001011110001110001011" ; 

       when  "10010011" => --  SUB E 
         CONTROL_WORD := "000001110110010001011110001110001111" ; 

       when  "10010100" => --  SUB H 
         CONTROL_WORD := "000001110110010001011110001110010011" ; 

       when  "10010101" => --  SUB L 
         CONTROL_WORD := "000001110110010001011110001110010111" ; 

       when  "10000111" => --  ADD A 
        CONTROL_WORD := "000001100110010001000010001110011111" ; 

       when  "10000000" => --  ADD B 
        CONTROL_WORD := "000001100110010001000010001110000011" ; 

       when  "10000001" => --  ADD C 
        CONTROL_WORD := "000001100110010001000010001110000111" ; 

       when  "10000010" => --  ADD D 
        CONTROL_WORD := "000001100110010001000010001110001011" ; 

       when  "10000011" => --  ADD E 
        CONTROL_WORD := "000001100110010001000010001110001111" ; 

       when  "10000100" => --  ADD H 
        CONTROL_WORD := "000001100110010001000010001110010011" ; 

       when  "10000101" => --  ADD L 
        CONTROL_WORD := "000001100110010001000010001110010111" ; 

       when  "10110111" => --  ORA A 
        CONTROL_WORD := "000001100110010001010110001110011111" ; 

       when  "10110000" => --  ORA B 
        CONTROL_WORD := "000001100110010001010110001110000011" ; 

       when  "10110001" => --  ORA C 
        CONTROL_WORD := "000001100110010001010110001110000111" ; 

       when  "10110010" => --  ORA D 
        CONTROL_WORD := "000001100110010001010110001110001011" ; 

       when  "10110011" => --  ORA E 
        CONTROL_WORD := "000001100110010001010110001110001111" ; 

       when  "10110100" => --  ORA H 
        CONTROL_WORD := "000001100110010001010110001110010011" ; 

       when  "10110101" => --  ORA L 
        CONTROL_WORD := "000001100110010001010110001110010111" ; 

       when  "10101111" => --  XRA A 
        CONTROL_WORD := "000001100110010001000110001110011111" ; 

       when  "10101000" => --  XRA B 
        CONTROL_WORD := "000001100110010001000110001110000011" ; 

       when  "10101001" => --  XRA C 
        CONTROL_WORD := "000001100110010001000110001110000111" ; 

       when  "10101010" => --  XRA D 
        CONTROL_WORD := "000001100110010001000110001110001011" ; 

       when  "10101011" => --  XRA E 
        CONTROL_WORD := "000001100110010001000110001110001111" ; 

       when  "10101100" => --  XRA H 
        CONTROL_WORD := "000001100110010001000110001110010011" ; 

       when  "10101101" => --  XRA L 
        CONTROL_WORD := "000001100110010001000110001110010111" ; 

       when  "10100111" => --  ANA A 
        CONTROL_WORD := "000001100110010001001111111110011111" ; 

       when  "10100000" => --  ANA B 
        CONTROL_WORD := "000001100110010001001111111110000011" ; 

       when  "10100001" => --  ANA C 
        CONTROL_WORD := "000001100110010001001111111110000111" ; 

       when  "10100010" => --  ANA D 
        CONTROL_WORD := "000001100110010001001111111110001011" ; 

       when  "10100011" => --  ANA E 
        CONTROL_WORD := "000001100110010001001111111110001111" ; 

       when  "10100100" => --  ANA H 
        CONTROL_WORD := "000001100110010001001111111110010011" ; 

       when  "10100101" => --  ANA L 
        CONTROL_WORD := "000001100110010001001111111110010111" ; 

    when others => 
        CONTROL_WORD := "000001000000000000000010111111111110" ; 
    end case ; 

----------------------------------------------------------------- 
    when "00100" =>   -- 5th T STATE 
----------------------------------------------------------------- 
    case ID_OUT_S is 
       when  "00111110" => --  MVI A 
        CONTROL_WORD := "010001000101001100000011111110101110" ; 

       when  "00000110" => --  MVI B 
        CONTROL_WORD := "010001000101001100000011111110101110" ; 

       when  "00001110" => --  MVI C 
        CONTROL_WORD := "010001000101001100000011111110101110" ; 

       when  "00010110" => --  MVI D 
        CONTROL_WORD := "010001000101001100000011111110101110" ; 

       when  "00011110" => --  MVI E 
        CONTROL_WORD := "010001000101001100000011111110101110" ; 

       when  "00100110" => --  MVI H 
        CONTROL_WORD := "010001000101001100000011111110101110" ; 

       when  "00101110" => --  MVI L 
        CONTROL_WORD := "010001000101001100000011111110101110" ; 

       when  "01110111" => --  MOV M,A 
        CONTROL_WORD := "010111000101001000000011111110010110" ; 

       when  "11011010" => --  JC 
      if (CY = '1') then 
        CONTROL_WORD := "010001000101001100000011111110101110" ; 
      elsif (CY = '0') then 
        CONTROL_WORD := "001001000110000100000011111110010110" ; 
      end if ; 

       when  "11111010" => --  JM 
      if (SIGN = '1') then 
        CONTROL_WORD := "010001000101001100000011111110101110" ; 
      elsif (SIGN = '0') then 
        CONTROL_WORD := "001001000110000100000011111110010110" ; 
      end if ; 

       when  "11101010" => --  JPE 
      if (PARITY = '1') then 
        CONTROL_WORD := "010001000101001100000011111110101110" ; 
      elsif (PARITY = '0') then 
        CONTROL_WORD := "001001000110000100000011111110010110" ; 
      end if ; 

       when  "11001010" => --  JZ 
      if (ZERO = '1') then 
        CONTROL_WORD := "010001000101001100000011111110101110" ; 
      elsif (ZERO = '0') then 
        CONTROL_WORD := "001001000110000100000011111110010110" ; 
      end if ; 

       when  "11000010" => --  JNZ 
      if (ZERO = '0') then 
        CONTROL_WORD := "010001000101001100000011111110101110" ; 
      elsif (ZERO = '1') then 
        CONTROL_WORD := "001001000110000100000011111110010110" ; 
      end if ; 

       when  "11001101" => --  CALL 
         CONTROL_WORD := "000001000110000000000011111111111110" ; 
  
  

    when others => 
        CONTROL_WORD := "000001000000000000000010111111111110" ; 
    end case ; 

----------------------------------------------------------------- 
    when "00101" =>  -- 6th T STATE 
----------------------------------------------------------------- 
    case ID_OUT_S is 
       when  "00111110" => --  MVI A 
        CONTROL_WORD := "000001000100100000000001001111111110" ; 

       when  "00000110" => --  MVI B 
        CONTROL_WORD := "000001000100100000000001000001111110" ; 

       when  "00001110" => --  MVI C 
        CONTROL_WORD := "000001000100100000000001000011111110" ; 

       when  "00010110" => --  MVI D 
        CONTROL_WORD := "000001000100100000000001000101111110" ; 

       when  "00011110" => --  MVI E 
        CONTROL_WORD := "000001000100100000000001000111111110" ; 

       when  "00100110" => --  MVI H 
        CONTROL_WORD := "000001000100100000000001001001111110" ; 

       when  "00101110" => --  MVI L 
        CONTROL_WORD := "000001000100100000000001001011111110" ; 

       when  "01110111" => --  MOV M,A 
        CONTROL_WORD := "000111000100001000000011111110011100" ; 
  

       when  "11011010" => --  JC 
      if (CY = '1') then 
        CONTROL_WORD := "010001000100100000000001010110101110" ; 
      elsif (CY = '0') then 
        CONTROL_WORD := "000001000110000100000011111110010110" ; 
      end if ; 

       when  "11111010" => --  JM 
      if (SIGN = '1') then 
        CONTROL_WORD := "010001000100100000000001010110101110" ; 
      elsif (SIGN = '0') then 
        CONTROL_WORD := "000001000110000100000011111110010110" ; 
      end if ; 

       when  "11101010" => --  JPE 
      if (PARITY = '1') then 
        CONTROL_WORD := "010001000100100000000001010110101110" ; 
      elsif (PARITY = '0') then 
        CONTROL_WORD := "000001000110000100000011111110010110" ; 
      end if ; 

       when  "11001010" => --  JZ 
      if (ZERO = '1') then 
        CONTROL_WORD := "010001000100100000000001010110101110" ; 
      elsif (ZERO = '0') then 
        CONTROL_WORD := "000001000110000100000011111110010110" ; 
      end if ; 

       when  "11000010" => --  JNZ 
      if (ZERO = '0') then 
        CONTROL_WORD := "010001000100100000000001010110101110" ; 
      elsif (ZERO = '1') then 
        CONTROL_WORD := "000001000110000100000011111110010110" ; 
      end if ; 

       when  "11001101" => --  CALL 
         CONTROL_WORD := "000001000110000000000011010101111110" ; 
  
  

    when others => 
        CONTROL_WORD := "000001000000000000000010111111111110" ; 
    end case ; 
  

----------------------------------------------------------------- 
    when "00110" =>  -- 7th T STATE 
----------------------------------------------------------------- 
    case ID_OUT_S is 
       when  "00111110" => --  MVI A 
        CONTROL_WORD := "000001000100100000000001001111111111" ; 

       when  "00000110" => --  MVI B 
        CONTROL_WORD := "000001000100100000000001000001111111" ; 

       when  "00001110" => --  MVI C 
        CONTROL_WORD := "000001000100100000000001000011111111" ; 

       when  "00010110" => --  MVI D 
        CONTROL_WORD := "000001000100100000000001000101111111" ; 

       when  "00011110" => --  MVI E 
        CONTROL_WORD := "000001000100100000000001000111111111" ; 

       when  "00100110" => --  MVI H 
        CONTROL_WORD := "000001000100100000000001001001111111" ; 

       when  "00101110" => --  MVI L 
        CONTROL_WORD := "000001000100100000000001001011111111" ; 

       when  "01110111" => --  MOV M,A 
        CONTROL_WORD := "000111000100001000000011111110011101" ; 
  

       when  "11011010" => --  JC 
      if (CY = '1') then 
        CONTROL_WORD := "000001000100100000000001010110101110" ; 
      elsif (CY = '0') then 
        CONTROL_WORD := "000001000110000000000011111110010111" ; 
      end if ; 

       when  "11111010" => --  JM 
      if (SIGN = '1') then 
        CONTROL_WORD := "000001000100100000000001010110101110" ; 
      elsif (SIGN = '0') then 
        CONTROL_WORD := "000001000110000000000011111110010111" ; 
      end if ; 

       when  "11101010" => --  JPE 
      if (PARITY = '1') then 
        CONTROL_WORD := "000001000100100000000001010110101110" ; 
      elsif (PARITY = '0') then 
        CONTROL_WORD := "000001000110000000000011111110010111" ; 
      end if ; 

       when  "11001010" => --  JZ 
      if (ZERO = '1') then 
        CONTROL_WORD := "000001000100100000000001010110101110" ; 
      elsif (ZERO = '0') then 
        CONTROL_WORD := "000001000110000000000011111110010111" ; 
      end if ; 

       when  "11000010" => --  JNZ 
      if (ZERO = '0') then 
        CONTROL_WORD := "000001000100100000000001010110101110" ; 
      elsif (ZERO = '1') then 
        CONTROL_WORD := "000001000110000000000011111110010111" ; 
      end if ; 

       when  "11001101" => --  CALL 
         CONTROL_WORD := "010001000111001000000011111110101110" ; 
  

    when others => 
        CONTROL_WORD := "000001000000000000000010111111111110" ; 
----                        al ef ei eo ip li lt op_s  rn sd s_in   s_ou   wr z 
--         CONTROL_WORD := "000001000000  0  0  0  0  0  0  0000  0  0  00000  00000  0  0" ; 
----                        0  1  2  3  4  5  6  7-10  11 12 13-17  19-22  23 24 
----                        24 23 22 21 20 19 18 1714  13 12 11-07  06-02   1  0 
----------------------------------------------------------------- 
    end case ; 

----------------------------------------------------------------- 
    when "00111" =>  -- 8th T STATE 
----------------------------------------------------------------- 
    case ID_OUT_S is 
       when  "11011010" => --  JC 
        CONTROL_WORD := "000001000101001000000011111110101110" ; 

       when  "11111010" => --  JM 
        CONTROL_WORD := "000001000101001000000011111110101110" ; 

       when  "11101010" => --  JPE 
        CONTROL_WORD := "000001000101001000000011111110101110" ; 

       when  "11001010" => --  JZ 
        CONTROL_WORD := "000001000101001000000011111110101110" ; 

       when  "11000010" => --  JNZ 
        CONTROL_WORD := "000001000101001000000011111110101110" ; 

       when  "11001101" => --  CALL 
         CONTROL_WORD := "000001000110100100000001001101111110" ; 

    when others => 
        CONTROL_WORD := "000001000000000000000010111111111110" ; 
    end case ; 

----------------------------------------------------------------- 
    when "01000" =>  -- 9th T STATE 
----------------------------------------------------------------- 
    case ID_OUT_S is 
       when  "11011010" => --  JC 
        CONTROL_WORD := "000001000100100000000001011000101110" ; 

       when  "11111010" => --  JM 
        CONTROL_WORD := "000001000100100000000001011000101110" ; 

       when  "11101010" => --  JPE 
        CONTROL_WORD := "000001000100100000000001011000101110" ; 

       when  "11001010" => --  JZ 
        CONTROL_WORD := "000001000100100000000001011000101110" ; 

       when  "11000010" => --  JNZ 
        CONTROL_WORD := "000001000100100000000001011000101110" ; 

       when  "11001101" => --  CALL 
         CONTROL_WORD := "000001000110100000000001001101111110" ; 

    when others => 
        CONTROL_WORD := "000001000000000000000010111111111110" ; 
    end case ; 

----------------------------------------------------------------- 
    when "01001" =>  -- 10th T STATE 
----------------------------------------------------------------- 
    case ID_OUT_S is 
       when  "11011010" => --  JC 
        CONTROL_WORD := "000001000100000000000001111111111111" ; 

       when  "11111010" => --  JM 
        CONTROL_WORD := "000001000100000000000001111111111111" ; 

       when  "11101010" => --  JPE 
        CONTROL_WORD := "000001000100000000000001111111111111" ; 

       when  "11001010" => --  JZ 
        CONTROL_WORD := "000001000100000000000001111111111111" ; 

       when  "11000010" => --  JNZ 
        CONTROL_WORD := "000001000100000000000001111111111111" ; 

       when  "11001101" => --  CALL 
         CONTROL_WORD := "010001000111001000000011111110101110" ; 

    when others => 
        CONTROL_WORD := "000001000000000000000010111111111110" ; 
    end case ; 

----------------------------------------------------------------- 
    when "01010" =>  -- 11th T STATE 
----------------------------------------------------------------- 
    case ID_OUT_S is 
       when  "11001101" => --  CALL 
         CONTROL_WORD := "000001000110100100000001011010101110" ; 

    when others => 
        CONTROL_WORD := "000001000000000000000010111111111110" ; 
    end case ; 

----------------------------------------------------------------- 
    when "01011" =>  -- 12th T STATE 
----------------------------------------------------------------- 
    case ID_OUT_S is 
       when  "11001101" => --  CALL 
         CONTROL_WORD := "001001000110100000000001011010101110" ; 

    when others => 
        CONTROL_WORD := "000001000000000000000010111111111110" ; 
    end case ; 

----------------------------------------------------------------- 
    when "01100" =>  -- 13th T STATE 
----------------------------------------------------------------- 
    case ID_OUT_S is 
       when  "11001101" => --  CALL 
         CONTROL_WORD := "011001000111001000000011010100100110" ; 

    when others => 
        CONTROL_WORD := "000001000000000000000010111111111110" ; 
    end case ; 

----------------------------------------------------------------- 
    when "01101" =>  -- 14th T STATE 
----------------------------------------------------------------- 
    case ID_OUT_S is 
       when  "11001101" => --  CALL 
         CONTROL_WORD := "011001000110001000000011111110110000" ; 

    when others => 
        CONTROL_WORD := "010001000000000000000010111111111110" ; 
    end case ; 

----------------------------------------------------------------- 
    when "01110" =>  -- 15th T STATE 
----------------------------------------------------------------- 
    case ID_OUT_S is 
       when  "11001101" => --  CALL 
         CONTROL_WORD := "001001000110001000000011111110110000" ; 

    when others => 
        CONTROL_WORD := "000001000000000000000010111111111110" ; 
    end case ; 

----------------------------------------------------------------- 
    when "01111" =>  -- 16th T STATE 
----------------------------------------------------------------- 
    case ID_OUT_S is 
       when  "11001101" => --  CALL 
         CONTROL_WORD := "011001000111001000000011111110100110" ; 

    when others => 
        CONTROL_WORD := "010001000110100000000011111110110000" ; 
    end case ; 

----------------------------------------------------------------- 
    when "10000" =>  -- 17th T STATE 
----------------------------------------------------------------- 
    case ID_OUT_S is 
       when  "11001101" => --  CALL 
         CONTROL_WORD := "011001000110001000000011111110101100" ; 

    when others => 
        CONTROL_WORD := "000001000000000000000010111111111110" ; 
    end case ; 

----------------------------------------------------------------- 
    when "10001" =>  -- 18th T STATE 
----------------------------------------------------------------- 
    case ID_OUT_S is 
       when  "11001101" => --  CALL 
         CONTROL_WORD := "001001000110011000000011011000110101" ; 

    when others => 
        CONTROL_WORD := "000001000000000000000010111111111110" ; 
    end case ; 

 when others => 
        CONTROL_WORD := "000001000000000000000010111111111111" ; 
 end case ; 
  

DCR_SP              <= CONTROL_WORD(35) ; 
LATCH_LOW_ADD       <= CONTROL_WORD(34) ; 
for i in 33 downto 31 loop 
SEL_HI_ADD(i-31)        <= CONTROL_WORD(i) ; 
end loop ; 

INTA                <= CONTROL_WORD(30) ; 
LOAD_FL             <= CONTROL_WORD(29) ; 
CIN                 <= CONTROL_WORD(28) ; 
iomn                <= CONTROL_WORD(27) ; 
s1                  <= CONTROL_WORD(26) ; 
s0                  <= CONTROL_WORD(25) ; 
ALE                 <= CONTROL_WORD(24) ; 
EN_FROM_OUT         <= CONTROL_WORD(23) ; 
EN_IN_BUS           <= CONTROL_WORD(22) ; 
EN_OUT_BUS          <= CONTROL_WORD(21) ; 
INR_PC              <= CONTROL_WORD(20) ; 
LOAD_REG_ID         <= CONTROL_WORD(19) ; 
LOAD_REG_T          <= CONTROL_WORD(18) ; 

for i in 17 downto 14 loop 
 OP_SEL(i-14)        <= CONTROL_WORD(i) ; 
end loop ; 

RDn                 <= CONTROL_WORD(13) ; 
SEL_DATAOUT_ALU_OUT <= CONTROL_WORD(12) ; 

for i in 11 downto 7 loop 
 SEL_IN(i-7)        <= CONTROL_WORD(i) ; 
end loop ; 

for i in 6 downto 2 loop 
 SEL_OUT(i-2)        <= CONTROL_WORD(i) ; 
end loop ; 

WRn                 <= CONTROL_WORD(1) ; 
ZERO_SEQ_COUNTER    <= CONTROL_WORD(0) ; 
end process ; 
end behav ; 
------------------------------------------------------------ 
--DESIGN cpu_control ENDS here 
------------------------------------------------------------