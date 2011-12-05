library ieee;
use ieee.std_logic_1164.all;
use work.resources.all;


entity clock_reg is
	port
	(
		-- Input ports
		input	: in  state_array;
		clock : in  std_logic;

		-- Output ports
		output: out state_array
	);
end clock_reg;


architecture behavior of clock_reg is
begin
	process(clock)
	begin
		if rising_edge(clock) then
			output <= input;
		end if;
	end process;


end behavior;
