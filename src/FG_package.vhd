-- Package declaration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package resources is
	type byte is array (7 downto 0) of std_logic;
	-- To index column Foo: Foo(byte)(bit);
	type column is array (3 downto 0) of byte;
	-- To index state_array Foo: Foo(column)(byte)(bit);
	type state_array is array (3 downto 0) of column;

	component hex_2_7seg
	port(	HEX		:	in		std_logic_vector(3 downto 0);
			abcdefg	:	out	std_logic_vector(0 to 6));
	end component hex_2_7seg;
	
	component add_round_key
	port(	STATE		:	in		state_array;
			KEY		:	in		state_array;
			OUTPUT	:	out	state_array);
	end component add_round_key;
	
	component mix_columns
	PORT (INPUT		: in	state_array;
			OUTPUT	: out	state_array
		);
	end component;

	-- Overloaded operators
	function "xor" (L,R : byte) return byte;
	function "xor" (L,R : column) return column;
	function "xor" (L,R : state_array) return state_array;
	function to_std_logic_vector (INPUT : byte) return std_logic_vector;
	function to_byte (INPUT : std_logic_vector) return byte;
	function to_integer (INPUT : byte) return integer;
end package resources;

library ieee;
use ieee.std_logic_1164.all;

package body resources is
	function "xor" (L,R : byte) return byte is
		variable result : byte;
	begin
		for n in 7 downto 0 loop
			result(n) := L(n) xor R(n);
		end loop;
		return result;
	end function;

	function "xor" (L,R : column) return column is
		variable result : column;
	begin
		result(3) := L(3) xor R(3);
		result(2) := L(2) xor R(2);
		result(1) := L(1) xor R(1);
		result(0) := L(0) xor R(0);
		return result;
	end function;
	
	function "xor" (L,R : state_array) return state_array is
		variable result : state_array;
	begin
		result(3) := L(3) xor R(3);
		result(2) := L(2) xor R(2);
		result(1) := L(1) xor R(1);
		result(0) := L(0) xor R(0);
		return result;
	end function;
	
	function to_std_logic_vector(INPUT : byte) return std_logic_vector is
	begin
		return INPUT(7) & INPUT(6) & INPUT(5) & INPUT(4) & INPUT(3) & INPUT(2) & INPUT(1) & INPUT(0);
	end function;
	
	function to_byte (INPUT : std_logic_vector) return byte is
	begin
		return (INPUT(7),INPUT(6),INPUT(5),INPUT(4),INPUT(3),INPUT(2),INPUT(1),INPUT(0));
	end function;
	
	function to_integer (INPUT : byte) return integer is
	begin
		return to_integer(unsigned(to_std_logic_vector(INPUT)));
	end function;
end package body resources;
