library ieee;
use ieee.std_logic_1164.all;
use work.resources.all;

entity add_round_key is
	port(	STATE		:	in		state_array;
			KEY		:	in		state_array;
			OUTPUT	:	out	state_array);
end entity;

architecture Behavior of add_round_key is
begin
	OUTPUT <= STATE xor KEY;
end architecture;