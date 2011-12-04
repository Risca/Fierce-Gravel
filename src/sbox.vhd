library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.resources.all;
-- Byte subsitution function by s-box transformation.
-- 2011-12-04
-- Author:	Patrik Dahlström
-- Comment: Top level entity of substitution block

entity sbox is
	port(	INPUT		:	in		state_array;
			OUTPUT	:	out	state_array
	);
end entity;

architecture impl of sbox is
component sbox_byte
	port(	INPUT		:	in		byte;
			OUTPUT	:	out	byte
	);
end component;
begin
	u1: for c in 3 downto 0 generate
		u2: for b in 3 downto 0 generate
			u: sbox_byte PORT MAP( INPUT => INPUT(c)(b), OUTPUT => OUTPUT(c)(b));
		end generate;
	end generate;
end impl;