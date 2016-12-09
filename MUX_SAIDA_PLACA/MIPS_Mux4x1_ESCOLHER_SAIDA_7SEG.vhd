library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MIPS_Mux4x1_ESCOLHER_SAIDA_7SEG is
    Port ( Saida_PC : in  STD_LOGIC_VECTOR (31 downto 0);
           Saida_RI : in  STD_LOGIC_VECTOR (31 downto 0);
			  Saida_SaidaALU : in  STD_LOGIC_VECTOR (31 downto 0);
			  Saida_RDM: in  STD_LOGIC_VECTOR (31 downto 0);			  
           Seletor_Saida : in  STD_LOGIC_vector(1 downto 0);
           Saida_Primeiro_7seg : out STD_LOGIC_VECTOR(6 downto 0);
			  Saida_Segundo_7seg : out STD_LOGIC_VECTOR(6 downto 0);
			  Saida_Terceiro_7seg : out STD_LOGIC_VECTOR(6 downto 0);
			  Saida_Quarto_7seg : out STD_LOGIC_VECTOR(6 downto 0);
			  Saida_Quinto_7seg : out STD_LOGIC_VECTOR(6 downto 0);
			  Saida_Sexta_7seg : out STD_LOGIC_VECTOR(6 downto 0);
			  Saida_Setimo_7seg : out STD_LOGIC_VECTOR(6 downto 0);
			  Saida_Oitavo_7seg : out STD_LOGIC_VECTOR(6 downto 0));
			  
end MIPS_Mux4x1_ESCOLHER_SAIDA_7SEG;

architecture Mux4x1_SAIDA_OP of MIPS_Mux4x1_ESCOLHER_SAIDA_7SEG is

component Oito_Saidas7seg is
    Port ( entradas : in  STD_LOGIC_VECTOR (31 downto 0);
           saidas_7seg : out  STD_LOGIC_VECTOR (55 downto 0));
end component;
signal Saida_Placa, Saida_PC_7seg, Saida_RI_7seg, Saida_SaidaALU_7seg ,Saida_RDM_7seg : std_logic_vector(55 downto 0);
begin
UPC: Oito_Saidas7seg port map (saida_PC,saida_PC_7seg);
URI: Oito_Saidas7seg port map(saida_RI,saida_RI_7seg); 	
USaidaALU: Oito_Saidas7seg port map(saida_RDM,saida_RDM_7seg);
URDM: Oito_Saidas7seg port map(saida_SaidaALU,saida_SaidaALU_7seg); 


	process(Saida_PC_7seg, Saida_RI_7seg, Saida_SaidaALU_7seg ,Saida_RDM_7seg,Seletor_Saida)
			begin 
			case Seletor_Saida is 
				when "00" => Saida_Placa <= Saida_PC_7seg;
				when "01" => Saida_Placa <= Saida_Ri_7seg;
				when "10" => Saida_Placa <= Saida_SaidaAlu_7seg;
				when "11" => Saida_Placa <= Saida_RDM_7seg;
				

				when others => Saida_Placa <= X"00000000000000";

			end case;

end process;
Saida_Primeiro_7seg<= Saida_Placa(6 downto 0);
Saida_Segundo_7seg<=Saida_Placa(13 downto 7);
Saida_Terceiro_7seg<=Saida_Placa(20 downto 14);
Saida_Quarto_7seg<=Saida_Placa(27 downto 21);
Saida_Quinto_7seg<=Saida_Placa(34 downto 28);
Saida_Sexta_7seg<=Saida_Placa(41 downto 35);
Saida_Setimo_7seg<=Saida_Placa(48 downto 42);
Saida_Oitavo_7seg<=Saida_Placa(55 downto 49);

end Mux4x1_SAIDA_OP;

