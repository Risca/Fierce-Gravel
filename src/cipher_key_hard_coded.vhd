library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.resources.all;
use work.variables.all;
-- Cipher key test vectors.
-- 2011-12-05
-- Author:	Daniel Josefsson and Patrik Dahlstrm
entity cipher_key_hard_coded is
		port(	OUTPUT	:	out	cipher_key );
end entity;

architecture impl of cipher_key_hard_coded is
	-- key length 128;
	constant column_128_0 : column :=( x"2b", x"7e", x"15", x"16" );
	constant column_128_1 : column :=( x"28", x"ae", x"d2", x"a6" );
	constant column_128_2 : column :=( x"ab", x"f7", x"15", x"88" );
	constant column_128_3 : column :=( x"09", x"cf", x"4f", x"3c" );
	
	
	-- key length 192;
	constant column_192_0 : column :=( x"8e", x"73", x"b0", x"f7" );
	constant column_192_1 : column :=( x"da", x"0e", x"64", x"52" );
	constant column_192_2 : column :=( x"c8", x"10", x"f3", x"2b" );
	constant column_192_3 : column :=( x"80", x"90", x"79", x"e5" );
	constant column_192_4 : column :=( x"62", x"f8", x"ea", x"d2" );
	constant column_192_5 : column :=( x"52", x"2c", x"6b", x"7b" );
	
	-- key length 256
	constant column_256_0 : column :=( x"00", x"01", x"02", x"03" );
	constant column_256_1 : column :=( x"04", x"05", x"06", x"07" );
	constant column_256_2 : column :=( x"08", x"09", x"0a", x"0b" );
	constant column_256_3 : column :=( x"0c", x"0d", x"0e", x"0f" );
	constant column_256_4 : column :=( x"10", x"11", x"12", x"13" );
	constant column_256_5 : column :=( x"14", x"15", x"16", x"17" );
	constant column_256_6 : column :=( x"18", x"19", x"1a", x"1b" );
	constant column_256_7 : column :=( x"1c", x"1d", x"1e", x"1f" );
--	constant column_256_0 : column :=( x"60", x"3d", x"eb", x"10" );
--	constant column_256_1 : column :=( x"15", x"ca", x"71", x"be" );
--	constant column_256_2 : column :=( x"2b", x"73", x"ae", x"f0" );
--	constant column_256_3 : column :=( x"85", x"7d", x"77", x"81" );
--	constant column_256_4 : column :=( x"1f", x"35", x"2c", x"07" );
--	constant column_256_5 : column :=( x"3b", x"61", x"08", x"d7" );
--	constant column_256_6 : column :=( x"2d", x"98", x"10", x"a3" );
--	constant column_256_7 : column :=( x"09", x"14", x"df", x"f4" );
	
	begin
		u1:	if key_length = 128 generate
					OUTPUT(0) <= column_128_0;
					OUTPUT(1) <= column_128_1;
					OUTPUT(2) <= column_128_2;
					OUTPUT(3) <= column_128_3;
				end generate;
		u2:	if key_length = 192 generate
					OUTPUT(0) <= column_192_0;
					OUTPUT(1) <= column_192_1;
					OUTPUT(2) <= column_192_2;
					OUTPUT(3) <= column_192_3;
					OUTPUT(4) <= column_192_4;
					OUTPUT(5) <= column_192_5;
				end generate;
		u3:	if key_length = 256 generate
					OUTPUT(0) <= column_256_0;
					OUTPUT(1) <= column_256_1;
					OUTPUT(2) <= column_256_2;
					OUTPUT(3) <= column_256_3;
					OUTPUT(4) <= column_256_4;
					OUTPUT(5) <= column_256_5;
					OUTPUT(6) <= column_256_6;
					OUTPUT(7) <= column_256_7;
				end generate;
end impl;