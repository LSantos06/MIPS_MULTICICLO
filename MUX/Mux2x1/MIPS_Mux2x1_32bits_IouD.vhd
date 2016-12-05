library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MIPS_Mux2x1_32bits_IouD is
    Port ( RegPC : in  STD_LOGIC_VECTOR (31 downto 0);
           SaidaALU_beq : in  STD_LOGIC_VECTOR (31 downto 0);
           Seletor_IouD : in  STD_LOGIC;
           Saida_32bits_IouD : out  STD_LOGIC_VECTOR (31 downto 0));
end MIPS_Mux2x1_32bits_IouD;

architecture Mux2x1_32bits_IouD of MIPS_Mux2x1_32bits_IouD is

begin
	process(Seletor_IouD)
			begin 
			case Seletor_IouD is 
				when '0' => Saida_32bits_IouD <= RegPC;
				when '1' => Saida_32bits_IouD <= SaidaALU_beq;
				when others => Saida_32bits_IouD <= X"00000000";

			end case;
end process;
end Mux2x1_32bits_IouD;

