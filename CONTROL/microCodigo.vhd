library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity microCodigo is
	port( estado : in STD_LOGIC_VECTOR(4 downto 0);
			OpALU					:out std_LOGIC_VECTOR(1 downto 0);
			OrigBALU				:out std_LOGIC_VECTOR(2 downto 0);		
			OrigPC 				: out STD_LOGIC_VECTOR(1 downto 0);
			OrigAALU : out STD_LOGIC;
			EscreveReg, RegDst, MemparaReg, EscrevePC, EscrevePCBeq, IouD, EscreveMem, LeMem, EscreveIR, EscrevePCBne, EscrevePCBgez,EscrevePCBltz: out STD_LOGIC;
			CtlEnd : out STD_LOGIC_VECTOR(1 downto 0));
end microCodigo;

architecture microCodigo_op of microCodigo is

	-- Definindo o formato do microprograma
	SUBTYPE microComandos_T is std_logic_vector(0 to 19);
	SUBTYPE nextAddress_T is std_logic_vector(0 to 1);  
	TYPE microInstrucao_T is RECORD
		microCmds   : microComandos_T;
		nextAddress : nextAddress_T;
	end RECORD;  
	TYPE microPrograma_T is array (0 to 16) of microInstrucao_T;
	
	-- Valores para o campo de sequenciamento
	constant SEQ     : nextAddress_T := "11";
	constant FETCH  : nextAddress_T := "00";
	constant DISPATCH_1   : nextAddress_T := "01";
	constant DISPATCH_2   : nextAddress_T := "10";  
	
	-- Micro programa: listar os sinais de saida na ordem da figura
	-- Microinstrucao | ALU Cntr | SRC 1 | SRC 2 | Regs | Mem | PC Write | Seq
	-- Microinstrucao | [OpALU(1),OpALU(0)] | OrigAALU | [OrigBALU(2),OrigBALU(1),OrigBALU(0)] | EscreveReg,RegDst,MemparaReg | LeMem,EscreveMem,IouD,EscreveIR | [OrigPC(1),OrigPC(0)],EscrevePC, EscrevePCBeq, EscrevePCBne,EscrevePCBgez,EscrevePCBltz| [CtlEnd(1),CtlEnd(0)]
	constant	mFETCH : microInstrucao_T := ("00000100010010010000", SEQ);
	constant	mAUX0 : microInstrucao_T := ("00001100000000000000", DISPATCH_1);
	constant	mMEM1 : microInstrucao_T := ("00101000000000000000", DISPATCH_2);
	constant	mLW2 : microInstrucao_T := ("00000000010100000000", SEQ);
	constant	mAUX1 : microInstrucao_T := ("00000010100000000000", FETCH);
	constant	mSW2 : microInstrucao_T := ("00000000001100000000", FETCH);
	constant	mRformat1 : microInstrucao_T := ("10100000000000000000", SEQ);
	constant	mAUX2 : microInstrucao_T := ("00000011000000000000", FETCH);
	constant	mBEQ1 : microInstrucao_T := ("01100000000000101000", FETCH);
	constant	mJUMP1 : microInstrucao_T := ("00000000000001010000", FETCH);
	constant	mIformat1 : microInstrucao_T := ("11101000000000000000", SEQ);
	constant	mIAUX2 : microInstrucao_T := ("00000011000000000000", FETCH);
	constant	mBNE1 : microInstrucao_T := ("01100000000000100100", FETCH);
	constant	mSRLformat : microInstrucao_T := ("10110000000000000000", SEQ);
	constant	mSRLAUX : microInstrucao_T := ("00000011000000000000", FETCH);
	constant	mBGEZ1 : microInstrucao_T := ("00000000000000100010", FETCH);
	constant	mBLTZ1 : microInstrucao_T := ("00000000000000100001", FETCH);
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
	microPrograma(13) <= mIAUX2;
	microPrograma(14) <= mBNE1;
	microPrograma(15) <= mBGEZ1;
	microPrograma(16) <= mBLTZ1;
	
	-- Sele��o da micro instru��o a partir do codigo de estado
	with estado select
		microInstrucao <= microPrograma(0) when "00000",
			microPrograma(1) when "00001",
			microPrograma(2) when "00010",
			microPrograma(3) when "00011",
			microPrograma(4) when "00100",
			microPrograma(5) when "00101",
			microPrograma(6) when "00110",
			microPrograma(7) when "00111",
			microPrograma(8) when "01000",
			microPrograma(9) when "01001",
			microPrograma(10) when "01010",
			microPrograma(11) when "01011",
			microPrograma(12) when "01100",
			microPrograma(13) when "01101",
			microPrograma(14) when "01110",
			microPrograma(15) when "01111",
			microPrograma(16) when "10000",	
			microInstrucao when others;
	
	-- Separando os campos da instru��o atual
	OpALU <= microInstrucao.microCmds(0 to 1);
	OrigAALU <= microInstrucao.microCmds(2);
	OrigBALU <= microInstrucao.microCmds(3 to 5);
	EscreveReg <= microInstrucao.microCmds(6);
	RegDst <= microInstrucao.microCmds(7);
	MemparaReg <= microInstrucao.microCmds(8);
	LeMem <= microInstrucao.microCmds(9);
	EscreveMem <= microInstrucao.microCmds(10);
	IouD <= microInstrucao.microCmds(11);
	EscreveIR <= microInstrucao.microCmds(12);
	OrigPC <= microInstrucao.microCmds(13 to 14);
	EscrevePC <= microInstrucao.microCmds(15);
	EscrevePCBeq <= microInstrucao.microCmds(16);
	EscrevePCBne <= microInstrucao.microCmds(17);
	EscrevePCBgez <= microInstrucao.microCmds(18);
	EscrevePCBltz <= microInstrucao.microCmds(19);
	
	CtlEnd <= microInstrucao.nextAddress;
			
end microCodigo_op;

