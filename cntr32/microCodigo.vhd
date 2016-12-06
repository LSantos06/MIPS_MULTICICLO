----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:14:52 12/02/2016 
-- Design Name: 
-- Module Name:    microCodigo - microCodigo_op 
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

entity microCodigo is
	port( estado : in STD_LOGIC_VECTOR(3 downto 0);
			OpALU, OrigBALU, OrigPC : out STD_LOGIC_VECTOR(1 downto 0);
			OrigAALU : out STD_LOGIC;
			EscreveReg, RegDst, MemparaReg, EscrevePC, EscrevePCBeq, IouD, EscreveMem, LeMem, EscreveIR, EscrevePCBne : out STD_LOGIC;
			CtlEnd : out STD_LOGIC_VECTOR(1 downto 0));
end microCodigo;

architecture microCodigo_op of microCodigo is

	-- Definindo o formato do microprograma
	SUBTYPE microComandos_T is std_logic_vector(0 to 16);
	SUBTYPE nextAddress_T is std_logic_vector(0 to 1);  
	TYPE microInstrucao_T is RECORD
		microCmds   : microComandos_T;
		nextAddress : nextAddress_T;
	end RECORD;  
	TYPE microPrograma_T is array (0 to 11) of microInstrucao_T;
	
	-- Valores para o campo de sequenciamento
	constant SEQ     : nextAddress_T := "11";
	constant FETCH  : nextAddress_T := "00";
	constant DISPATCH_1   : nextAddress_T := "01";
	constant DISPATCH_2   : nextAddress_T := "10";  
	
	-- Micro programa: listar os sinais de saida na ordem da figura
	-- Microinstrucao | ALU Cntr | SRC 1 | SRC 2 | Regs | Mem | PC Write | Seq
	-- Microinstrucao | [OpALU(1),OpALU(0)] | OrigAALU | [OrigBALU(1),OrigBALU(0)] | EscreveReg,RegDst,MemparaReg | LeMem,EscreveMem,IouD,EscreveIR | [OrigPC(1),OrigPC(0)],EscrevePC, EscrevePCBeq, EscrevePCBne| [CtlEnd(1),CtlEnd(0)]
	constant	mFETCH : microInstrucao_T := ("00001000100100100", SEQ);
	constant	mAUX0 : microInstrucao_T := ("00011000000000000", DISPATCH_1);
	constant	mMEM1 : microInstrucao_T := ("00110000000000000", DISPATCH_2);
	constant	mLW2 : microInstrucao_T := ("00000000101000000", SEQ);
	constant	mAUX1 : microInstrucao_T := ("00000101000000000", FETCH);
	constant	mSW2 : microInstrucao_T := ("00000000011000000", FETCH);
	constant	mRformat1 : microInstrucao_T := ("10100000000000000", SEQ);
	constant	mAUX2 : microInstrucao_T := ("00000110000000000", FETCH);
	constant	mBEQ1 : microInstrucao_T := ("01100000000001010", FETCH);
	constant	mJUMP1 : microInstrucao_T := ("00000000000010100", FETCH);
	constant	mIformat1 : microInstrucao_T := ("11110000000000000", SEQ);
	constant	mIAUX2 : microInstrucao_T := ("00000110000000000", FETCH);
	constant	mBNE1 : microInstrucao_T := ("01100000000001001", FETCH);
	
	-- Sinais auxiliares
	signal microPrograma : microPrograma_T;
	signal microInstrucao : microInstrucao_T;
	
begin

	-- Montagem do micro programa
	microPrograma(0) <= mFETCH;
	microPrograma(1) <= mAUX0;
	microPrograma(2) <= mMEM1;
	microPrograma(3) <= mLW2;
	microPrograma(4) <= mAUX1;
	microPrograma(5) <= mSW2;
	microPrograma(6) <= mRformat1;
	microPrograma(7) <= mAUX2;
	microPrograma(8) <= mBEQ1;
	microPrograma(9) <= mJUMP1;
	microPrograma(10) <= mIformat1;
	microPrograma(11) <= mIAUX2;
	microPrograma(12) <= mBNE1;
	
	-- Sele��o da micro instru��o a partir do codigo de estado
	with estado select
		microInstrucao <= microPrograma(0) when "0000",
			microPrograma(1) when "0001",
			microPrograma(2) when "0010",
			microPrograma(3) when "0011",
			microPrograma(4) when "0100",
			microPrograma(5) when "0101",
			microPrograma(6) when "0110",
			microPrograma(7) when "0111",
			microPrograma(8) when "1000",
			microPrograma(9) when "1001",
			microPrograma(10) when "1010",
			microPrograma(11) when "1011",
			microPrograma(12) when "1100",
			microInstrucao when others;
	
	-- Separando os campos da instru��o atual
	OpALU <= microInstrucao.microCmds(0 to 1);
	OrigAALU <= microInstrucao.microCmds(2);
	OrigBALU <= microInstrucao.microCmds(3 to 4);
	EscreveReg <= microInstrucao.microCmds(5);
	RegDst <= microInstrucao.microCmds(6);
	MemparaReg <= microInstrucao.microCmds(7);
	LeMem <= microInstrucao.microCmds(8);
	EscreveMem <= microInstrucao.microCmds(9);
	IouD <= microInstrucao.microCmds(10);
	EscreveIR <= microInstrucao.microCmds(11);
	OrigPC <= microInstrucao.microCmds(12 to 13);
	EscrevePC <= microInstrucao.microCmds(14);
	EscrevePCBeq <= microInstrucao.microCmds(15);
	EscrevePCBne <= microInstrucao.microCmds(16);
	CtlEnd <= microInstrucao.nextAddress;
			
end microCodigo_op;

