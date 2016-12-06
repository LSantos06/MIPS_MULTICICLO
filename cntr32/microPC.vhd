----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:11:42 12/02/2016 
-- Design Name: 
-- Module Name:    microPC - microPC_op 
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

entity microPC is
    Port ( clk : in STD_LOGIC;
           estado_in : in  STD_LOGIC_VECTOR (3 downto 0);
           estado_out : out  STD_LOGIC_VECTOR (3 downto 0));
end microPC;

architecture microPC_op of microPC is

begin

	process (clk) begin
		if (rising_edge(clk)) then
			estado_out <= estado_in;
		end if;
	end process;

end microPC_op;

