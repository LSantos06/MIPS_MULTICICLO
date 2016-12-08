library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SHIFT_2LEFT_26 is
	port (
			-- Entradas
			PC			: in std_logic_vector(31 downto 0);
			K26 		: in std_logic_vector(25 downto 0);
         -- Saidas
			K32 		: out std_logic_vector (31 downto 0)
			);
end SHIFT_2LEFT_26;

architecture comportamento of SHIFT_2LEFT_26 is

	begin
	
		process (K26,PC) begin
		
			K32 <= PC(31 downto 28)& k26 & "00";
			
		end process;

end architecture;