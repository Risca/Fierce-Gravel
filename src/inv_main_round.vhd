library ieee;
use ieee.std_logic_1164.all;
use work.resources.all;

entity inv_main_round is
	port(	state_in		   : in  state_array;
			roundkey_in		: in  round_key;
			state_out		: out state_array	);
end inv_main_round;

architecture structure of inv_main_round is

signal after_sbox, after_shiftRows, after_mixColumns : state_array;

begin
	U0: inv_shift_rows		port map(INPUT => state_in, OUTPUT => state_out); -- after_shiftRows
	-- sbox 			port map(INPUT => state_in, OUTPUT => after_sbox);
	-- U1: 
	-- U2: mix_columns	port map(INPUT => after_shiftRows, OUTPUT => after_mixColumns);
	-- U3: add_round_key	port map(INPUT => after_mixColumns, KEY => roundkey_in, OUTPUT => state_out);
end structure;
