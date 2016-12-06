----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:17:25 12/02/2016 
-- Design Name: 
-- Module Name:    somador - somador_op 
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
use IEEE.NUMERIC_STD.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity somador is
    Port ( EP : in  STD_LOGIC_VECTOR (3 downto 0);
           PE : out  STD_LOGIC_VECTOR (3 downto 0));
end somador;

architecture somador_op of somador is

begin

	PE <= STD_LOGIC_VECTOR(UNSIGNED(EP) + 1);  

end somador_op;

