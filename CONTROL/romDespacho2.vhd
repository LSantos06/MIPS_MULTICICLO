library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity romDespacho2 is
    Port ( Op : in  STD_LOGIC_VECTOR (5 downto 0);
           Valor : out  STD_LOGIC_VECTOR (3 downto 0));
end romDespacho2;

architecture romDespacho2_op of romDespacho2 is

begin

	with Op select
		Valor <= "0011" when "100011",
			"0101" when "101011",
			"0000" when others;

end romDespacho2_op;

