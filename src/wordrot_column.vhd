-- Title:			wordrot_column
-- Date:				2011-11-28
-- Author:			Daniel Josefsson
-- Description:	This function rotates the bytes of a word to the left.
--						OFFSET determines how many bytes OUTPUT will be rotated compared to WORD.

library ieee;
use ieee.std_logic_1164.all;
use work.resources.all;

entity wordrot_column is
	port(	WORD		:	in		column;
			OUTPUT	:	out	column;
			OFFSET	:	in		std_logic_vector(1 downto 0));
end entity;

architecture impl of wordrot_column is
	begin
	rotate:process(WORD, OFFSET)
	begin
		case OFFSET is
			when "00" =>
				OUTPUT <=	WORD;
			when "01" =>
				OUTPUT <=	WORD(3) & WORD(0 to 2);
			when "10" =>
				OUTPUT <=	WORD(2 to 3) & WORD(0 to 1);
			when "11" =>
				OUTPUT <=	WORD(1 to 3) & WORD(0);
			when others =>
				OUTPUT <=	WORD;
		end case;
	end process rotate;
	
end impl;