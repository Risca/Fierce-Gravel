library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.resources.all;
-- Plain text test vectors for AES test bench.
-- 2011-12-05
-- Author:	Daniel Josefsson and Patrik Dahlstrm
entity plain_text_hard_coded is
		port	(	SEL		:	in		std_logic_vector(1 downto 0);
					OUTPUT	:	out	state_array
				);
end entity;

architecture impl of plain_text_hard_coded is
	-- First round;
	constant first_round	: state_array :=	(	( x"32", x"43", x"f6", x"a8" ),
															( x"88", x"5a", x"30", x"8d" ),
															( x"31", x"31", x"98", x"a2" ),
															( x"e0", x"37", x"07", x"34" )
														);
	-- Main round;
	constant main_round	 : state_array :=	(	( x"19", x"3d", x"e3", x"be" ),
															( x"a0", x"f4", x"e2", x"2b" ),
															( x"9a", x"c6", x"8d", x"2a" ),
															( x"e9", x"f8", x"48", x"08" )
														);
	-- Final round
	constant final_round : state_array :=	(	( x"eb", x"40", x"f2", x"1e" ),
															( x"59", x"2e", x"38", x"84" ),
															( x"8b", x"a1", x"13", x"e7" ),
															( x"1b", x"c3", x"42", x"d2" )
														);
	-- Undefined
	constant undefined 	: state_array :=	(	( x"00", x"00", x"00", x"00" ),
															( x"00", x"00", x"00", x"00" ),
															( x"00", x"00", x"00", x"00" ),
															( x"00", x"00", x"00", x"00" )
														);
	begin
		OUTPUT <=	first_round when 	SEL = "00" else
						main_round when 	SEL = "01" else
						final_round when 	SEL = "10" else
						undefined;
end impl;