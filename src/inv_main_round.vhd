library ieee;
use ieee.std_logic_1164.all;
use work.resources.all;

entity inv_main_round is
	port(	state_in		   : in  state_array;
			roundkey_in		: in  round_key;
			state_out		: out state_array	);
end inv_main_round;

architecture structure of inv_main_round is

signal after_sbox, after_shiftRows, after_add_round_key : state_array;

begin
	U0: inv_shift_rows	port map(INPUT => state_in, OUTPUT => after_shiftRows);
	U1: inv_sbox 			port map(INPUT => after_shiftRows, OUTPUT => after_sbox); -- 
	U2: add_round_key		port map(INPUT => after_sbox, KEY => roundkey_in, OUTPUT => after_add_round_key); -- state_out
	U3: inv_mix_columns	port map(INPUT => after_add_round_key, OUTPUT => state_out);
end structure;
