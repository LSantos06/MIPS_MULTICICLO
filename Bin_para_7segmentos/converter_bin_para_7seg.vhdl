library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Recebe DADOSBIN (0000 ate 1111) e transforma para 7-seg(0 ate F) cada segmento é selecionado pela saida<7> ate saida<0>,visto 
--que a saida<0> sera o do ponto.
entity converter_bin_para_7seg is
Port (
DADOSBIN:in STD_LOGIC_VECTOR(3 downto 0);
saida:out STD_LOGIC_VECTOR (7 downto 0));
end converter_bin_para_7seg;
architecture Behavioral of converter_bin_para_7seg is
begin

with DADOSBIN select
	saida<=		
				"00000011"when"0000",--0
				"10011111"when"0001",--1
				"00100101"when"0010",--2
				"00001101"when"0011",--3
				"10011001"when"0100",--4
				"01001001"when"0101",--5
				"01000001"when"0110",--6
				"00011111"when"0111",--7
				"00000001"when"1000",--8
				"00001001"when"1001",--9
				"00010001"when"1010",--A
				"11000001"when"1011",--B
				"01100011"when"1100",--C
				"10000101"when"1101",--D
				"01100001"when"1110",--E
				"01110001"when"1111",--F
				"11111111"when others;
end Behavioral;

