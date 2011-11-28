-- Title:			wordrot_column
-- Date:				2011-11-28
-- Author:			Patrik Dahlström
-- Description:	This component shifts the rows of a state array

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.resources.all;

entity shift_rows is
	port(	STATE		:	in		state_array;
			OUTPUT	:	out	state_array);
end entity;

architecture impl of shift_rows is
begin
	shift_rows: for i in 0 to 3 generate
		u: wordrot_column PORT MAP (WORD => STATE(i),
											 OUTPUT => OUTPUT(i),
											 OFFSET => std_logic_vector(to_unsigned(i,2)));
	end generate shift_rows;
end impl;