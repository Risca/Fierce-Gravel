library ieee;
use ieee.std_logic_1164.all;
use work.resources.all;

entity inv_first_round is
	port(	ciphertext_in	: in  state_array;
			cipherKey_in	: in  round_key;
			output 			: out state_array );
end inv_first_round;

architecture structure of inv_first_round is
begin
U0: add_round_key port map(INPUT => ciphertext_in,
									KEY => cipherKey_in,
									OUTPUT => output);
end structure;
