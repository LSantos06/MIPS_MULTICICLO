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
				address				: in std_logic_vector (7 DOWNTO 0);
				clk					: in std_logic;
				data					: in std_logic_vector ((WSIZE-1) DOWNTO 0);
				wrenBreg				: in std_logic;
				-- Saidas
				q						: out std_logic_vector ((WSIZE-1) DOWNTO 0)
				);
	end component;
	
	-- Componente CONTROLE
	
	-- Componente BREG
	component bregMIPS is
		port (
				-- Entradas
				clk, wren : in std_logic;
				radd1, radd2, wadd : in std_logic_vector(4 downto 0);
				wdata : in std_logic_vector(WSIZE-1 downto 0);
				-- Saidas
				r1, r2 : out std_logic_vector(WSIZE-1 downto 0)
				);
	end component;
	
	-- Componente ULA
	component ULA_OAC is
		port (
				-- Entradas
				opcode				: in std_logic_vector(3 downto 0);
				A, B					: in std_logic_vector((WSIZE-1) downto 0);
				-- Saidas
				Z						: out std_logic_vector((WSIZE-1) downto 0);
				vai, zero, ovfl	: out std_logic 
				);
	end component;
	
	-------------------------------------------------------------------------------------------------------------
	---- Circuitos Combinacionais
	
	-- Extensao de Sinal
	component extend_signal is
		port (
				-- Entradas
				V_in : in  STD_LOGIC_VECTOR (15 downto 0);
				-- Saidas
				V_out : out  STD_LOGIC_VECTOR (31 downto 0)
				);
	end component;	
	
	-- Deslocamento de 2 a esquerda
	
	-- Controle da ULA
	
	-------------------------------------------------------------------------------------------------------------
	---- Multiplexadores
	
	-- 2x1
			-- Multiplexador Registrador de Escrita
			
			component MIPS_Mux2x1_5bits_RegEscrita is
				Port ( 
				-- entradas
					Rt : in  STD_LOGIC_VECTOR (4 downto 0);
					Rd : in  STD_LOGIC_VECTOR (4 downto 0);
					Seletor_RegDst : in  STD_LOGIC;
				--saida
					Saida_5bits : out  STD_LOGIC_VECTOR (4 downto 0));
				end component;
			
			-- Multiplexador dado para escrita
			
			component MIPS_Mux2x1_32bits_MemparaReg is
				Port ( 
				--entradas
						RegDadoMem : in  STD_LOGIC_VECTOR (31 downto 0);
						SaidaALU : in  STD_LOGIC_VECTOR (31 downto 0);
						Seletor_MemparaReg : in  STD_LOGIC;
				--saida
						Saida_32bits : out  STD_LOGIC_VECTOR (31 downto 0));
				end component;
		
		-- Multiplexador dado entrada A da ULA
	
			component MIPS_Mux2x1_32bits_OrigAALU is
					 Port ( 
					-- entradas
							  RegA : in  STD_LOGIC_VECTOR (31 downto 0);
							  RegPC : in  STD_LOGIC_VECTOR (31 downto 0);
							  Seletor_OrigAALU : in  STD_LOGIC;
					-- saida  
							  Saida_32bits_ALU : out  STD_LOGIC_VECTOR (31 downto 0));
				end component;
	
	-- 3x1
	
	--Multiplexador que atualiza o valor do PC
	
	component MIPS_Mux3x1_32bits_OrigPC is
    Port ( 
			-- entradas
			  PCmais4 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_saidaALU_BEQ : in  STD_LOGIC_VECTOR (31 downto 0);
			  PC_Jump : in  STD_LOGIC_VECTOR (31 downto 0);
           Seletor_OrigPC : in  STD_LOGIC_vector(1 downto 0);
         -- saida		
			  Saida_32bits_PC : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	-- 4x1
	
	-- Mux da entrada B da ULA notar que a entrada sempre é 4 entre foi omitida está porta
	
	component MIPS_Mux4x1_32bits_OrigBALU is
		 Port ( 
		 -- entradas
				  RegB : in  STD_LOGIC_VECTOR (31 downto 0);
				  Extensao_sinal : in  STD_LOGIC_VECTOR (31 downto 0);
				  Extensao_sinal_deslocado2bits : in  STD_LOGIC_VECTOR (31 downto 0);
				  Seletor_OrigBALU : in  STD_LOGIC_vector(1 downto 0);
		-- saida		
				  Saida_32bits_BALU : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
------------------------------------------------------------------------------------------------------------		
-- binario para 7 segmentos
			component converter_bin_para_7seg is
			Port (
			-- entrada
						DADOSBIN:in STD_LOGIC_VECTOR(3 downto 0);
			-- saida			
						saida:out STD_LOGIC_VECTOR (7 downto 0));
			end component;
-- fim dos components
-------------------------------------------------------------------------------------------------------------

	begin

end architecture;