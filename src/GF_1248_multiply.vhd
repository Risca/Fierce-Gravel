-- Title:			GF_1248_multiply
-- Date:				2011-11-28
-- Author:			Daniel Josefsson
-- Description:	Returns a state array which contains 1,2,4 and 8 GF multiplications of INPUT.

library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use ieee.std_logic_unsigned.all ;
use work.resources.all;

entity GF_1248_multiply is
	port(	INPUT		: in 	column;
			OUTPUT	: out state_array	);
end entity GF_1248_multiply;

architecture Behavior of GF_1248_multiply is
	signal buff	:	state_array;

begin
	buff(0)	<=	INPUT;
	u1: for n in 1 to 3 generate
		u: GF_2_multiply PORT MAP( INPUT => buff(n - 1), OUTPUT => buff(n)	);
	end generate;
	OUTPUT <= buff;
end architecture;
