library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MIPS_Mux4x1_32bits_OrigBALU is
    Port ( RegB : in  STD_LOGIC_VECTOR (31 downto 0);
           Extensao_sinal : in  STD_LOGIC_VECTOR (31 downto 0);
			  Extensao_sinal_deslocado2bits : in  STD_LOGIC_VECTOR (31 downto 0);
           Seletor_OrigBALU : in  STD_LOGIC_vector(1 downto 0);
           Saida_32bits_BALU : out  STD_LOGIC_VECTOR (31 downto 0));
end MIPS_Mux4x1_32bits_OrigBALU;

architecture Mux4x1_32bits_BALU of MIPS_Mux4x1_32bits_OrigBALU is

begin
	process(Seletor_OrigBALU)
			begin 
			case Seletor_OrigBALU is 
				when "00" => Saida_32bits_BALU <= RegB;
				when "01" => Saida_32bits_BALU <= X"00000004";
				when "10" => Saida_32bits_BALU <= extensao_sinal;
				when "11" => Saida_32bits_BALU <= extensao_sinal_deslocado2bits;

				when others => Saida_32bits_BALU <= X"00000000";

			end case;
end process;
end Mux4x1_32bits_BALU;

