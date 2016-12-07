library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux4 is
    Port ( mux_in0, mux_in1, mux_in2, mux_in3 : in  STD_LOGIC_VECTOR (4 downto 0);
           mux_select : in  STD_LOGIC_VECTOR (1 downto 0);
           mux_out : out  STD_LOGIC_VECTOR (4 downto 0));
end mux4;

architecture mux4_op of mux4 is

begin

	with mux_select select
		mux_out <= mux_in0 when "00",
			mux_in1 when "01",
			mux_in2 when "10",
			mux_in3 when "11",
			"00000" when others;

end mux4_op;

