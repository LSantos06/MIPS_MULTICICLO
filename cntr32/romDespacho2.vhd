----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:08:56 12/03/2016 
-- Design Name: 
-- Module Name:    romDespacho2 - romDespacho2_op 
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

