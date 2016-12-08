library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MIPS_Mux2x1_32bits_MemparaReg is
    Port ( RegDadoMem : in  STD_LOGIC_VECTOR (31 downto 0);
           SaidaALU : in  STD_LOGIC_VECTOR (31 downto 0);
           Seletor_MemparaReg : in  STD_LOGIC;
           Saida_32bits : out  STD_LOGIC_VECTOR (31 downto 0));
end MIPS_Mux2x1_32bits_MemparaReg;

architecture Mux2x1_32bits of MIPS_Mux2x1_32bits_MemparaReg is

begin
	process(Seletor_MemparaReg,SaidaALU,RegDadoMem)
			begin 
			case Seletor_MemparaReg is 
				when '0' => Saida_32bits <= SaidaALU;
				when '1' => Saida_32bits <= RegDadoMem;
				when others => Saida_32bits <= X"00000000";

			end case;
end process;
end Mux2x1_32bits;

