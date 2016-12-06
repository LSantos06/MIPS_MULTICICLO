library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity romDespacho1 is
    Port ( Op : in  STD_LOGIC_VECTOR (5 downto 0);
           Valor : out  STD_LOGIC_VECTOR (3 downto 0));
end romDespacho1;

architecture romDespacho1_op of romDespacho1 is

begin

	with Op select
		Valor <= "0110" when "000000",
			"1001" when "000010",
			"1000" when "000100",
			"0010" when "100011"|"101011",
			"1010" when "001000",
			"1100" when "000101",
			"0000" when others;

end romDespacho1_op;

