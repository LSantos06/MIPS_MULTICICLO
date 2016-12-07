library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity microPC is
    Port ( clk : in STD_LOGIC;
           estado_in : in  STD_LOGIC_VECTOR (4 downto 0);
           estado_out : out  STD_LOGIC_VECTOR (4 downto 0));
end microPC;

architecture microPC_op of microPC is

begin

	process (clk) begin
		if (rising_edge(clk)) then
			estado_out <= estado_in;
		end if;
	end process;

end microPC_op;

