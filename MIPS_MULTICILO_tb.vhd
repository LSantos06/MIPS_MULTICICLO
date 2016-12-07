LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MIPS_MULTICICLO_tb IS
END MIPS_MULTICICLO_tb;
 
ARCHITECTURE behavior OF MIPS_MULTICICLO_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MIPS_MULTICICLO
	port (
			-- Entradas
			Clock					: in std_logic;
			-- Saidas
			OpALU, OrigPC 		 : out STD_LOGIC_VECTOR(1 downto 0);
			OrigBALU 							 : out STD_LOGIC_VECTOR(2 downto 0);
			OrigAALU 							 : out STD_LOGIC;
			EscreveReg, RegDst, MemparaReg, EscrevePC, EscrevePCBeq, IouD, EscreveMem, 
			LeMem, EscreveIR, EscrevePCBne : out STD_LOGIC;
			CtlEnd 								 : out STD_LOGIC_VECTOR(1 downto 0);
			Opcode_ALU				: out std_logic_vector(3 downto 0);
			A_ALU, B_ALU					: out std_logic_vector((31) downto 0);
			PC						: out std_logic_vector(31 downto 0);
			RI						: out std_logic_vector(31 downto 0);
			RDM					: out std_logic_vector(31 downto 0);
			SaidaALU				: out std_logic_vector(31 downto 0)
			);
END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';

 	--Outputs
   signal OpALU : std_logic_vector(1 downto 0);
   signal OrigBALU : std_logic_vector(2 downto 0);
   signal OrigPC : std_logic_vector(1 downto 0);
   signal OrigAALU : std_logic;
   signal EscreveReg : std_logic;
   signal RegDst : std_logic;
   signal MemparaReg : std_logic;
   signal EscrevePC : std_logic;
   signal EscrevePCBeq : std_logic;
   signal IouD : std_logic;
   signal EscreveMem : std_logic;
   signal LeMem : std_logic;
   signal EscreveIR : std_logic;
   signal EscrevePCBne : std_logic;
   signal CtlEnd : std_logic_vector(1 downto 0);
   signal PC : std_logic_vector(31 downto 0);
   signal RI : std_logic_vector(31 downto 0);
   signal RDM : std_logic_vector(31 downto 0);
   signal SaidaALU : std_logic_vector(31 downto 0);
   signal Opcode_ALU				:  std_logic_vector(3 downto 0);
   signal A_ALU, B_ALU					: std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clock_period : time := 100 ps;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MIPS_MULTICICLO PORT MAP (
          Clock => Clock,
          OpALU => OpALU,
          OrigBALU => OrigBALU,
          OrigPC => OrigPC,
          OrigAALU => OrigAALU,
          EscreveReg => EscreveReg,
          RegDst => RegDst,
          MemparaReg => MemparaReg,
          EscrevePC => EscrevePC,
          EscrevePCBeq => EscrevePCBeq,
          IouD => IouD,
          EscreveMem => EscreveMem,
          LeMem => LeMem,
          EscreveIR => EscreveIR,
          EscrevePCBne => EscrevePCBne,
          CtlEnd => CtlEnd,
          PC => PC,
          RI => RI,
          RDM => RDM,
		  A_ALU => A_ALU,
		  B_ALU => B_ALU,
		  Opcode_ALU => Opcode_ALU,
          SaidaALU => SaidaALU
        );

   -- Clock process definitions
   Clock_process :process
   begin
		Clock <= '0';
		wait for Clock_period/2;
		Clock <= '1';
		wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 1 ns.
      wait for 1 ns;	

      wait for Clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
