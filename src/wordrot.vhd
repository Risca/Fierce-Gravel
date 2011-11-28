-- Title:			rcon
-- Date:				2011-11-28
-- Author:			Daniel Josefsson
-- Description:	This function rotates the bytes of a word to the left.
--						OFFSET determines how many bytes OUTPUT will be rotated compared to WORD.

library ieee;
use ieee.std_logic_1164.all;

entity wordrot is

	port 
	(
		WORD		:	in		std_logic_vector(31 downto 0);
		OUTPUT	:	out	std_logic_vector(31 downto 0);
		OFFSET	:	in		std_logic_vector(1 downto 0)
	);
end entity;

architecture impl of wordrot is
	begin
	rotate:process(WORD, OFFSET)
	begin
		case OFFSET is
			when "00" =>
				OUTPUT <=	WORD;
			when "01" =>
				OUTPUT(31 downto 8) <=	WORD(23 downto 0);
				OUTPUT(7 downto 0) <=	WORD(31 downto 24);
			when "10" =>
				OUTPUT(31 downto 16) <=	WORD(15 downto 0);
				OUTPUT(15 downto 0) <=	WORD(31 downto 16);
			when "11" =>
				OUTPUT(31 downto 24) <=	WORD(7 downto 0);
				OUTPUT(23 downto 0) <=	WORD(31 downto 8);
			when others =>
				OUTPUT <=	WORD;
		end case;
	end process rotate;
	
end impl;