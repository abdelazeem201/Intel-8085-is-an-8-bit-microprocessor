# Intel-8085-is-an-8-bit-microprocessor

-- FILE NAME      : intel.vhd 

-- AUTHOR         : Ahmed Abdelazeem 

-- AUTHOR'S EMAIL : ahmedabdelazeem373@gmail.com 

-- Coyright       : Ahmed Abdelazeem 

--                               

-- This VHDL code may be freely copied as long as the copyright note isn't removed from 

-- its header. Full affiliation of anybody modifying this file shall be added to the 

-- header prior to further distribution. 

-- 

--                    Copyright (C) 2019, Ahmed Abdelazeem 

--                    e-mail:     ahmedabdelazeem373@gmail 

------------------ 

-- Following is the description of the Intel's 8085 like Microprocessor 

-- The Top Level entity is called "cpu_8085" 

-- It contains the following Instantiations 

-- 1). cpu_control    :It is the control logic of thr Processor 

-- 2). alu            :It is the Arithematic and Logic unit of the Processor 
    
    -- 2a). adder8       :It is 8 bit full adder used as the basic cell of alu 
       
       -- 2aI). FULLADD       :It is single bit full adder used as the basic cell of adder8 

-- 3a). pch            :It is the Program Counter(8 Most significant bits)used for 
                       
                       --generating the memory address 

-- 3b). pcl            :It is the Program Counter(8 Least significant bits)used for 
                       
                       --generating the memory address 
      
      --3aI).CELLPC    :It is the basic cell of the program counter. 

-- 4). SP              :It is the stack pointer register.It also has the capability 
                       
                       --to count up,count down.(16 bit) 

-- 5). REG_ARR         :It is the pile of registers inside the Processor used for progermming 
      
      -- 5a). reg8     :It is the bacic 8 bit register 

-- 6). COUNTER05       :It is the sequence generator for the control unit. 
                      
                       --It can count up and can be synchronously set to 0 
                      
                       --upon the completion of an instruction 

-- 7). trans_latch     :It is the 8 bit transparent latch 

-- 8). MUX2X1_VEC      :It is 8 bit datapath selector 

-- 9). TRI_ARR         :It is the 8 bit tri-state datapath 

-- 10). add_latch_high :It is a latch to hold the higher 8 address bits 
