-- Package declaration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package variables is
	-- This package contains variables (constants) that is needed to
	-- change the function of the algorithm. This file is ignored by git since
	-- the values needs to be alterd locally.
	-- If a variable is added should this file be pushed.
	
   -- CONSTANTS
	-- Set the key length
	-- 128, 192 or 256
	constant key_length : integer := 128;
    -- Block length
	constant Nb : integer := 4;
    -- Number of columns defined by key
	constant Nk : integer := key_length/32;
    -- Number of rounds
	constant Nr : integer := 6+Nk;

end package variables;