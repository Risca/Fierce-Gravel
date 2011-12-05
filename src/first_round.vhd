library ieee;
use ieee.std_logic_1164.all;
use work.resources.all;

entity first_round is
	
	port
	(
		-- Input ports
		plaintext_in	: in  state_array;
		cipherKey_in	: in  round_key;
		
		-- Output ports
		output 			: out state_array
	);
end first_round;

architecture structure of first_round is
begin
U0: add_round_key port map(STATE => plaintext_in,
									KEY => cipherKey_in,
									OUTPUT => output);
end structure;
