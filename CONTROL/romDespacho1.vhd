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



process(Op,funct)
	begin
		case OP is 
			when "000000" =>  
							case funct is
									-- SRL
									when "000010" => valor <= "1101";
									-- Tipo R
									when others =>   valor <= "0110";
							end case;
			-- Jump
			when "000010" => valor <= "1001";		
		-- Beq
			when "000100" => valor <= "1000";
		--LoadWord	StoreWord
			when "100011" => valor <= "0010";
			when "101011" => valor <= "0010";
		-- Tipo I	
			when "001000" => valor <= "1010";
			when "001101" => valor <= "1010";
			when "001100" => valor <= "1010";
			when "001010" => valor <= "1010";
		-- Bne	
			when "000101" => valor <= "1100";
			when others => valor <= "0000";
		end case;
	end process;	
end romDespacho1_op;