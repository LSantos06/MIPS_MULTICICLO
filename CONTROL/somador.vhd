library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity somador is
    Port ( EP : in  STD_LOGIC_VECTOR (4 downto 0);
           PE : out  STD_LOGIC_VECTOR (4 downto 0));
end somador;

architecture somador_op of somador is

begin

	PE <= STD_LOGIC_VECTOR(UNSIGNED(EP) + 1);  

end somador_op;

