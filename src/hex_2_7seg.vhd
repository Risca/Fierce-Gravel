library ieee;
use ieee.std_logic_1164.all;
-- Simple 7 segment decoder
-- 2011-11-15
-- Author:	Daniel Josefsson
entity hex_2_7seg is

	port 
	(
		HEX		:	in		std_logic_vector(3 downto 0);
		abcdefg	:	out	std_logic_vector(0 to 6)
	);
end entity;

architecture impl of hex_2_7seg is
	begin
	decode:process(HEX)
	begin
		case HEX is
			when "0000" =>
				abcdefg <=	"0000001";
			when "0001" =>
				abcdefg <=	"1001111";
			when "0010" =>
				abcdefg <=	"0010010";
			when "0011" =>
				abcdefg <=	"0000110";
			when "0100" =>
				abcdefg <=	"1001100";
			when "0101" =>
				abcdefg <=	"0100100";
			when "0110" =>
				abcdefg <=	"0100000";
			when "0111" =>
				abcdefg <=	"0001111";
			when "1000" =>
				abcdefg <=	"0000000";
			when "1001" =>
				abcdefg <=	"0001100";
			when "1010" =>
				abcdefg <=	"0001000";
			when "1011" =>
				abcdefg <=	"1100000";
			when "1100" =>
				abcdefg <=	"0110001";
			when "1101" =>
				abcdefg <=	"1000010";
			when "1110" =>
				abcdefg <=	"0110000";
			when "1111" =>
				abcdefg <=	"0111000";
			when others =>
				abcdefg <=	"1111111";
		end case;
	end process decode;
	
end impl;