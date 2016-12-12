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
           Saida_Primeiro_7seg : out STD_LOGIC_VECTOR(7 downto 0);
			  Saida_Segundo_7seg : out STD_LOGIC_VECTOR(7 downto 0);
			  Saida_Terceiro_7seg : out STD_LOGIC_VECTOR(7 downto 0);
			  Saida_Quarto_7seg : out STD_LOGIC_VECTOR(7 downto 0);
			  Saida_Quinto_7seg : out STD_LOGIC_VECTOR(7 downto 0);
			  Saida_Sexta_7seg : out STD_LOGIC_VECTOR(7 downto 0);
			  Saida_Setimo_7seg : out STD_LOGIC_VECTOR(7 downto 0);
			  Saida_Oitavo_7seg : out STD_LOGIC_VECTOR(7 downto 0));
			  
end MIPS_Mux4x1_ESCOLHER_SAIDA_7SEG;

architecture Mux4x1_SAIDA_OP of MIPS_Mux4x1_ESCOLHER_SAIDA_7SEG is

component Oito_Saidas7seg is
    Port ( entradas : in  STD_LOGIC_VECTOR (31 downto 0);
           saidas_7seg : out  STD_LOGIC_VECTOR (63 downto 0));
end component;
signal Saida_Placa, Saida_PC_7seg, Saida_RI_7seg, Saida_SaidaALU_7seg ,Saida_RDM_7seg : std_logic_vector(63 downto 0);
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
				

				when others => Saida_Placa <= X"0000000000000000";

			end case;

end process;
Saida_Primeiro_7seg<= Saida_Placa(7 downto 0);
Saida_Segundo_7seg<=Saida_Placa(15 downto 8);
Saida_Terceiro_7seg<=Saida_Placa(23 downto 16);
Saida_Quarto_7seg<=Saida_Placa(31 downto 24);
Saida_Quinto_7seg<=Saida_Placa(39 downto 32);
Saida_Sexta_7seg<=Saida_Placa(47 downto 40);
Saida_Setimo_7seg<=Saida_Placa(55 downto 48);
Saida_Oitavo_7seg<=Saida_Placa(63 downto 56);

end Mux4x1_SAIDA_OP;

