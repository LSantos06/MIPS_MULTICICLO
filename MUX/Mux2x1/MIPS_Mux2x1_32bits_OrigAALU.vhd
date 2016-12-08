library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MIPS_Mux2x1_32bits_OrigAALU is
    Port ( RegA : in  STD_LOGIC_VECTOR (31 downto 0);
           RegPC : in  STD_LOGIC_VECTOR (31 downto 0);
           Seletor_OrigAALU : in  STD_LOGIC;
           Saida_32bits_ALU : out  STD_LOGIC_VECTOR (31 downto 0));
end MIPS_Mux2x1_32bits_OrigAALU;

architecture Mux2x1_32bits_ALU of MIPS_Mux2x1_32bits_OrigAALU is

begin
	process(RegA,RegPC,Seletor_OrigAALU)
			begin 
			case Seletor_OrigAALU is 
				when '0' => Saida_32bits_ALU <= RegPC;
				when '1' => Saida_32bits_ALU <= RegA;
				when others => Saida_32bits_ALU <= X"00000000";

			end case;
end process;
end Mux2x1_32bits_ALU;

