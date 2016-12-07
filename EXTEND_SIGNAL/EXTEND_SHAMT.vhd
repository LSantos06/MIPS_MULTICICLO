library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity extend_shamt is
    Port ( Shamt : in  STD_LOGIC_VECTOR (4 downto 0);
           ShamtALU : out  STD_LOGIC_VECTOR (31 downto 0));
end extend_shamt;

architecture extend_H_arch of extend_SHAMT is

begin

ShamtALU	<= "000000000000000000000000000"		&	shamt;

end extend_H_arch;