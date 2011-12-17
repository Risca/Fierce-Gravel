library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.resources.all;
-- Ciphertext test vectors for AES decryption test bench.
-- 2011-12-17
-- Author:	Daniel Josefsson
entity cipher_text_hard_coded is
		port	(	SEL		:	in		std_logic_vector(1 downto 0);
					OUTPUT	:	out	state_array
				);
end entity;

architecture impl of cipher_text_hard_coded is
	-- AES-128;
	constant aes_128		: state_array :=	(	( x"69", x"c4", x"e0", x"d8" ),
															( x"6a", x"7b", x"04", x"30" ),
															( x"d8", x"cd", x"b7", x"80" ),
															( x"70", x"b4", x"c5", x"5a" )
														);
	-- AES-192;
	constant aes_192	 	: state_array :=	(	( x"dd", x"a9", x"7c", x"a4" ),
															( x"86", x"4c", x"df", x"e0" ),
															( x"6e", x"af", x"70", x"a0" ),
															( x"ec", x"0d", x"71", x"91" )
														);
	-- AES-256
	constant aes_256 		: state_array :=	(	( x"d2", x"2f", x"0c", x"29" ),
															( x"1f", x"fe", x"03", x"1a" ),
															( x"78", x"9d", x"83", x"b2" ),
															( x"ec", x"c5", x"36", x"4c" )
														);
	-- Test vector
	constant test_vector	: state_array :=	(	( x"00", x"11", x"22", x"33" ),
															( x"44", x"55", x"66", x"77" ),
															( x"88", x"99", x"aa", x"bb" ),
															( x"cc", x"dd", x"ee", x"ff" )
														);
	begin
		OUTPUT <=	aes_128 when 	SEL = "00" else
						aes_192  when 	SEL = "01" else
						aes_256 when 	SEL = "10" else
						test_vector;
end impl;