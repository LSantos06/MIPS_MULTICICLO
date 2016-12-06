library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity extend_signal is
    Port ( K16 : in  STD_LOGIC_VECTOR (15 downto 0);
           SK16 : out  STD_LOGIC_VECTOR (31 downto 0));
end extend_signal;

architecture extend_signal_arch of extend_signal is

begin
	process(K16)
		begin 
			if(K16(15)='1') then
				SK16 <= X"FFFF"& K16;
			else
				SK16 <= X"0000" & K16;
			end if;
	end process;			

end extend_signal_arch;

