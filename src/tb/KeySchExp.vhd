-- Title:			KeySchExp
-- Date:				2011-11-28
-- Author:			Daniel Josefsson
-- Description:	This function implements the key schedule expansion.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.resources.all;

entity KeySchExp is

	generic 
	(
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 6
	);
	port 
	(
		CLOCK_50	: in std_logic;
		-- Switches
		-- SW(7 downto 0): data
		-- SW(15 downto 9): address
		-- SW(17): write switch
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

architecture impl of KeySchExp is
	COMPONENT sbox
		port 
		(
			INPUT		:	in		std_logic_vector(7 downto 0);
			OUTPUT	:	out	std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	component rcon
		port 
		(
			INPUT		:	in		std_logic_vector(3 downto 0);
			OUTPUT	:	out	std_logic_vector(7 downto 0)
		);
	end component;
	
	component wordrot_column
		port 
		(
			WORD		:	in		column;
			OUTPUT	:	out	column;
			OFFSET	:	in		std_logic_vector(1 downto 0)
		);
	end component;
	
	component key_exp_mem

		port 
		(
			clk	: in std_logic;
			addr	: in std_logic_vector(ADDR_WIDTH - 1 downto 0);
			data	: in std_logic_vector((DATA_WIDTH-1) downto 0);
			we		: in std_logic := '1';
			q		: out state_array
		);
	end component;
	component cipher_key_hard_coded is
		port(	OUTPUT	:	out	cipher_key );
	end component;
	
	component key_expansion 
	port (
		INPUT		:	in		cipher_key;
		OUTPUT	:	out	round_keys
	);
	end component;

	signal	read_data 		:	state_array;
	signal	ciph_key			:  cipher_key;
	signal	round_keys_gen	:	round_keys;
begin

	-- M0: key_exp_mem PORT MAP (CLOCK_50, SW(13 downto 8), SW(7 downto 0) & SW(7 downto 0) & SW(7 downto 0) & SW(7 downto 0),
	--									SW(14),
	--									read_data
	--									);
	CK0: cipher_key_hard_coded PORT MAP(ciph_key);
	K0: key_expansion PORT MAP(ciph_key, round_keys_gen);
	D7: hex_2_7seg PORT MAP(std_logic_vector(round_keys_gen(Nr)(0)(3)(7 downto 4)), HEX7);
	D6: hex_2_7seg PORT MAP(std_logic_vector(round_keys_gen(Nr)(0)(3)(3 downto 0)), HEX6);
	D5: hex_2_7seg PORT MAP(std_logic_vector(round_keys_gen(Nr)(1)(3)(7 downto 4)), HEX5);
	D4: hex_2_7seg PORT MAP(std_logic_vector(round_keys_gen(Nr)(1)(3)(3 downto 0)), HEX4);
	D3: hex_2_7seg PORT MAP(std_logic_vector(round_keys_gen(Nr)(2)(3)(7 downto 4)), HEX3);
	D2: hex_2_7seg PORT MAP(std_logic_vector(round_keys_gen(Nr)(2)(3)(3 downto 0)), HEX2);
	D1: hex_2_7seg PORT MAP(std_logic_vector(round_keys_gen(Nr)(3)(3)(7 downto 4)), HEX1);
	D0: hex_2_7seg PORT MAP(std_logic_vector(round_keys_gen(Nr)(3)(3)(3 downto 0)), HEX0);
end impl;
