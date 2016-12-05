library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MIPS_Mux3x1_32bits_OrigPC is
    Port ( PCmais4 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_saidaALU_BEQ : in  STD_LOGIC_VECTOR (31 downto 0);
			  PC_Jump : in  STD_LOGIC_VECTOR (31 downto 0);
           Seletor_OrigPC : in  STD_LOGIC_vector(1 downto 0);
           Saida_32bits_PC : out  STD_LOGIC_VECTOR (31 downto 0));
end MIPS_Mux3x1_32bits_OrigPC;

architecture Mux3x1_32bits_OrigPC of MIPS_Mux3x1_32bits_OrigPC is

begin
	process(Seletor_OrigPC)
			begin 
			case Seletor_OrigPC is 
				when "00" => Saida_32bits_PC <= PCmais4;
				when "01" => Saida_32bits_PC <= PC_saidaALU_BEQ;
				when "10" => Saida_32bits_PC <= PC_Jump;
				when others => Saida_32bits_PC <= X"00000000";

			end case;
end process;
end Mux3x1_32bits_OrigPC;

