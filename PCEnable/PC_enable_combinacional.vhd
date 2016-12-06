library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC_enable_combinacional is
    Port ( 
			-- entradas
			  s_PCBeq : in  STD_LOGIC;
           s_PCBne : in  STD_LOGIC;
           s_Zero : in  STD_LOGIC;
           s_EscrevePC : in  STD_LOGIC;
			 --saidas 
           PCenable : out  STD_LOGIC);
end PC_enable_combinacional;

architecture Behavioral of PC_enable_combinacional is
signal aux1,aux2:std_logic;
begin
aux1 <= s_PCBeq and s_Zero;

aux2 <= s_PCBne and not(s_Zero);

PCenable<= aux1 or aux2 or s_EscrevePC;
end Behavioral;

