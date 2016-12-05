----------------------------------------------------------------------------------
-- Trabalho 5 - Banco de registradores
-- Organização e arquitetura de Computadores - Turma C 
-- Aluno: Marcos Vinicius Prescendo Tonin
-- Matricula: 14/0153233
-- Arquivo: bregMIPS.vhdl
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity bregMIPS is
generic (WSIZE : natural := 32);
port (
clk, wren : in std_logic;
radd1, radd2, wadd : in std_logic_vector(4 downto 0);
wdata : in std_logic_vector(WSIZE-1 downto 0);
r1, r2 : out std_logic_vector(WSIZE-1 downto 0));
end bregMIPS;
-----------------------------------------------------------------------------------------------
-- WSIZE é o tamanho da palavra do banco de registradores--------------------------------------
--wren: habilitação de escrita. Ao ser acionado, o registrador endereçado por wadd é escrito---
--com o valor presente no barramento wdata na transição de subida do relógio.------------------
--clk: relógio do circuito.--------------------------------------------------------------------
--radd1: endereço do registrador a ser lido em r1, 5 bits.-------------------------------------
--radd2: endereço do registrador a ser lido em r2, 5 bits.-------------------------------------
--wdata: valor a ser escrito no registrador endereçado por wadd, 32 bits.----------------------
--r1: porta de saída para leitura do registrador endereçado por add1.--------------------------
--r2: porta de saída para leitura do registrador endereçado por add2.--------------------------
-----------------------------------------------------------------------------------------------
architecture Behavioral of bregMIPS is
-- CRIAR VETOR DE ARRAY E UM SINAL QUE É UM VETOR DE ARRAY
type breg is array(0 to WSIZE-1) of std_logic_vector(WSIZE-1 downto 0);
signal bregfile : breg :=( others => X"00000000");
 -- Sinal criado para array de vector (simulando o banco de registradores),iniciado com zero
-- memoria inicializada com as 32 posições tudo em zero
signal WriteAdd,ReadAdd1,ReadAdd2 :integer; -- Sinais de inteiros usados para achar a posição do array de memória 
signal AuxR1,AuxR2:std_logic_vector(WSIZE-1 downto 0); -- auxiliar  para por os valores que está no registrador de leitura

begin
WriteAdd <= to_integer(unsigned(wadd)); -- WriteAdd virá o indice que é o endereço do registrador de escrita
ReadAdd1 <= to_integer(unsigned(radd1));-- ReadAdd1 virá o indice que é o endereço do registrador de leitura (1)
ReadAdd2 <= to_integer(unsigned(radd2));-- ReadAdd2 virá o indice que é o endereço do registrador de leitura (2)
r1<=AuxR1;
r2<=AuxR2;
	process(clk) -- começa o process , similar ao ffD
	   begin
		if (rising_edge(clk)) then -- só lê ou escreve no breg se estiver no flanco de subida do clock 
			  if((wren = '1') and(WriteAdd/=0)) then  -- caso a enable da escrita seja ativado pode se escrever wdata
				-- em breg(endereço de escrita) ,vale salientar que se endereço de escrita for igual zero,
				-- nao se pode  escrever no registrador $0($zero)
						bregfile(WriteAdd)<=wdata;
				end if;				
						AuxR1<=bregfile(ReadAdd1);
						AuxR2<=bregfile(ReadAdd2);
			end if;  
end process;		  
end Behavioral;

