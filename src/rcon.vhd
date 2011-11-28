library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- Round constant process
-- 2011-11-28
-- Author:			Daniel Josefsson
-- Description:	Returns the round constant.
entity rcon is

	port 
	(
		INPUT		:	in		std_logic_vector(3 downto 0);
		OUTPUT	:	out	std_logic_vector(7 downto 0)
	);

end entity;

architecture impl of rcon is

	subtype rcon_subType is std_logic_vector(7 downto 0);
	type rconROM_type is array (0 to 15) of rcon_subType;
  
	constant rconROMTable : rconROM_type :=(
	--   0      1      2      3      4      5      6      7
		x"00", x"01", x"02", x"04", x"08", x"10", x"20", x"40", 
	--	  8      9      a      b      c      d      e      f 
		x"80", x"1B", x"36", x"6C", x"D8", x"AB", x"4D", x"9A"
	);

	begin
		rcon_lookup:process(INPUT)
		begin
			OUTPUT <= rconROMTable(to_integer(unsigned(INPUT)));
		end process rcon_lookup;
	
end impl;