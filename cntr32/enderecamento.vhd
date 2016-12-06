----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:22:22 12/02/2016 
-- Design Name: 
-- Module Name:    enderecamento - enderecamento_op 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity enderecamento is
    Port ( opcode : in  STD_LOGIC_VECTOR (5 downto 0);
           somador : in  STD_LOGIC_VECTOR (3 downto 0);
           CtlEnd : in  STD_LOGIC_VECTOR (1 downto 0);
			  PE : out STD_LOGIC_VECTOR(3 downto 0));
end enderecamento;

architecture enderecamento_op of enderecamento is
	-- Tabela de despacho 1
	component romDespacho1 is
    Port ( Op : in  STD_LOGIC_VECTOR (5 downto 0);
           Valor : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	-- Tabela de despacho 2
	component romDespacho2 is
    Port ( Op : in  STD_LOGIC_VECTOR (5 downto 0);
           Valor : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	-- Multiplexador 4 entradas de 4 bits
	component mux4 is
    Port ( mux_in0, mux_in1, mux_in2, mux_in3 : in  STD_LOGIC_VECTOR (3 downto 0);
           mux_select : in  STD_LOGIC_VECTOR (1 downto 0);
           mux_out : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	-- Sinais auxiliares
	signal despacho1, despacho2 : STD_LOGIC_VECTOR(3 downto 0);
begin
	-- Conectando os blocos da lógica de seleção de endereço
	rom1 : romDespacho1 port map (opcode, despacho1);
	rom2 : romDespacho2 port map (opcode, despacho2);
	mux : mux4 port map ("0000", despacho1, despacho2, somador, CtlEnd, PE);
		
end enderecamento_op;

