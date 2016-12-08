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
			  Shamt_Extendido : in  STD_LOGIC_VECTOR (31 downto 0);			  
           Seletor_OrigBALU : in  STD_LOGIC_vector(2 downto 0);
           Saida_32bits_BALU : out  STD_LOGIC_VECTOR (31 downto 0));
end MIPS_Mux4x1_32bits_OrigBALU;

architecture Mux4x1_32bits_BALU of MIPS_Mux4x1_32bits_OrigBALU is

begin
	process(RegB,Extensao_sinal,Extensao_sinal_deslocado2bits,Shamt_Extendido,Seletor_OrigBALU,Seletor_OrigBALU)
			begin 
			case Seletor_OrigBALU is 
				when "000" => Saida_32bits_BALU <= RegB;
				when "001" => Saida_32bits_BALU <= X"00000004";
				when "010" => Saida_32bits_BALU <= extensao_sinal;
				when "011" => Saida_32bits_BALU <= extensao_sinal_deslocado2bits;
				when "100" => Saida_32bits_BALU <= Shamt_Extendido;
				

				when others => Saida_32bits_BALU <= X"00000000";

			end case;
end process;
end Mux4x1_32bits_BALU;

