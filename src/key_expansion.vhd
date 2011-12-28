library ieee;
use ieee.std_logic_1164.all;
use work.resources.all;
use work.variables.all;

entity key_expansion is
	port (
		INPUT		:	in		cipher_key;
		OUTPUT	:	out	round_keys_t
	);
end entity;

architecture Behavior of key_expansion is
type round_keys_columns is array (0 to 4*(Nr+1)-1) of column;
signal W : round_keys_columns;
signal foo : round_keys_columns;
signal bar : round_keys_columns;
begin
	u1: for n in 0 to Nk-1 generate
		W(n) <= INPUT(n);
	end generate;
	
	u2: for n in Nk to 4*(Nr+1)-1 generate
		-- IF first column
		v1: if (n mod Nk) = 0 generate
			-- (W(n-1) -> word_rotation -> sbox) xor W(n-1) xor rcon(i/Nk) -> W(n)
			-- INPUT(n-1) -> word_rotation
			w1: wordrot PORT MAP (WORD => W(n-1), OUTPUT => foo(n-Nk), OFFSET => "11");
			-- word_rotation -> sbox
			w2: for b in 0 to 3 generate
				u: sbox_byte PORT MAP( INPUT => foo(n-Nk)(b), OUTPUT => bar(n-Nk)(b) );
			end generate;
			-- bar xor W(n-Nk) xor rcon(1/Nk) -> W(n)
			W(n) <= bar(n-Nk) xor W(n-Nk) xor rcon(n/Nk);
		end generate;
		-- ELSE IF 256 bit and... something
		v2: if (Nk > 6 and (n mod Nk) = 4) generate
			-- (W(n-1) -> sbox) xor W(n-1) -> W(n);
			-- W(n-1) -> sbox
			w1: for b in 0 to 3 generate
				u: sbox_byte PORT MAP( INPUT => W(n-1)(b), OUTPUT => foo(n-Nk)(b) );
			end generate;
			-- foo xor W(n-Nk) -> W(n)
			W(n) <= foo(n-Nk) xor W(n-Nk);
		end generate;
		-- ELSE
		v3: if ((n mod Nk) /= 0) and not (Nk > 6 and (n mod Nk) = 4) generate
			-- W(n-1) xor W(n-Nk) -> W(n)
			W(n) <= W(n-1) xor W(n-Nk);
		end generate;
	end generate;

	-- Connect W to OUTPUT
	u3: for n in 0 to Nr generate
		v1: for c in 0 to 3 generate
			OUTPUT(n)(c) <= W(4*n+c);
		end generate;
	end generate;
end architecture;