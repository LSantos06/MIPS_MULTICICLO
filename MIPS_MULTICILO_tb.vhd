LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY MIPS_MULTICICLO_tb IS
END MIPS_MULTICICLO_tb;
 
ARCHITECTURE behavior OF MIPS_MULTICICLO_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MIPS_MULTICICLO
    PORT(
         Clock : IN  std_logic;
         PC : OUT  std_logic_vector(31 downto 0);
         RI : OUT  std_logic_vector(31 downto 0);
         RDM : OUT  std_logic_vector(31 downto 0);
         SaidaALU : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';

 	--Outputs
   signal PC : std_logic_vector(31 downto 0);
   signal RI : std_logic_vector(31 downto 0);
   signal RDM : std_logic_vector(31 downto 0);
   signal SaidaALU : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MIPS_MULTICICLO PORT MAP (
          Clock => Clock,
          PC => PC,
          RI => RI,
          RDM => RDM,
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;