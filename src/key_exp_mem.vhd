-- Quartus II VHDL Template
-- Single-port RAM with single read/write address and initial contents
-- Title:			key_exp_mem
-- Date:				2011-11-28
-- Modified by:	Daniel Josefsson
-- Description:	This ROM is used to store the cipher key and the round keys.
--						data: Used when to write



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.resources.all;


entity key_exp_mem is

	generic 
	(
		-- DATA_WIDTH : natural := 32;
		 ADDR_WIDTH : natural := 6
	);

	port 
	(
		clk	: in std_logic;
		addr	: in std_logic_vector((ADDR_WIDTH - 1) downto 0);
		data	: in column;
		we		: in std_logic := '1';
		q		: out state_array
	);

end entity;

architecture rtl of key_exp_mem is

	-- Build a 2-D array type for the RAM
	type memory_t is array(2**(ADDR_WIDTH - 2) - 1 downto 0) of state_array;

	-- Declare the RAM signal.	
	signal ram : memory_t;

	-- Register to hold the address 
	signal addr_reg : std_logic_vector(ADDR_WIDTH - 1 downto 0);

begin

	process(clk)
	begin
	if(rising_edge(clk)) then
		if(we = '1') then
			ram(to_integer(unsigned(addr(ADDR_WIDTH - 1 downto 2))))(to_integer(unsigned(addr(1 downto 0)))) <= data;
		end if;

		-- Register the address for reading
		addr_reg <= addr;
	end if;
	end process;

	q <= ram(to_integer(unsigned(addr_reg(ADDR_WIDTH - 1 downto 2))));

end rtl;
