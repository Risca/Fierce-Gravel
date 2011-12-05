-- Package declaration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package resources is
	-- Set the key length
	constant key_length : integer := 256;
	constant Nb : integer := 4;
	constant Nk : integer := key_length/32;
	constant Nr : integer := 6+Nk;

	-- TYPE DEFINITIONS
	type byte is array (7 downto 0) of std_logic;
	-- To index column Foo: Foo(byte)(bit);
	type column is array (0 to 3) of byte;
	-- To index state_array Foo: Foo(column)(byte)(bit);
	type state_array is array (0 to 3) of column;
	
	subtype round_key is state_array;
	type round_keys_t is array (0 to Nr) of round_key; -- Nr+1 round keys
	type cipher_key is array (0 to 4*Nk-1) of column;

	-- COMPONENTS
	component sbox
	port(	INPUT		:	in		state_array;
			OUTPUT	:	out	state_array
	);
	end component;

	component sbox_byte
	port(	INPUT		:	in		byte;
			OUTPUT	:	out	byte);
	end component;

	component shift_rows
		port(	INPUT		:	in		state_array;
				OUTPUT	:	out	state_array);
	end component;

	component mix_columns
	PORT (INPUT		: in	state_array;
			OUTPUT	: out	state_array
		);
	end component;

	component add_round_key
	port(	INPUT		:	in		state_array;
			KEY		:	in		round_key;
			OUTPUT	:	out	state_array);
	end component add_round_key;

	component wordrot
	port(	WORD	:	in		column;
		OUTPUT	:	out	column;
		OFFSET	:	in		std_logic_vector(1 downto 0));
	end component;

	component hex_2_7seg
	port(	HEX		:	in		std_logic_vector(3 downto 0);
			abcdefg	:	out	std_logic_vector(0 to 6));
	end component hex_2_7seg;
	
	component first_round
	port(	plaintext_in	: in  state_array;
		   cipherKey_in	: in  round_key;
			output 			: out state_array);
	end component;

	component main_round
	port(	state_in	: in  state_array;
			roundkey_in	: in  round_key;
			state_out	: out state_array);
	end component;

	component final_round
	port(	state_in	: in  state_array;
			roundkey_in	: in  round_key;
			state_out	: out state_array);
	end component;

	component uart
	PORT (clk,rxd,rdn,wrn : in std_logic;
		din : in byte;
		dout : out byte;
		data_ready : out std_logic;
		tbre : out std_logic;
		sdo : out std_logic);
	end component;

	component key_expansion
		port(	INPUT	:	in	cipher_key;
				OUTPUT	:	out	round_keys_t);
	end component;
	
	component aes_encrypt
		port(	PLAINTEXT	: in  state_array;
				CIPHERKEY	: in  cipher_key;
				CIPHERTEXT	: out state_array);
	end component;
	
	-- OVERLOADED OPERATORS
	function "xor" (L,R : byte) return byte;
	function "xor" (L,R : column) return column;
	function "xor" (L,R : state_array) return state_array;
	-- function "xor" (L : state_array; R : round_key) return state_array;
	function rcon(INPUT : integer range 0 to 15) return column;
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
	
--	function "xor" (L : state_array; R : round_key) return state_array is
--		variable result : state_array;
--	begin
--		result(3) := L(3) xor R(3);
--		result(2) := L(2) xor R(2);
--		result(1) := L(1) xor R(1);
--		result(0) := L(0) xor R(0);
--		return result;
--	end function;
	
	function rcon(INPUT : integer range 0 to 15) return column is
	type rconROM_type is array (0 to 15) of byte;
	constant rconROMTable : rconROM_type :=(
	--   0      1      2      3      4      5      6      7
		x"00", x"01", x"02", x"04", x"08", x"10", x"20", x"40", 
	--	  8      9      a      b      c      d      e      f 
		x"80", x"1B", x"36", x"6C", x"D8", x"AB", x"4D", x"9A"
	);
	begin
		return (rconROMTable(INPUT),x"00",x"00",x"00");
	end function;
end package body resources;
