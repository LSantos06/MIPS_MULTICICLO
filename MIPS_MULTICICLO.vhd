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
	
	-- 3x1
	
	-- 4x1
	
	begin

end architecture;