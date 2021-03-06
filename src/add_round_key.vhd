library ieee;
use ieee.std_logic_1164.all;
use work.resources.all;

entity add_round_key is
	port(	INPUT		:	in		state_array;
			KEY		:	in		round_key;
			OUTPUT	:	out	state_array);
end entity;

architecture Behavior of add_round_key is
begin
	OUTPUT <= INPUT xor KEY;
end architecture;