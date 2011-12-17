library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.resources.all;
-- Byte subsitution function by inverted s-box transformation.
-- 2011-12-17
-- Author:	Daniel Josefsson and Staffan Sjqvist
entity inv_inv_sbox_byte is
	port(	INPUT		:	in		byte;
			OUTPUT	:	out	byte
	);
end entity;

architecture impl of inv_inv_sbox_byte is
	type sboxROM_type is array (0 to 255) of byte;
	constant inv_sboxROMTable : sboxROM_type :=(
	--   0      1      2      3      4      5      6      7      8      9      a      b      c      d      e      f 
		x"52", x"09", x"6a", x"d5", x"30", x"36", x"a5", x"38", x"bf", x"40", x"a3", x"9e", x"81", x"f3", x"d7", x"fb",   --00
		x"7c", x"e3", x"39", x"82", x"9b", x"2f", x"ff", x"87", x"34", x"8e", x"43", x"44", x"c4", x"de", x"e9", x"cb",   --10
		x"54", x"7b", x"94", x"32", x"a6", x"c2", x"23", x"3d", x"ee", x"4c", x"95", x"0b", x"42", x"fa", x"c3", x"e4",   --20
		x"08", x"2e", x"a1", x"66", x"28", x"d9", x"24", x"b2", x"76", x"5b", x"80", x"a2", x"49", x"6d", x"8b", x"d1",   --30
		x"72", x"f8", x"f6", x"64", x"86", x"68", x"98", x"16", x"d4", x"a4", x"5c", x"cc", x"5d", x"65", x"b6", x"92",   --40
		x"6c", x"70", x"48", x"50", x"fd", x"ed", x"b9", x"da", x"5e", x"15", x"46", x"57", x"a7", x"8d", x"9d", x"84",   --50
		x"90", x"d8", x"ab", x"00", x"8c", x"bc", x"d3", x"0a", x"f7", x"e4", x"58", x"05", x"b8", x"b3", x"45", x"06",   --60
		x"d0", x"2c", x"1e", x"8f", x"ca", x"3f", x"0f", x"02", x"c1", x"af", x"bd", x"03", x"01", x"13", x"8a", x"6b",   --70
		x"3a", x"91", x"11", x"41", x"4f", x"67", x"dc", x"ea", x"97", x"f2", x"cf", x"ce", x"f0", x"b4", x"e6", x"73",   --80
		x"96", x"ac", x"74", x"22", x"e7", x"ad", x"35", x"85", x"e2", x"f9", x"37", x"e8", x"1c", x"75", x"df", x"6e",   --90
		x"47", x"f1", x"1a", x"71", x"1d", x"29", x"c5", x"89", x"6f", x"b7", x"62", x"0e", x"aa", x"18", x"be", x"1b",   --a0
		x"fc", x"56", x"3e", x"4b", x"c6", x"d2", x"79", x"20", x"9a", x"db", x"c0", x"fe", x"78", x"cd", x"5a", x"f4",   --b0
		x"1f", x"dd", x"a8", x"33", x"88", x"07", x"c7", x"31", x"b1", x"12", x"10", x"59", x"27", x"80", x"ec", x"5f",   --c0
		x"60", x"51", x"7f", x"a9", x"19", x"b5", x"4a", x"0d", x"2d", x"e5", x"7a", x"9f", x"93", x"c9", x"9c", x"ef",   --d0
		x"a0", x"e0", x"3b", x"4d", x"ae", x"2a", x"f5", x"b0", x"c8", x"eb", x"bb", x"3c", x"83", x"53", x"99", x"61",	--e0
		x"17", x"2b", x"04", x"7e", x"ba", x"77", x"d6", x"26", x"e1", x"69", x"14", x"63", x"55", x"21", x"0c", x"7d"		--f0
	);

	begin
		sbox_lookup:process(INPUT)
		begin
			OUTPUT <= inv_sboxROMTable(to_integer(unsigned(INPUT)));
		end process sbox_lookup;
	
end impl;