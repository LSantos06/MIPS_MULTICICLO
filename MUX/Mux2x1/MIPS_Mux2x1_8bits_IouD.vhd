library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MIPS_Mux2x1_8bits_IouD is
    Port ( RegPC : in  STD_LOGIC_VECTOR (7 downto 0);
           SaidaALU_beq : in  STD_LOGIC_VECTOR (7 downto 0);
           Seletor_IouD : in  STD_LOGIC;
           Saida_8bits_IouD : out  STD_LOGIC_VECTOR (7 downto 0));
end MIPS_Mux2x1_8bits_IouD;

architecture Mux2x1_8bits_IouD of MIPS_Mux2x1_8bits_IouD is

begin
	process(RegPC,SaidaALU_beq,Seletor_IouD)
			begin 
			case Seletor_IouD is 
				when '0' => Saida_8bits_IouD <= RegPC;
				when '1' => Saida_8bits_IouD <= SaidaALU_beq;
				when others => Saida_8bits_IouD <= X"00";

			end case;
end process;
end Mux2x1_8bits_IouD;

