library ieee;
use ieee.std_logic_1164.all;
use work.resources.all;

entity inv_final_round is
	port( state_in		   : in  state_array;
			roundkey_in		: in  round_key;
			state_out		: out state_array	);
end inv_final_round;

architecture structure of inv_final_round is

signal after_sbox, after_shiftRows : state_array;

begin
	U0: inv_shift_rows	port map(INPUT => state_in, OUTPUT => after_shiftRows);
	U1: inv_sbox 			port map(INPUT => after_shiftRows, OUTPUT => after_sbox);
	U2: add_round_key		port map(INPUT => after_sbox, KEY => roundkey_in, OUTPUT => state_out);
end structure;