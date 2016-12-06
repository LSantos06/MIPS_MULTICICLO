----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:58:35 12/02/2016 
-- Design Name: 
-- Module Name:    cntrMIPS - cntrMIPS_op 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cntrMIPS is
	port( clk : in STD_LOGIC;
			OP : in STD_LOGIC_VECTOR(5 downto 0);
			OpALU, OrigBALU, OrigPC : out STD_LOGIC_VECTOR(1 downto 0);
			OrigAALU : out STD_LOGIC;
			EscreveReg, RegDst, MemparaReg, EscrevePC, EscrevePCBeq, IouD, EscreveMem, LeMem, EscreveIR, EscrevePCBne : out STD_LOGIC;
			CtlEnd : out STD_LOGIC_VECTOR(1 downto 0));
end cntrMIPS;

architecture cntrMIPS_op of cntrMIPS is
	-- Mem�ria de microc�digo
	component microCodigo is
	port( estado : in STD_LOGIC_VECTOR(3 downto 0);
			OpALU, OrigBALU, OrigPC : out STD_LOGIC_VECTOR(1 downto 0);
			OrigAALU : out STD_LOGIC;
			EscreveReg, RegDst, MemparaReg, EscrevePC, EscrevePCBeq, IouD, EscreveMem, LeMem, EscreveIR, EscrevePCBne: out STD_LOGIC;
			CtlEnd : out STD_LOGIC_VECTOR(1 downto 0));
	end component;
	-- L�gica de endere�amento
	component enderecamento is
    Port ( opcode : in  STD_LOGIC_VECTOR (5 downto 0);
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
	enderecamento_instance : enderecamento port map (OP,PE_somador_aux,ctlEnd_aux,PE_enderecamento_aux);
	microPC_instance : microPC port map(clk,PE_enderecamento_aux,estado_aux);
	somador_instance : somador port map (estado_aux,PE_somador_aux);
	microCodigo_instance : microCodigo port map (estado_aux,OpALU, OrigBALU, OrigPC, OrigAALU, EscreveReg, RegDst, MemparaReg, EscrevePC, EscrevePCBeq, IouD, EscreveMem, LeMem, EscreveIR, EscrevePCBne, CtlEnd_aux);
	CtlEnd <= CtlEnd_aux;

end cntrMIPS_op;

