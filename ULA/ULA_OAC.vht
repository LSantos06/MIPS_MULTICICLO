-- Copyright (C) 1991-2011 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "10/18/2016 21:03:45"
                                                            
-- Vhdl Test Bench template for design  :  ULA_OAC
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY ULA_OAC_vhd_tst IS
END ULA_OAC_vhd_tst;

ARCHITECTURE ULA_OAC_arch OF ULA_OAC_vhd_tst IS
-- constants                                                 
-- signals                                                   
	SIGNAL A : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL B : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL opcode : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL ovfl : STD_LOGIC;
	SIGNAL vai : STD_LOGIC;
	SIGNAL Z : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL zero : STD_LOGIC;

	COMPONENT ULA_OAC
		PORT (
			A : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			opcode : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			ovfl : OUT STD_LOGIC;
			vai : OUT STD_LOGIC;
			Z : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			zero : OUT STD_LOGIC
		);
	END COMPONENT;

BEGIN
	i1 : ULA_OAC
	PORT MAP (
-- list connections between master ports and signals
		A => A,
		B => B,
		opcode => opcode,
		ovfl => ovfl,
		vai => vai,
		Z => Z,
		zero => zero
	);
	
init : PROCESS                                               
-- variable declarations                                     
	BEGIN                                                        
        -- code that executes only once    
       
        -- TESTANDO AND
		A <= X"FFFF0000"; B <= X"FF00FF00"; opcode <= "0000"; wait for 100 ns; 
        -- and = Z => 0xFF000000       
		A <= X"FFFF0000"; B <= X"0000FFFF"; opcode <= "0000"; wait for 100 ns; 
        -- and = Z => 0x0 , zero = 1  		

        -- TESTANDO OR
		A <= X"FFFF0000"; B <= X"FF00FF00"; opcode <= "0001"; wait for 100 ns; 
        -- or = Z => 0xFFFFFF00
		A <= X"FFFF0000"; B <= X"0000FFFF"; opcode <= "0001"; wait for 100 ns; 
        -- or = Z => 0xFFFFFFFF		

        -- TESTANDO ADD
		-- zero
		A <= X"00000000"; B <= X"00000000"; opcode <= "0010"; wait for 100 ns; 
        -- add = Z => 0x0, zero = 1
		
		-- negativo
		A <= X"FFFFFFFF"; B <= X"FFFFFFFF"; opcode <= "0010"; wait for 100 ns; 
        -- add = Z => 0xFFFFFFFE, carry = 1
		
		-- positivo
		A <= X"0000FFFF"; B <= X"0000FFFF"; opcode <= "0010"; wait for 100 ns; 
        -- add = Z => 0x1FFFE
		
		-- overflow
        -- P + P = N        
		A <= X"7FFFFFFF"; B <= X"7FFFFFFF"; opcode <= "0010"; wait for 100 ns; 
        -- add = Z => 0xFFFFFFFE, ovfl = 1, carry = 0

		-- overflow
        -- N + N = P
		A <= X"80000000"; B <= X"80000000"; opcode <= "0010"; wait for 100 ns; 
        -- add = Z => 0x100000000, ovfl = 1, carry = 1

		-- TESTANDO ADDU
		-- zero
		A <= X"00000000"; B <= X"00000000"; opcode <= "0011"; wait for 100 ns; 
        -- add = Z => 0x0, zero = 1
		
		-- negativo
		A <= X"FFFFFFFF"; B <= X"FFFFFFFF"; opcode <= "0011"; wait for 100 ns; 
        -- add = Z => 0xFFFFFFFE, carry = 1
		
		-- positivo
		A <= X"0000FFFF"; B <= X"0000FFFF"; opcode <= "0011"; wait for 100 ns; 
        -- add = Z => 0x1FFFE		
		
		-- overflow
        -- P + P = N   
		A <= X"7FFFFFFF"; B <= X"7FFFFFFF"; opcode <= "0011"; wait for 100 ns; 
        -- addu = Z => 0xFFFFFFFE, ovfl = 0, carry = 0		
        
		-- overflow
		-- N + N = P
        A <= X"80000000"; B <= X"80000000"; opcode <= "0011"; wait for 100 ns; 
        -- addu = Z => 0x100000000, ovfl = 0, carry = 1
		
        -- TESTANDO SUB
		-- zero
		A <= X"FFFFFFFF"; B <= X"FFFFFFFF"; opcode <= "0100"; wait for 100 ns; 
        -- add = Z => 0x00000000, zero = 1
		
		-- negativo
		A <= X"00000000"; B <= X"00000001"; opcode <= "0100"; wait for 100 ns; 
        -- add = Z => 0xFFFFFFFF, ovfl = 1
		
		-- positivo
		A <= X"0000000A"; B <= X"00000006"; opcode <= "0100"; wait for 100 ns; 
        -- add = Z => 0x4			

		-- overflow
        -- N - P = P
		A <= X"80000000"; B <= X"00000001"; opcode <= "0100"; wait for 100 ns; 
        -- sub = 0x7FFFFFFF, ovfl = 1, borrow = 0	

		-- overflow
        -- P - N = N
		A <= X"7FFFFFFF"; B <= X"FFFFFFFF"; opcode <= "0100"; wait for 100 ns; 
        -- sub = 0x80000000, ovfl = 1, borrow = 1	

		-- TESTANDO SUBU
		-- zero
		A <= X"FFFFFFFF"; B <= X"FFFFFFFF"; opcode <= "0101"; wait for 100 ns; 
        -- add = Z => 0x0, zero = 1
		
		-- negativo
		A <= X"00000000"; B <= X"00000001"; opcode <= "0101"; wait for 100 ns; 
        -- add = Z => 0xFFFFFFFF, ovfl = 1
		
		-- positivo
		A <= X"0000000A"; B <= X"00000006"; opcode <= "0101"; wait for 100 ns; 
        -- add = Z => 0x4			
		
		-- overflow
		-- N - P = P
    	A <= X"80000000"; B <= X"00000001"; opcode <= "0101"; wait for 100 ns; 
        -- subu = 0x7FFFFFFF, ovfl = 0, borrow = 0

		-- overflow
		-- P - N = N
		A <= X"7FFFFFFF"; B <= X"FFFFFFFF"; opcode <= "0101"; wait for 100 ns; 
        -- subu = 0x80000000, ovfl = 0, borrow = 1
		
        -- TESTANDO SET ON LESS THEN
		A <= X"0000000A"; B <= X"0000000F"; opcode <= "0110"; wait for 100 ns; 
        -- slt = 0x1
		A <= X"0000000A"; B <= X"00000006"; opcode <= "0110"; wait for 100 ns; 
        -- slt = 0x0, zero = 1
		
        -- TESTANDO NAND		
        A <= X"000000FF"; B <= X"000000FF"; opcode <= "0111"; wait for 100 ns; 
        -- nand = 0xFFFFFF00
		A <= X"FF0000FF"; B <= X"FF0000FF"; opcode <= "0111"; wait for 100 ns; 
        -- nand = 0x00FFFF00

        -- TESTANDO NOR
		A <= X"00000000"; B <= X"00000000"; opcode <= "1000"; wait for 100 ns; 
        -- nor = 0xFFFFFFFF
		A <= X"0000FFFF"; B <= X"FF00FF00"; opcode <= "1000"; wait for 100 ns; 
        -- nor = 0x00FF0000
		
        -- TESTANDO XOR
		A <= X"00000000"; B <= X"00000001"; opcode <= "1001"; wait for 100 ns; 
        -- xor = 0x1
		A <= X"00000010"; B <= X"00000001"; opcode <= "1001"; wait for 100 ns; 
        -- xor = 0x11

        -- TESTANDO SHIFT LEFT LOGICAL
		A <= X"00000010"; B <= X"FFFFFFFF"; opcode <= "1010"; wait for 100 ns; 
        -- sll = 0xFFFF0000
		A <= X"00000100"; B <= X"FFFFFFFF"; opcode <= "1010"; wait for 100 ns; 
        -- sll = 0x0, zero = 1
		
        -- TESTANDO SHIFT RIGHT LOGICAL
		A <= X"00000010"; B <= X"FFFFFFFF"; opcode <= "1011"; wait for 100 ns; 
        -- srl = 0x0000FFFF
		A <= X"00000001"; B <= X"FFFFFFFF"; opcode <= "1011"; wait for 100 ns; 
        -- srl = 0x7FFFFFFF	

        -- TESTANDO SHIFT RIGHT ARITHMETIC
		A <= X"00000010"; B <= X"FFFFFFFF"; opcode <= "1100"; wait for 100 ns; 
        -- sra = 0xFFFFFFFF
		A <= X"00000010"; B <= X"FF0000FF"; opcode <= "1100"; wait for 100 ns; 
        -- sra = 0xFFFFFF00
		
	WAIT;                                                       
END PROCESS init;
                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
	BEGIN                                                         
        -- code executes for every event on sensitivity list  
	WAIT;                                                        
END PROCESS always;                                          
END ULA_OAC_arch;