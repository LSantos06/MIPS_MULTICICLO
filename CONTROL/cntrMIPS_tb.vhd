--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:26:55 12/03/2016
-- Design Name:   
-- Module Name:   C:/ISE-Projects/OAC/trab7/cntrMIPS/cntrMIPS_tb.vhd
-- Project Name:  cntrMIPS
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cntrMIPS
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY cntrMIPS_tb IS
END cntrMIPS_tb;
 
ARCHITECTURE behavior OF cntrMIPS_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cntrMIPS
    PORT(
         clk : IN  std_logic;
         OP : IN  std_logic_vector(5 downto 0);
         OpALU : OUT  std_logic_vector(1 downto 0);
         OrigBALU : OUT  std_logic_vector(1 downto 0);
         OrigPC : OUT  std_logic_vector(1 downto 0);
         OrigAALU : OUT  std_logic;
         EscreveReg : OUT  std_logic;
         RegDst : OUT  std_logic;
         MemparaReg : OUT  std_logic;
         EscrevePC : OUT  std_logic;
         EscrevePCCond : OUT  std_logic;
         IouD : OUT  std_logic;
         EscreveMem : OUT  std_logic;
         LeMem : OUT  std_logic;
         EscreveIR : OUT  std_logic;
         CtlEnd : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal OP : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal OpALU : std_logic_vector(1 downto 0);
   signal OrigBALU : std_logic_vector(1 downto 0);
   signal OrigPC : std_logic_vector(1 downto 0);
   signal OrigAALU : std_logic;
   signal EscreveReg : std_logic;
   signal RegDst : std_logic;
   signal MemparaReg : std_logic;
   signal EscrevePC : std_logic;
   signal EscrevePCCond : std_logic;
   signal IouD : std_logic;
   signal EscreveMem : std_logic;
   signal LeMem : std_logic;
   signal EscreveIR : std_logic;
   signal CtlEnd : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cntrMIPS PORT MAP (
          clk => clk,
          OP => OP,
          OpALU => OpALU,
          OrigBALU => OrigBALU,
          OrigPC => OrigPC,
          OrigAALU => OrigAALU,
          EscreveReg => EscreveReg,
          RegDst => RegDst,
          MemparaReg => MemparaReg,
          EscrevePC => EscrevePC,
          EscrevePCCond => EscrevePCCond,
          IouD => IouD,
          EscreveMem => EscreveMem,
          LeMem => LeMem,
          EscreveIR => EscreveIR,
          CtlEnd => CtlEnd
        );

   -- Clock process definitions
   clk_process: process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		-- Instrução tipo R (4 ciclos de clock)
		OP <= "000000";
		wait for clk_period*4;
		-- Instrução jump (3 ciclos de clock)
		OP <= "000010";
		wait for clk_period*3;
		-- Instrução beq (3 ciclos de clock)
		OP <= "000100";
		wait for clk_period*3;
		-- Instrução load word (5 ciclos de clock)
		OP <= "100011";
		wait for clk_period*5;
		-- Instrução store word (4 ciclos de clock)
      OP <= "101011";
		wait for clk_period*4;

      wait;
   end process;

END;
