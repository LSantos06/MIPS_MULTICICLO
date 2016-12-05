library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SHIFT_2LEFT is
	port (
			-- Entradas
			V_in 		: in std_logic_vector(31 downto 0);
         -- Saidas
			V_out 	: out std_logic_vector (31 downto 0)
			);
end SHIFT_2LEFT;

architecture comportamento of SHIFT_2LEFT is

	begin
	
		process (V_in) begin
		
			V_out <= std_logic_vector(shift_left(unsigned(V_in), 2));
			
		end process;

end architecture;