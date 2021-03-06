library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALUcontrol is
    Port ( 
            Opcode_ALU : in  STD_LOGIC_VECTOR (5 downto 0);
				funct_ALU: in  STD_LOGIC_VECTOR (5 downto 0);
				Seletor_OPALU : in  STD_LOGIC_vector(1 downto 0);
				Saida_seletorALU : out  STD_LOGIC_VECTOR (3 downto 0));
end ALUcontrol;

architecture ALUcontrol of ALUcontrol is

begin
	process(Seletor_OPALU,funct_ALU,Opcode_ALU)
			begin 
			case Seletor_OPALU is 
				when "00" => Saida_seletorALU <= "0010";
				when "01" => Saida_seletorALU <= "0100";
				-- funct seleciona tipo R 
				when "10" =>
					case funct_ALU is 
					 --ADD (já implementado na ULA); Opcode = 000000 Funct =10 0000
				   	when "100000" =>Saida_seletorALU<="0010";
					 --SUB (já implementado na ULA); Opcode = 000000 Funct = 10 0010
						when "100010" =>Saida_seletorALU<="0100";
					--AND (já implementado na ULA); Opcode = 000000 Funct =10 0100
						when "100100" =>Saida_seletorALU<="0000";
					--OR (já implementado na ULA); Opcode = 000000 Funct =10 0101
						when "100101" =>Saida_seletorALU<="0001";
					--NOR (já implementado na ULA);Opcode = 000000 Funct =10 0111
						when "100111" =>Saida_seletorALU<="1000";
					--XOR (já implementado na ULA); Opcode = 000000 Funct = 10 0110
						when "100110" =>Saida_seletorALU<="1001";
					--SLT (já implementado na ULA); Opcode = 000000 Funct = 10 1010
					   when "101010" =>Saida_seletorALU<="0110";	
					--NAND (já implementado na ULA); Opcode = 000000 Funct =???? -- dado que nand é do tipo R ,funct  inventado !!!!!!
					   when "000111" =>Saida_seletorALU<="0111";	
					--SLL (já implementado na ULA); Opcode = 000000 Funct = 10 1010
					   when "000000" =>Saida_seletorALU<="1010";	
					--SRL  (já implementado na ULA); Opcode = 000000 Funct = 10 1010
					   when "000010" =>Saida_seletorALU<="1011";	
				
				
						when others => Saida_seletorALU <="0000";
					end case;			
							
				when "11" => 
					-- jump precisa ?? 
			   	case Opcode_ALU is 
					 --ADDi; Opcode = 00 1000
					   	when "001000" =>Saida_seletorALU<="0010";
					 --ANDi; Opcode = 00 1100
	    					when "001100" =>Saida_seletorALU<="0000";
					 --ORi; Opcode =  00 1101
							when "001101" =>Saida_seletorALU<="0001";
					 --SLTi; Opcode = 00 1010
							when "001010" =>Saida_seletorALU<="0110";
							
					      when others => Saida_seletorALU <="0000";
					end case;	
				
				when others => Saida_seletorALU <= "0000";

			end case;
end process;
end ALUcontrol;
