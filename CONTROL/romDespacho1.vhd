library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity romDespacho1 is
    Port ( Op : in  STD_LOGIC_VECTOR (5 downto 0);
			  funct : in  STD_LOGIC_VECTOR (5 downto 0);	
			  Reg_Rt : in STD_LOGIC_VECTOR(4 downto 0);
           Valor : out  STD_LOGIC_VECTOR (4 downto 0));
end romDespacho1;

architecture romDespacho1_op of romDespacho1 is
signal Op_e_funct	: std_logic_vector(11 downto 0);
begin
-- para nao alterar muito no codigo foi feito uma verificação antes de tudo  para ver se é SRL



process(Op, funct, Reg_Rt)
	begin
		case OP is 
			when "000000" =>  
							case funct is
									-- SRL
									when "000010" => valor <= "01101";
									-- Tipo R
									when others =>   valor <= "00110";
							end case;
			-- Jump
			when "000010" => valor <= "01001";		
		-- Beq
			when "000100" => valor <= "01000";
		--LoadWord	StoreWord
			when "100011" => valor <= "00010";
			when "101011" => valor <= "00010";
		-- Tipo I	
			when "001000" => valor <= "01010";
			when "001101" => valor <= "01010";
			when "001100" => valor <= "01010";
			when "001010" => valor <= "01010";
		-- Bne	
			when "000101" => valor <= "01100";
		-- BGEZ E BLTZ 
			when "000001" =>
							case Reg_Rt is 
									when "00001" => valor <="01111"; 
									when "00000" => valor <="10000"; 
									when others => valor <= "00000";
							end case;								
							
							
			when others => valor <= "00000";
		end case;
	end process;	
end romDespacho1_op;