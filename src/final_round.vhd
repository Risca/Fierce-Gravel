library ieee;
use ieee.std_logic_1164.all;
use work.resources.all;

entity final_round is
	
	port
	(
		-- Input ports
		state_in		   : in  state_array;
		roundkey_in		: in  round_key;
		-- Output ports
		state_out		: out state_array
	);
end final_round;

architecture structure of final_round is

signal after_sbox, after_shiftRows : state_array;

begin
	U0: sbox 			port map(INPUT => state_in, OUTPUT => after_sbox);
	U1: shift_rows		port map(INPUT => after_sbox, OUTPUT => after_shiftRows);
	U2: add_round_key	port map(INPUT => after_shiftRows, KEY => roundkey_in, OUTPUT => state_out);
end structure;