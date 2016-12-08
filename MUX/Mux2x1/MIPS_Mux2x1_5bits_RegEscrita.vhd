library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MIPS_Mux2x1_5bits_RegEscrita is
    Port ( Rt : in  STD_LOGIC_VECTOR (4 downto 0);
           Rd : in  STD_LOGIC_VECTOR (4 downto 0);
           Seletor_RegDst : in  STD_LOGIC;
           Saida_5bits : out  STD_LOGIC_VECTOR (4 downto 0));
end MIPS_Mux2x1_5bits_RegEscrita;

architecture Mux2x1_5bits of MIPS_Mux2x1_5bits_RegEscrita is

begin
	process(Seletor_RegDst,Rt,Rd)
			begin 
			case Seletor_RegDst is 
				when '0' => Saida_5bits <= Rt;
				when '1' => Saida_5bits <= Rd;
				when others => Saida_5bits <= "00000";

			end case;
end process;
end Mux2x1_5bits;

