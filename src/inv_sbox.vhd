library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.resources.all;
-- Byte subsitution function by s-box transformation.
-- 2011-12-04
-- Author:	Patrik Dahlstrm
-- Comment: Top level entity of substitution block

entity inv_sbox is
	port(	INPUT		:	in		state_array;
			OUTPUT	:	out	state_array
	);
end entity;

architecture impl of inv_sbox is
component inv_sbox_byte
	port(	INPUT		:	in		byte;
			OUTPUT	:	out	byte
	);
end component;
begin
	u1: for c in 0 to 3 generate
		u2: for b in 0 to 3 generate
			u: inv_sbox_byte PORT MAP( INPUT => INPUT(c)(b), OUTPUT => OUTPUT(c)(b));
		end generate;
	end generate;
end impl;