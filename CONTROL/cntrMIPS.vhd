--
-- OAC - Trabalho 7: Projeto do Controle do MIPS Multiciclo 
-- Aluno: Filipe Teixeira Cardoso
-- Matrícula: 14/0139486
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cntrMIPS is
	port( clk : in STD_LOGIC;
			OP : in STD_LOGIC_VECTOR(5 downto 0);
			funct : in  STD_LOGIC_VECTOR (5 downto 0);
			OpALU					:out std_LOGIC_VECTOR(1 downto 0);
			OrigBALU				:out std_LOGIC_VECTOR(2 downto 0);		
			OrigPC 				: out STD_LOGIC_VECTOR(1 downto 0);
			OrigAALU 			: out STD_LOGIC;
			EscreveReg, RegDst, MemparaReg, EscrevePC, EscrevePCBeq, IouD, EscreveMem, LeMem, EscreveIR, EscrevePCBne : out STD_LOGIC;
			CtlEnd : out STD_LOGIC_VECTOR(1 downto 0));
end cntrMIPS;

architecture cntrMIPS_op of cntrMIPS is
	-- Mem�ria de microc�digo
	component microCodigo is
	port( estado : in STD_LOGIC_VECTOR(3 downto 0);
			OpALU					:out std_LOGIC_VECTOR(1 downto 0);
			OrigBALU				:out std_LOGIC_VECTOR(2 downto 0);		
			OrigPC 				: out STD_LOGIC_VECTOR(1 downto 0);
			OrigAALU : out STD_LOGIC;
			EscreveReg, RegDst, MemparaReg, EscrevePC, EscrevePCBeq, IouD, EscreveMem, LeMem, EscreveIR, EscrevePCBne: out STD_LOGIC;
			CtlEnd : out STD_LOGIC_VECTOR(1 downto 0));
	end component;
	-- L�gica de endere�amento
	component enderecamento is
    Port ( opcode : in  STD_LOGIC_VECTOR (5 downto 0);
				funct : in  STD_LOGIC_VECTOR (5 downto 0);
           somador : in  STD_LOGIC_VECTOR (3 downto 0);
           CtlEnd : in  STD_LOGIC_VECTOR (1 downto 0);
			  PE : out STD_LOGIC_VECTOR(3 downto 0));
	end component;
	-- Registrador de microendere�o
	component microPC is
    Port ( clk : in STD_LOGIC;
           estado_in : in  STD_LOGIC_VECTOR (3 downto 0);
           estado_out : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	-- Incrementador
	component somador is
    Port ( EP : in  STD_LOGIC_VECTOR (3 downto 0);
           PE : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	-- Sinais auxiliares
	signal ctlEnd_aux : STD_LOGIC_VECTOR (1 downto 0);
	signal PE_somador_aux, PE_enderecamento_aux, estado_aux : STD_LOGIC_VECTOR (3 downto 0);
	
begin
	-- Conectando os blocos do controle
	enderecamento_instance : enderecamento port map (OP,funct,PE_somador_aux,ctlEnd_aux,PE_enderecamento_aux);
	microPC_instance : microPC port map(clk,PE_enderecamento_aux,estado_aux);
	somador_instance : somador port map (estado_aux,PE_somador_aux);
	microCodigo_instance : microCodigo port map (estado_aux,OpALU, OrigBALU, OrigPC, OrigAALU, EscreveReg, RegDst, MemparaReg, EscrevePC, EscrevePCBeq, IouD, EscreveMem, LeMem, EscreveIR, EscrevePCBne, CtlEnd_aux);
	CtlEnd <= CtlEnd_aux;

end cntrMIPS_op;

