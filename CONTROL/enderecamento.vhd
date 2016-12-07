library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity enderecamento is
    Port ( opcode : in  STD_LOGIC_VECTOR (5 downto 0);
			  funct : in  STD_LOGIC_VECTOR (5 downto 0);	
			  Reg_Rt_end : in STD_LOGIC_VECTOR(4 downto 0);
           somador : in  STD_LOGIC_VECTOR (4 downto 0);
           CtlEnd : in  STD_LOGIC_VECTOR (1 downto 0);
			  PE : out STD_LOGIC_VECTOR(4 downto 0));
end enderecamento;

architecture enderecamento_op of enderecamento is
	-- Tabela de despacho 1
	component romDespacho1 is
    Port ( Op : in  STD_LOGIC_VECTOR (5 downto 0);
			  funct : in  STD_LOGIC_VECTOR (5 downto 0);
			  Reg_Rt : in STD_LOGIC_VECTOR(4 downto 0); 
           Valor : out  STD_LOGIC_VECTOR (4 downto 0));
	end component;
	-- Tabela de despacho 2
	component romDespacho2 is
    Port ( Op : in  STD_LOGIC_VECTOR (5 downto 0);
           Valor : out  STD_LOGIC_VECTOR (4 downto 0));
	end component;
	-- Multiplexador 4 entradas de 4 bits
	component mux4 is
    Port ( mux_in0, mux_in1, mux_in2, mux_in3 : in  STD_LOGIC_VECTOR (4 downto 0);
           mux_select : in  STD_LOGIC_VECTOR (1 downto 0);
           mux_out : out  STD_LOGIC_VECTOR (4 downto 0));
	end component;
	-- Sinais auxiliares
	signal despacho1, despacho2 : STD_LOGIC_VECTOR(4 downto 0);
begin
	-- Conectando os blocos da l�gica de sele��o de endere�o
	rom1 : romDespacho1 port map (opcode, funct, Reg_Rt_end, despacho1);
	rom2 : romDespacho2 port map (opcode, despacho2);
	mux : mux4 port map ("00000", despacho1, despacho2, somador, CtlEnd, PE);
		
end enderecamento_op;

