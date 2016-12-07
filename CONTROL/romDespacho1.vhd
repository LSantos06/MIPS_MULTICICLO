library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity romDespacho1 is
    Port ( Op : in  STD_LOGIC_VECTOR (5 downto 0);
			  funct : in  STD_LOGIC_VECTOR (5 downto 0);	
           Valor : out  STD_LOGIC_VECTOR (3 downto 0));
end romDespacho1;

architecture romDespacho1_op of romDespacho1 is
signal Op_e_funct	: std_logic_vector(11 downto 0);
begin
-- para nao alterar muito no codigo foi feito uma verificação antes de tudo  para ver se é SRL
--	if(Op = "000000" and funct = "00 0010") then 
	--				valor <= "1101";
--	end if;			
	Op_e_funct<= Op & funct;
	with Op_e_funct select
		Valor <= 
   	-- SRL
			"1101" when "000000000010",	
		-- Tipo R 
			"0110" when "000000------",
		-- Jump
			"1001" when "000010------",
		-- Beq
			"1000" when "000100------",
		--LoadWord	StoreWord
			"0010" when "100011------"|"101011------",
		-- Tipo I	
			"1010" when "001000------"|"001101------"|"001100------"|"001010------",
		-- Bne	
			"1100" when "000101------",
			"0000" when others;

end romDespacho1_op;

