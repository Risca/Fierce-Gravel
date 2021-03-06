library ieee;
use ieee.std_logic_1164.all;
use work.resources.all;
use work.variables.all;

-- Top level entity for the Fierce-Gravel AES decryptor

entity aes_decrypt is
	port(	CIPHERTEXT	: in  state_array;
			CIPHERKEY	: in  cipher_key;
			PLAINTEXT	: out state_array);
end aes_decrypt;

architecture structure of aes_decrypt is
	type state_t is array(0 to (Nr-1)) of state_array;
--	signal after_main_rounds : state_array;
	signal state : state_t;
	signal round_keys : round_keys_t;
	
	
	
	signal after_first: state_array;
begin
	KE: key_expansion port map(INPUT => CIPHERKEY, OUTPUT => round_keys);
	U0: inv_first_round port map(ciphertext_in => CIPHERTEXT, cipherkey_in => round_keys(Nr), output => state(0)); -- PLAINTEXT
	
	--	 Generate (Nr-1) main rounds
	U1: for i in 1 to (Nr-1) generate
		MR: inv_main_round port map(state_in => state(i-1), roundkey_in => round_keys(Nr - i), state_out =>  state(i)); -- PLAINTEXT
	end generate;
	U2: inv_final_round port map(state_in => state(Nr-1), roundkey_in => round_keys(0), state_out => PLAINTEXT );
end structure;
