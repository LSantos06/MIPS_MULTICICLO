----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:12:39 12/03/2016 
-- Design Name: 
-- Module Name:    mux4 - mux4_op 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux4 is
    Port ( mux_in0, mux_in1, mux_in2, mux_in3 : in  STD_LOGIC_VECTOR (3 downto 0);
           mux_select : in  STD_LOGIC_VECTOR (1 downto 0);
           mux_out : out  STD_LOGIC_VECTOR (3 downto 0));
end mux4;

architecture mux4_op of mux4 is

begin

	with mux_select select
		mux_out <= mux_in0 when "00",
			mux_in1 when "01",
			mux_in2 when "10",
			mux_in3 when "11",
			"0000" when others;

end mux4_op;

