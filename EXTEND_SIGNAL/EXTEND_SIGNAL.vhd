library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity extend_signal is
    Port ( V_in : in  STD_LOGIC_VECTOR (15 downto 0);
           V_out : out  STD_LOGIC_VECTOR (31 downto 0));
end extend_signal;

architecture extend_signal_arch of extend_signal is

begin
	process(V_in)
		begin 
			if(V_in(15)='1') then
				V_out <= X"FFFF"& V_in;
			else
				V_out <= X"0000" & V_in;
			end if;
	end process;			

end extend_signal_arch;

