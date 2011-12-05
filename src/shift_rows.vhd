-- Title:			wordrot
-- Date:				2011-11-28
-- Author:			Patrik Dahlstrm
-- Description:	This component shifts the rows of a state array

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.resources.all;

entity shift_rows is
	port(	INPUT		:	in		state_array;
			OUTPUT	:	out	state_array);
end entity;

architecture impl of shift_rows is
	component wordrot
		port
		(
			WORD		:	in		column;
			OUTPUT	:	out	column;
			OFFSET	:	in		std_logic_vector(1 downto 0)
		);
	end component;
begin
	OUTPUT(0) <= (INPUT(0)(0), INPUT(1)(1), INPUT(2)(2), INPUT(3)(3));
	OUTPUT(1) <= (INPUT(1)(0), INPUT(2)(1), INPUT(3)(2), INPUT(0)(3));
	OUTPUT(2) <= (INPUT(2)(0), INPUT(3)(1), INPUT(0)(2), INPUT(1)(3));
	OUTPUT(3) <= (INPUT(3)(0), INPUT(0)(1), INPUT(1)(2), INPUT(2)(3));
	
end impl;