-- Title:			AES
-- Date:				2011-11-28
-- Author:			Daniel Josefsson
-- Description:	This test bench shall be used to test the main algorithm.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.resources.all;

entity AES is
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

architecture impl of AES is
	
	component cipher_key_hard_coded is
		port(	OUTPUT	:	out	cipher_key );
	end component;
	
	component plain_text_hard_coded is
		PORT	(	SEL		:	in		std_logic_vector(1 downto 0);
					OUTPUT	:	out	state_array
				);
	end component;

	component key_expansion 
	port (
		INPUT		:	in		cipher_key;
		OUTPUT	:	out	round_keys
	);
	end component;

	signal	returned_state			:	state_array;
	signal	ciph_key					:  cipher_key;
	signal	generated_round_keys	:	round_keys;
	signal	select_round			:	std_logic_vector(1 downto 0);
begin
	select_round <= SW(1 downto 0);

	CK0: cipher_key_hard_coded PORT MAP(ciph_key);
	K0: key_expansion PORT MAP(ciph_key, generated_round_keys);
	P0: plain_text_hard_coded PORT MAP (select_round, returned_state);
	
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