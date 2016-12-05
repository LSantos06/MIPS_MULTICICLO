library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Trabalho 4: Organizacao e Arquitetura de Computadores 
-- Lucas Nascimento Santos Souza - 14/0151010
  
-- Projeto de uma ULA em VHDL 
-- 	# Duas entradas de dados: A e B;
-- 	# Uma saida de dados: Z;
-- 	# Sinal Zero: detecta valor zero na saida;
--		# Sinal Overflow: ativo quando a operacao de soma ou subtracao gerar resultado
-- que ultrapasse o limite de representacao em 32 bits;
--		# Operacoes (em Complemento de 2).

-- Formato da ULA 
entity ULA_OAC is
	generic (WSIZE 		: natural := 32);
	port( 
		opcode				: in std_logic_vector(3 downto 0);
	   A, B					: in std_logic_vector((WSIZE-1) downto 0);
	   Z						: out std_logic_vector((WSIZE-1) downto 0);
		vai, zero, ovfl	: out std_logic );
end ULA_OAC;

architecture comportamento of ULA_OAC is
	-- A resposta obtida por determinada operacao 
	signal resposta 	 					: std_logic_vector((WSIZE-1) downto 0);
	signal carry							: std_logic;
	signal overflow						: std_logic;

	-- Variaveis para implementacao do "vai" 
	signal A33bits    					: std_logic_vector(WSIZE downto 0);
	signal B33bits		    				: std_logic_vector(WSIZE downto 0);
	
	-- SOMA
	signal soma				 				: std_logic_vector(WSIZE downto 0);	
	
	-- SUBTRACAO
	signal subtracao						: std_logic_vector(WSIZE downto 0);	
	
	-- SHIFT
	signal numBitsToShift				: natural;
	
begin
	-- SAIDAS
	-- Resultado da operacao em Z
	Z <= resposta;
	vai <= carry;
	ovfl <= overflow;
		
	-- A e B com 33 bits
	A33bits <= '0' & A;
	B33bits <= '0' & B;	
	
	-- SOMA	
	-- Resultado da soma c/ "vai"
	soma <= std_logic_vector(unsigned(A33bits) + unsigned(B33bits)); 
		
	-- SUBTRACAO
	-- Resultado da subtracao c/ "vai"
	subtracao <= std_logic_vector(unsigned(A33bits) - unsigned(B33bits));
	
	-- SHIFT
	-- Numero de bits que serao deslocados nos shifts
	numBitsToShift <= (to_integer(unsigned(A)));
	
	processo_ula: process(opcode, A, B, resposta, carry, overflow, soma, subtracao, numBitsToShift) begin
	
		-- Se Z tem valor 0, a saida "zero" eh ativa 
		if (resposta = X"00000000") then zero <= '1'; else zero <= '0'; end if;

		-- Carry e Overflow se iniciam com valor 0
		carry <= '0';
		overflow <= '0';
		
		case opcode is
			-- AND
			when "0000" => resposta <= A and B;
			
			-- OR	
			when "0001" => resposta <= A or B; 				
		
			-- ADD
			-- Soma c/ deteccao de overflow
			when "0010" => resposta <= std_logic_vector(unsigned(A) + unsigned(B)); -- A + B 
								carry <= soma(WSIZE); -- carry_out = "vai"
								-- Se (+) + (+) = (-), Entao "ovfl" ativo
								-- Se (-) + (-) = (+), Entao "ovfl" ativo
								overflow <= (A(WSIZE-1) and B(WSIZE-1) and not(resposta(WSIZE-1))) or (not(A(WSIZE-1)) and not(B(WSIZE-1)) and resposta(WSIZE-1)); -- MSB: AB*Z + *A*BZ
								
			-- ADDU
			-- Soma s/ deteccao de overflow	
			when "0011" => resposta <= std_logic_vector(unsigned(A) + unsigned(B)); -- A + B 
								carry <= soma(WSIZE); -- carry_out = "vai"
			
			-- SUB
			-- Subtracao c/ deteccao de overflow	
			when "0100" => resposta <= subtracao((WSIZE-1) downto 0); -- A - B s/ borrow_out
								carry <= subtracao(WSIZE); -- borrow_out = "vai"
								-- Se (+) - (-) = (-), Entao "ovfl" ativo
								-- Se (-) - (+) = (+), Entao "ovfl" ativo
								overflow <= (A(WSIZE-1) and not(B(WSIZE-1)) and not(resposta(WSIZE-1))) or (not(A(WSIZE-1)) and B(WSIZE-1) and resposta(WSIZE-1)); -- MSB: A*B*Z + *ABZ
			
			-- SUBU
			-- Subtracao s/ deteccao de overflow
			when "0101" => resposta <= subtracao((WSIZE-1) downto 0); -- A - B s/ borrow_out
								carry <= subtracao(WSIZE); -- borrow_out = "vai"
			
			-- SLT
			--	Se A < B, Entao resposta = 1
			when "0110" => resposta <= (0 => subtracao(WSIZE-1), others => '0'); -- resposta(0) <= bit de sinal = subtracao(WSIZE-1)
								
			-- NAND
			when "0111" => resposta <= A nand B;
			
			-- NOR	
			when "1000" => resposta <= A nor B; 
			
			-- XOR
			when "1001" => resposta <= A xor B;
			
			-- SLL
			-- Shift Left Logical	
				-- Performs a shift-left on an UNSIGNED vector COUNT times.
				-- The vacated positions are filled with '0'.
				-- The COUNT leftmost elements are lost.			
			when "1010" => resposta <= std_logic_vector(shift_left(unsigned(B), numBitsToShift)); 
			
			-- SRL
			--	Shift Right Logical
				-- Performs a shift-right on an UNSIGNED vector COUNT times.
				-- The vacated positions are filled with '0'.
				-- The COUNT rightmost elements are lost.
			when "1011" => resposta <= std_logic_vector(shift_right(unsigned(B), numBitsToShift)); 
			
			-- SRA
			-- Shift Right Arithmetic 
				-- Performs a shift-right on a SIGNED vector COUNT times.
				-- The vacated positions are filled with the leftmost element, ARG'LEFT.
				-- The COUNT rightmost elements are lost.
			when "1100" => resposta <= std_logic_vector(shift_right(signed(B), numBitsToShift)); 
			
			-- Se outros opcodes, Entao resposta = 0
			when others => resposta <= (others => '0');
			
		end case;
		
	end process;
	
end architecture comportamento;