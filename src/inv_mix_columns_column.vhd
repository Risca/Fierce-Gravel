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
	-- This is voodoo magic!
	u1: GF_1248_multiply port map(INPUT => INPUT, OUTPUT => products);
	
	OUTPUT(0) <= ( products(3)(0) xor products(2)(0) xor products(1)(0) ) xor --*0e
					 ( products(3)(1) xor products(1)(1) xor products(0)(1) ) xor --*0b
					 ( products(3)(2) xor products(2)(2) xor products(0)(2) ) xor --*0d
					 ( products(3)(3) xor products(0)(3) );							  --*09

	OUTPUT(1) <= ( products(3)(1) xor products(2)(1) xor products(1)(1) ) xor --*0e
					 ( products(3)(2) xor products(1)(2) xor products(0)(2) ) xor --*0b
					 ( products(3)(3) xor products(2)(3) xor products(0)(3) ) xor --*0d
					 ( products(3)(0) xor products(0)(0) );							  --*09
		
	OUTPUT(2) <= ( products(3)(2) xor products(2)(2) xor products(1)(2) ) xor --*0e
					 ( products(3)(3) xor products(1)(3) xor products(0)(3) ) xor --*0b
					 ( products(3)(0) xor products(2)(0) xor products(0)(0) ) xor --*0d
					 ( products(3)(1) xor products(0)(1) );							  --*09
		
	OUTPUT(3) <= ( products(3)(3) xor products(2)(3) xor products(1)(3) ) xor --*0e
					 ( products(3)(0) xor products(1)(0) xor products(0)(0) ) xor --*0b
					 ( products(3)(1) xor products(2)(1) xor products(0)(1) ) xor --*0d
					 ( products(3)(2) xor products(0)(2) );							  --*09

end architecture;
