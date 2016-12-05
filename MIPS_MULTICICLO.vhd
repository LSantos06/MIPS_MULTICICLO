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
				Clk					: in std_logic;
				Data					: in std_logic_vector ((WSIZE-1) DOWNTO 0);
				WrenBreg				: in std_logic;
				-- Saidas
				Q						: out std_logic_vector ((WSIZE-1) DOWNTO 0)
				);
	end component;
	
	-- Componente CONTROLE
	
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
				K32 		: out std_logic_vector (31 downto 0)
				);
	end component;		
	
	-- Controle da ULA
	
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
		 Port ( -- Entradas
				  RegPC 				  : in  STD_LOGIC_VECTOR ((WSIZE-1) downto 0);
				  SaidaALU_beq 	  : in  STD_LOGIC_VECTOR ((WSIZE-1) downto 0);
				  Seletor_IouD 	  : in  STD_LOGIC;
				  -- Saidas
				  Saida_32bits_IouD : out  STD_LOGIC_VECTOR ((WSIZE-1) downto 0));
	end component;
	
	-- 3x1
	--Multiplexador que atualiza o valor do PC

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
	-- Mux da entrada B da ULA notar que a entrada sempre é 4 entre foi omitida está porta	
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
	-- Binario para 7 segmentos
	component converter_bin_para_7seg is
		port (
				-- Entradas
				DADOSBIN : in STD_LOGIC_VECTOR(3 downto 0);
				-- Saidas			
				saida 	: out STD_LOGIC_VECTOR (7 downto 0)
				);
	end component;
-- fim dos components
-------------------------------------------------------------------------------------------------------------

	begin

end architecture;