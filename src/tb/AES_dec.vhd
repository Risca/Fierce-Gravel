-- Title:			AES_dec
-- Date:				2011-11-28
-- Author:			Daniel Josefsson
-- Description:	This test bench shall be used to test the decryption algorithm.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.variables.all;
use work.resources.all;

entity AES_dec is
	port 
	(
		SW		:	in std_logic_vector(17 downto 0);
		-- Displays
		HEX0	:	out std_logic_vector(0 to 6);
		HEX1	:	out std_logic_vector(0 to 6);
		HEX2	:	out std_logic_vector(0 to 6);
		HEX3	:	out std_logic_vector(0 to 6);
		HEX4	:	out std_logic_vector(0 to 6);
		HEX5	:	out std_logic_vector(0 to 6);
		HEX6	:	out std_logic_vector(0 to 6);
		HEX7	:	out std_logic_vector(0 to 6)
	);
end entity;

architecture impl of AES_dec is
	
	component cipher_key_hard_coded is
		port(	OUTPUT	:	out	cipher_key );
	end component;
	
	component cipher_text_hard_coded is
		PORT	(	SEL		:	in		std_logic_vector(1 downto 0);
					OUTPUT	:	out	state_array
				);
	end component;

	component key_expansion 
	port (	INPUT		:	in		cipher_key;
				OUTPUT	:	out	round_keys_t
			);
	end component;

	signal	returned_state					:	state_array;
	signal	decryption_input				:	state_array;
	signal	ciph_key							:  cipher_key;
	signal	round_keys						:	round_keys_t;
	signal	select_decryption_input		:	std_logic_vector(1 downto 0);
begin
	select_decryption_input <= SW(1 downto 0);

	CK0: cipher_key_hard_coded PORT MAP(ciph_key);
	-- K0: key_expansion PORT MAP(ciph_key, round_keys);
	-- Get decryption_input from a selection of specification decryption input chipher texts.
	-- 00 => AES-128, 01 => AES-192, 10 => AES-256, 11 => test vector.
	P0: cipher_text_hard_coded PORT MAP (select_decryption_input, decryption_input);
	-- Decrypting and start decrypting
	FG: aes_decrypt port map(CIPHERTEXT => decryption_input, CIPHERKEY => ciph_key, PLAINTEXT => returned_state);
	
	-- Use SW3 and SW2 to select which column of returned_state to show on HEX display
	D7: hex_2_7seg PORT MAP(std_logic_vector(returned_state(to_integer(unsigned(SW(3 downto 2))))(0)(7 downto 4)), HEX7);
	D6: hex_2_7seg PORT MAP(std_logic_vector(returned_state(to_integer(unsigned(SW(3 downto 2))))(0)(3 downto 0)), HEX6);
	D5: hex_2_7seg PORT MAP(std_logic_vector(returned_state(to_integer(unsigned(SW(3 downto 2))))(1)(7 downto 4)), HEX5);
	D4: hex_2_7seg PORT MAP(std_logic_vector(returned_state(to_integer(unsigned(SW(3 downto 2))))(1)(3 downto 0)), HEX4);
	D3: hex_2_7seg PORT MAP(std_logic_vector(returned_state(to_integer(unsigned(SW(3 downto 2))))(2)(7 downto 4)), HEX3);
	D2: hex_2_7seg PORT MAP(std_logic_vector(returned_state(to_integer(unsigned(SW(3 downto 2))))(2)(3 downto 0)), HEX2);
	D1: hex_2_7seg PORT MAP(std_logic_vector(returned_state(to_integer(unsigned(SW(3 downto 2))))(3)(7 downto 4)), HEX1);
	D0: hex_2_7seg PORT MAP(std_logic_vector(returned_state(to_integer(unsigned(SW(3 downto 2))))(3)(3 downto 0)), HEX0);
end impl;
