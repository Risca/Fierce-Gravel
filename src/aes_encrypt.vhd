library ieee;
use ieee.std_logic_1164.all;
use work.resources.all;

-- Top level entity for the Fierce-Gravel AES encryptor

entity aes_encrypt is
	port(	PLAINTEXT	: in  state_array;
			CIPHERKEY	: in  cipher_key;
			CPHERTEXT	: out state_array);
end aes_encrypt;

architecture structure of aes_encrypt is
	type state_t is array(0 to (Nr-1)) of state_array;
	signal after_main_rounds : state_array;
	signal state : state_t;
	signal round_keys : round_keys_t;
	
begin
	
	KE: key_expansion port map(INPUT => CIPHERKEY, OUTPUT => round_keys);
	U0: first_round port map(plaintext_in => PLAINTEXT, cipherkey_in => round_keys(0), output => state(0));
	
	-- Generate (Nr-1) main rounds
	V1: for i in 1 to (Nr-1) generate
		MR: main_round port map(state_in => state(i-1), roundkey_in => round_keys(i), state_out => state(i) );		
	end generate;
	
	U1: final_round port map(state_in => state(Nr-1), roundkey_in => round_keys(Nr), state_out => after_main_rounds );		

end structure;
