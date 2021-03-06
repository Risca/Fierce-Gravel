library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use ieee.std_logic_unsigned.all ;
use work.resources.all;

entity inv_mix_columns_column is
PORT (INPUT : in column;
		OUTPUT : out column
		);
end inv_mix_columns_column;

architecture behavior of inv_mix_columns_column is
--		  0	  1     2     3		  C
--		|"0e"	"0b"	"0d"	"09"|		| C0 |
--		|"09"	"0e"	"0b"	"0d"| *	| C1 |
--		|"0d"	"09"	"0e"	"0b"|		| C2 |
--		|"0b"	"0d"	"09"	"0e"|		| C3 |

signal C0 : byte;
signal C1 : byte;
signal C2 : byte;
signal C3 : byte;
signal products : state_array;
begin
	-- This is dark voodoo magic!
	u1: GF_1248_multiply port map(INPUT => INPUT, OUTPUT => products);
gen1: for i in 0 to 3 generate
	OUTPUT(i) <= ( products(3)( i ) 				xor products(2)( i )				xor products(1)( i ) ) 				xor	--*0e
					 ( products(3)((i+1) mod 4)	xor products(1)((i+1) mod 4) 	xor products(0)((i+1) mod 4) ) 	xor	--*0b
					 ( products(3)((i+2) mod 4) 	xor products(2)((i+2) mod 4) 	xor products(0)((i+2) mod 4) ) 	xor	--*0d
					 ( products(3)((i+3) mod 4) 	xor products(0)((i+3) mod 4) );							  						--*09
end generate;

end architecture;
