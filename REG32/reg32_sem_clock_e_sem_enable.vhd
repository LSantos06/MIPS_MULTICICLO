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
entity reg32_sem_clock_e_sem_enable is
    Port ( estado_in : in  STD_LOGIC_VECTOR (31 downto 0);
           estado_out : out  STD_LOGIC_VECTOR (31 downto 0));
end reg32_sem_clock_e_sem_enable;

architecture reg32_op_nor of reg32_sem_clock_e_sem_enable is

begin

			estado_out <= estado_in;
	
end reg32_op_nor;