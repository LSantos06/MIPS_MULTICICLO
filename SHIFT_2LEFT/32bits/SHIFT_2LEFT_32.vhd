library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SHIFT_2LEFT_32 is
	port (
			-- Entradas
			SK16 		: in std_logic_vector(31 downto 0);
         -- Saidas
			K32 	: out std_logic_vector (31 downto 0)
			);
end SHIFT_2LEFT_32;

architecture comportamento of SHIFT_2LEFT_32 is

	begin
	
		process (SK16) begin
		
			K32 <= std_logic_vector(shift_left(unsigned(SK16), 2));
			
		end process;

end architecture;