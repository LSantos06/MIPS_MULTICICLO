library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MIPS_MULTICICLO is
	generic (WSIZE 			: natural := 32);
	port (
			-- Entradas
			Clock					: in std_logic;
			-- Saidas
			PC						: out std_logic_vector((WSIZE-1) downto 0);
			RI						: out std_logic_vector((WSIZE-1) downto 0);
			RDM					: out std_logic_vector((WSIZE-1) downto 0);
			SaidaALU				: out std_logic_vector((WSIZE-1) downto 0)
			);
end MIPS_MULTICICLO;

architecture comportamento of MIPS_MULTICICLO is
	
	-------------------------------------------------------------------------------------------------------------
	---- Componentes
	-- Componente MEM
	component RAM_MIPS is
		port (
				-- Entradas
				Address				: in std_logic_vector (7 DOWNTO 0);
				Clock					: in std_logic;
				Data					: in std_logic_vector ((WSIZE-1) DOWNTO 0);
				Wren					: in std_logic;
				-- Saidas
				Q						: out std_logic_vector ((WSIZE-1) DOWNTO 0)
				);
	end component;
	
	-- Componente CONTROLE
	component cntrMIPS is
		port (
				-- Entradas
				clk 									 : in STD_LOGIC;
				OP 									 : in STD_LOGIC_VECTOR(5 downto 0);
				-- Saidas
				OpALU, OrigBALU, OrigPC 		 : out STD_LOGIC_VECTOR(1 downto 0);
				OrigAALU 							 : out STD_LOGIC;
				EscreveReg, RegDst, MemparaReg, EscrevePC, EscrevePCBeq, IouD, EscreveMem, 
				LeMem, EscreveIR, EscrevePCBne : out STD_LOGIC;
				CtlEnd 								 : out STD_LOGIC_VECTOR(1 downto 0)
				);
	end component;
	
	-- Componente BREG
	component bregMIPS is
		port (
				-- Entradas
				Clk, Wren 			 : in std_logic;
				Radd1, Radd2, Wadd : in std_logic_vector(4 downto 0);
				Wdata 				 : in std_logic_vector(WSIZE-1 downto 0);
				-- Saidas
				R1, R2 				 : out std_logic_vector(WSIZE-1 downto 0)
				);
	end component;
	
	-- Componente ULA
	component ULA_OAC is
		port (
				-- Entradas
				Opcode				: in std_logic_vector(3 downto 0);
				A, B					: in std_logic_vector((WSIZE-1) downto 0);
				-- Saidas
				Z						: out std_logic_vector((WSIZE-1) downto 0);
				Vai, Zero, Ovfl	: out std_logic 
				);
	end component;
	
	-------------------------------------------------------------------------------------------------------------
	---- Circuitos Combinacionais
	
	-- Extensao de Sinal
	component extend_signal is
		port (
				-- Entradas
				K16	: in  STD_LOGIC_VECTOR (15 downto 0);
				-- Saidas
				SK16  : out  STD_LOGIC_VECTOR ((WSIZE-1) downto 0)
				);
	end component;	
	
	-- Deslocamento de 2 a esquerda (32 bits)
	component SHIFT_2LEFT_32 is
		port (
				-- Entradas
				SK16 		: in std_logic_vector((WSIZE-1) downto 0);
				-- Saidas
				K32	 	: out std_logic_vector ((WSIZE-1) downto 0)
				);				
	end component;
	
	-- Deslocamento de 2 a esquerda (26 bits) + Concatenacao
	component SHIFT_2LEFT_26 is
		port (
				-- Entradas
				PC			: in std_logic_vector(31 downto 0);
				K26 		: in std_logic_vector(25 downto 0);
				-- Saidas
				K32 		: out std_logic_vector ((WSIZE-1) downto 0)
				);
	end component;		
	
	-- Controle da ULA
	component ALUcontrol is
		 port ( 
				 -- Entradas   
				 Opcode_ALU 			: in  STD_LOGIC_VECTOR (5 downto 0);
				 funct_ALU				: in  STD_LOGIC_VECTOR (5 downto 0);
				 Seletor_OPALU 		: in  STD_LOGIC_vector(1 downto 0);
			    -- Saidas
				 Saida_seletorALU 	: out  STD_LOGIC_VECTOR (3 downto 0));
	end component;

	component PC_enable_combinacional is
		 port ( 
				 -- Entradas
				 s_PCBeq 				: in  STD_LOGIC;
				 s_PCBne 				: in  STD_LOGIC;
				 s_Zero 					: in  STD_LOGIC;
				 s_EscrevePC 			: in  STD_LOGIC;
				 -- Saidas 
				 PCenable 				: out  STD_LOGIC
				 );
	end component;	
	
	-------------------------------------------------------------------------------------------------------------
	---- Multiplexadores
	
	-- 2x1
	-- Multiplexador Registrador de Escrita
	component MIPS_Mux2x1_5bits_RegEscrita is
		 port ( 
				 -- Entradas
				 Rt 				 : in  STD_LOGIC_VECTOR (4 downto 0);
				 Rd 				 : in  STD_LOGIC_VECTOR (4 downto 0);
				 Seletor_RegDst : in  STD_LOGIC;				 
				 -- Saidas 
				 Saida_5bits 	 : out  STD_LOGIC_VECTOR (4 downto 0)
				 );
	end component;	
			
	-- Multiplexador dado para escrita
	component MIPS_Mux2x1_32bits_MemparaReg is
		 port (
				 -- Entradas
				 RegDadoMem 		  : in  STD_LOGIC_VECTOR ((WSIZE-1) downto 0);
				 SaidaALU 			  : in  STD_LOGIC_VECTOR ((WSIZE-1) downto 0);
				 Seletor_MemparaReg : in  STD_LOGIC;
				 -- Saidas
				 Saida_32bits 		  : out  STD_LOGIC_VECTOR ((WSIZE-1) downto 0)
				 );
	end component;		
	
	-- Multiplexador dado entrada A da ULA	
	component MIPS_Mux2x1_32bits_OrigAALU is
		 port (
				 -- Entradas
				 RegA 				: in  STD_LOGIC_VECTOR ((WSIZE-1) downto 0);
				 RegPC 				: in  STD_LOGIC_VECTOR ((WSIZE-1) downto 0);
				 Seletor_OrigAALU : in  STD_LOGIC;
				 -- Saidas
				 Saida_32bits_ALU : out  STD_LOGIC_VECTOR ((WSIZE-1) downto 0));
	end component;
	
	--	Multiplexador que decide se PC vai ser entrada da ULA ou do outro Mux
	component MIPS_Mux2x1_32bits_IouD is
		 port ( -- Entradas
				 RegPC 					: in  STD_LOGIC_VECTOR (7 downto 0);
				 SaidaALU_beq 			: in  STD_LOGIC_VECTOR (7 downto 0);
				 Seletor_IouD 			: in  STD_LOGIC;
				 -- Saidas
				 Saida_32bits_IouD 	: out  STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	-- 3x1
	-- Multiplexador que atualiza o valor do PC
	component MIPS_Mux3x1_32bits_OrigPC is
		 port (
				 -- Entradas
				 PCmais4 		  : in  STD_LOGIC_VECTOR ((WSIZE-1) downto 0);
				 PC_saidaALU_BEQ : in  STD_LOGIC_VECTOR ((WSIZE-1) downto 0);
				 PC_Jump 		  : in  STD_LOGIC_VECTOR ((WSIZE-1) downto 0);
				 Seletor_OrigPC  : in  STD_LOGIC_vector(1 downto 0);
				 -- Saidas
				 Saida_32bits_PC : out  STD_LOGIC_VECTOR ((WSIZE-1) downto 0));
	end component;	
	
	-- 4x1
	-- Mux da entrada B da ULA notar que a entrada sempre é 4 entao foi omitida está porta	
	component MIPS_Mux4x1_32bits_OrigBALU is
		 port (
				 -- Entradas
				 RegB 								 : in  STD_LOGIC_VECTOR ((WSIZE-1) downto 0);
				 Extensao_sinal 					 : in  STD_LOGIC_VECTOR ((WSIZE-1) downto 0);
				 Extensao_sinal_deslocado2bits : in  STD_LOGIC_VECTOR ((WSIZE-1) downto 0);
				 Seletor_OrigBALU 				 : in  STD_LOGIC_vector(1 downto 0);
				 -- Saidas
				 Saida_32bits_BALU 				 : out  STD_LOGIC_VECTOR ((WSIZE-1) downto 0));
	end component;	

	------------------------------------------------------------------------------------------------------------		
	---- Registradores
	component reg32 is
		port (
				-- Entradas
				clk, enable 	: in STD_LOGIC;
            estado_in 		: in  STD_LOGIC_VECTOR ((WSIZE-1) downto 0);
            -- Saidas
				estado_out 		: out  STD_LOGIC_VECTOR ((WSIZE-1) downto 0));
	end component;
	
	------------------------------------------------------------------------------------------------------------
	-- Binario para 7 segmentos
	component converter_bin_para_7seg is
		port (
				-- Entradas
				DADOSBIN : in STD_LOGIC_VECTOR(3 downto 0);
				-- Saidas			
				saida 	: out STD_LOGIC_VECTOR (7 downto 0)
				);
	end component;
	------------------------------------------------------------------------------------------------------------
	
	---- PC
		-- Entradas
			-- Clock
			-- Enable de escrita PC
			signal WrEnPC		: std_logic;
		-- Saidas
			-- Saida do Mux Orig PC
			signal SaidaOrigPC	: std_logic_vector((WSIZE-1) downto 0);
			-- Saida do PC
			signal SaidaPC		: std_logic_vector((WSIZE-1) downto 0);
	
	---- MUX IouD
		-- Entradas
			-- PC
			-- Saida da ULA
			signal RegALU			: std_logic_vector((WSIZE-1) downto 0);
		-- Saidas
			-- Cntr_IouD	
			-- Saida IouD
			signal SaidaIouD		: std_logic_vector(7 downto 0);
			
	---- MEM
		-- Entradas
			-- Saida IouD
			-- Saida B
			signal SaidaB			: std_logic_vector((WSIZE-1) downto 0);
			-- Cntr_EscreveMem
		-- Saidas
			-- Dados lidos da memoria
			signal DadosMem		: std_logic_vector((WSIZE-1) downto 0);
	
	---- RI
		-- Entradas
			-- Clock
			-- Cntr_EscreveIR
			-- Dados lidos da memoria			
		-- Saidas
			-- Saida do RI
			signal SaidaRI			: std_logic_vector((WSIZE-1) downto 0);
		
			-- Sinais RI
			signal RI_Opcode		: std_logic_vector(5 downto 0);
			signal RI_funct		: std_logic_vector(5 downto 0);
			signal RI_shamt		: std_logic_vector(4 downto 0);				
			signal RI_rs			: std_logic_vector(4 downto 0);
			signal RI_rt			: std_logic_vector(4 downto 0);
			signal RI_rd			: std_logic_vector(4 downto 0);
			signal RI_K_16			: std_logic_vector(15 downto 0);
			signal RI_K_26			: std_logic_vector(25 downto 0);	
		
	---- RDM
		-- Entradas
			-- Clock
			-- 1
			-- Dados lidos da memoria
		-- Saidas
			-- Saida do RDM
			signal SaidaRDM		: std_logic_vector((WSIZE-1) downto 0);
				
	---- CONTROLE
		-- Entradas
			-- Clock
			-- Opcode
		-- Saidas
			signal Cntr_OpALU, Cntr_OrigBALU, Cntr_OrigPC	   : std_logic_vector(1 downto 0);	
			signal Cntr_OrigAALU, Cntr_EscreveReg, Cntr_RegDst, 
			Cntr_MemparaReg, Cntr_EscrevePC, Cntr_EscrevePCBeq	: std_logic;
			signal Cntr_IouD, Cntr_EscreveMem, Cntr_LeMem, 
			Cntr_EscreveIR, Cntr_EscrevePCBne						: std_logic;
			signal Cntr_cntEnd											: std_logic_vector(1 downto 0);
	
	---- MUX RegDst
		-- Entradas
			-- rt
			-- rd
		-- Saidas
			-- Saida do Mux RegDst
			signal SaidaRegDst				: std_logic_vector(4 downto 0);
				
	---- MUX MemParaReg
		-- Entradas
			-- RegALU
			-- SaidaRDM
		-- Saidas
			-- Saida do Mux MemParaReg
			signal SaidaMemParaReg			: std_logic_vector((WSIZE-1) downto 0);	
	
	---- BREG
		-- Entradas
			-- rs
			-- rt
			-- SaidaRegDst
			-- SaidaMemParaReg
		-- Saidas
			-- RegA e RegB
			signal RegA, RegB 				: std_logic_vector(31 downto 0);
	
	---- Registradores A e B
		-- Entradas
			-- A: RegA
			-- B: RegB
		-- Saidas	
			signal SaidaRegA, SaidaRegB 			: std_logic_vector(31 downto 0);
			
	---- MUX OrigAALU e OrigBALU		
		-- Entradas
			-- A: SaidaPC, SaidaRegA
			-- B: SaidaRegB, 4, SaidaExtSinal, SaidaExtDesloc 
		-- Saidas	
			signal SaidaOrigAALU, SaidaOrigBALU : std_logic_vector(31 downto 0);
	
	---- Extensao de Sinal
		-- Entradas
			-- K16
		-- Saidas
			-- Signed K16
			signal SaidaExtSinal 					: std_logic_vector(31 downto 0);
	
	---- Deslocamento de 2 bits (32)
		-- Entradas
			-- SaidaExtSinal
		-- Saidas
			-- SaidaExt deslocada de 2 bits
			signal SaidaExtDesloc		 			: std_logic_vector(31 downto 0);
	
	----- Controle ALU
		-- Entradas
			-- Funct_ALU
			-- Opcode
			-- OpALU
		-- Saidas
			signal OperacaoALU 						: std_logic_vector(3 downto 0);
	
	---- Deslocamento de 2 bits p/ o Jump(26)
		-- Entradas
			-- k26
		-- Saidas
			-- PC[31:38] & k26 & 00
			signal EndJump 						: std_LOGIC_VECTOR(31 downto 0);
	
	-- ALU
		-- Entradas
			-- SaidaOrigAALU
			-- SaidaOrigBALU
			-- OperacaoALU
		-- Saidas
			signal SaidaULA 							: std_LOGIC_VECTOR(31 downto 0);
			signal VaiALU,ZeroALU,OvflALU 		: std_LOGIC;
	
	------------------------------------------------------------------------------------------------------------
	begin

		---- PC
		PC_32: reg32 port map (Clock, WrEnPC, SaidaOrigPC, SaidaPC);
		
		---- MUXIouD
		MUXIouD: MIPS_Mux2x1_32bits_IouD port map (SaidaPC(7 downto 0), ('1' & RegALU(8 downto 2)), Cntr_IouD, SaidaIouD);
		
		---- MEM
		MEM: RAM_MIPS port map (SaidaIouD, Clock, SaidaB, Cntr_EscreveMem, DadosMem);
	
		---- RI
		RI_32: reg32 port map (Clock, Cntr_EscreveIR, DadosMem, SaidaRI);
		---- Sinais RI,destrinchado
			 Ri_Opcode <= SaidaRI(31 downto 26);
			 Ri_funct<= SaidaRI(5 downto 0);
			 Ri_shamt<= SaidaRI(10 downto 6);		
			 Ri_Rs	<= SaidaRI(25 downto 21);
			 Ri_Rt<= SaidaRI(20 downto 16);
			 Ri_Rd<= SaidaRI(15 downto 11);
			 Ri_K_16<= SaidaRI(15 downto 0);
			 Ri_K_26<= SaidaRI(25 downto 0);
			
		---- RDM
		RDM_32: reg32 port map (Clock, '1', DadosMem, SaidaRDM);
		
		---- CONTROLE
		CONTROLE: cntrMIPS port map(Clock, Ri_Opcode, Cntr_OpALU, Cntr_OrigBALU, Cntr_OrigPC, Cntr_OrigAALU, 
		Cntr_EscreveReg, Cntr_RegDst, Cntr_MemparaReg, Cntr_EscrevePC, Cntr_EscrevePCBeq, Cntr_IouD, Cntr_EscreveMem,
		Cntr_LeMem, Cntr_EscreveIR, Cntr_EscrevePCBne, Cntr_cntEnd);
		
		-- MUX RegDst
		MUX_REGDST: MIPS_Mux2x1_5bits_RegEscrita port map(RI_rt, RI_rd, Cntr_RegDst, SaidaRegDst);

		-- MUX MemParaReg
		MUX_MEMPARAREG: MIPS_Mux2x1_32bits_MemparaReg port map(SaidaRDM, RegALU, Cntr_MemParaReg, SaidaMemParaReg);
		
		-- BREG 	
		BREG: bregMIPS port map(Clock, Cntr_EscreveReg, RI_rs, RI_rt, SaidaRegDst, SaidaMemParaReg, RegA, RegB);
		
		-- Extensao de Sinal 
		EXT_SINAL: extend_signal port map(RI_K_16, SaidaExtSinal);
		
		-- deslocamento 2bits
		DESLOC: SHIFT_2LEFT_32 port map(SaidaExtSinal, SaidaExtDesloc);
		
		-- Reg A
		REG_A_32: reg32 port map(Clock, '1', RegA, SaidaRegA);
		
		-- Reg B
		REG_B_32: reg32 port map(Clock, '1', RegB, SaidaRegB);
		
		-- Mux A
		MUX_A: mipS_Mux2x1_32bits_OrigAALU port map(SaidaRegA, SaidaPC, Cntr_OrigAALU, SaidaOrigAALU);
		
		-- Mux B
		MUX_B: mipS_Mux4x1_32bits_OrigBALU port map(SaidaRegB, SaidaExtSinal, SaidaExtDesloc, Cntr_OrigBALU, SaidaOrigBALU);
		
		-- Controle ALU
		CONTROLE_ALU: ALUcontrol port map(RI_Opcode, RI_funct, Cntr_OpALU, OperacaoALU);
		
		-- Endereco Jump
		DESLOC_JUMP: shiFT_2LEFT_26 port map (SaidaPC, RI_K_26, EndJump);
		
		-- ULA
		ULA: ula_OAC port map(OperacaoALU, SaidaOrigAALU, SaidaOrigBALU, SaidaULA, VaiALU, ZeroALU, OvflALU);
		
		-- Saida ALU
		REG_ULA: reg32 port map(Clock, '1', SaidaULA, RegALU);
		
		-- MUX OrigPC
		MUX_ORIGPC: MipS_Mux3x1_32bits_OrigPC port map (SaidaULA, RegALU, EndJump, Cntr_OrigPC, SaidaOrigPC);
		
		-- Desvios
		PC_DESVIOS: Pc_enable_combinacional port map(Cntr_EscrevePCBeq, Cntr_EscrevePCBne, ZeroALU, Cntr_EscrevePC, WrEnPC);
		
end architecture;