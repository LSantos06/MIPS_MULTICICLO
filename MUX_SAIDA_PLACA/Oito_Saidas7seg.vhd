library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Oito_Saidas7seg is
    Port ( entradas : in  STD_LOGIC_VECTOR (31 downto 0);
           saidas_7seg : out  STD_LOGIC_VECTOR (63 downto 0));
end Oito_Saidas7seg;
architecture Behavioral of Oito_Saidas7seg is

component converter_bin_para_7seg is
Port (
DADOSBIN:in STD_LOGIC_VECTOR(3 downto 0);
saida:out STD_LOGIC_VECTOR (7 downto 0));
end component;

begin

seg7_3ao0 :converter_bin_para_7seg port map(entradas(3 downto 0),saidas_7seg(7 downto 0));
seg7_7ao4 :converter_bin_para_7seg port map(entradas(7 downto 4),saidas_7seg(15 downto 8));
seg7_11ao8 :converter_bin_para_7seg port map(entradas(11 downto 8),saidas_7seg(23 downto 16));
seg7_15ao12 :converter_bin_para_7seg port map(entradas(15 downto 12),saidas_7seg(31 downto 24));
seg7_19ao16 :converter_bin_para_7seg port map(entradas(19 downto 16),saidas_7seg(39 downto 32));
seg7_23ao20 :converter_bin_para_7seg port map(entradas(23 downto 20),saidas_7seg(47 downto 40));
seg7_27ao24 :converter_bin_para_7seg port map(entradas(27 downto 24),saidas_7seg(55 downto 48));
seg7_31ao28 :converter_bin_para_7seg port map(entradas(31 downto 28),saidas_7seg(63 downto 56));


end Behavioral;

