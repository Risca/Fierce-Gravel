library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use ieee.std_logic_unsigned.all ;
use work.resources.all;

entity mix_columns_column is
PORT (INPUT : in column;
		OUTPUT : out column
		);
end mix_columns_column;

architecture Behavior of mix_columns_column is
--		  0	  1     2     3		  C
--		|"02"	"03"	"01"	"01"|		| C0 |
--		|"01"	"02"	"03"	"01"| *	| C1 |
--		|"01"	"01"	"02"	"03"|		| C2 |
--		|"03"	"01"	"01"	"02"|		| C3 |

signal products : state_array; -- Contains the input column multiplied by two.
begin
-- This is voodoo magic!
	u1: GF_1248_multiply port map(INPUT => INPUT, OUTPUT => products);

	gen1: for i in 0 to 3 generate
	OUTPUT(i) <= ( products(1)( i ) ) 														xor	--*02
					 ( products(1)((i+1) mod 4) 	xor products(0)((i+1) mod 4) ) 	xor	--*03
					 ( products(0)((i+2) mod 4) ) 											xor	--*01
					 ( products(0)((i+3) mod 4) );													--*01
	end generate;

end architecture;
