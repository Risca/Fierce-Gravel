library ieee;
use ieee.std_logic_1164.all;
use work.resources.all;

-- Selects between input0 and input1 with address.


entity state_mux is
	port
	(
		-- Input ports
		input0 	: in  state_array;
		input1 	: in  state_array;
		address  : in  std_logic;

		-- Output ports
		output 	: out state_array
	);
end state_mux;



architecture behavior of state_mux is

begin
with address select
	output <= input0 when '0',
				 input1 when '1',
				 null   when others;
end behavior;
