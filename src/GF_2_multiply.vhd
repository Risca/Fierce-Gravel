-- Title:			GF_2_multiply
-- Date:				2011-11-28
-- Author:			Daniel Josefsson
-- Description:	2 times the input with conditional xor if xor input(7) = 1 ).

library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use ieee.std_logic_unsigned.all ;
use work.resources.all;

entity GF_2_multiply is
	port(	INPUT		: in	column;
			OUTPUT	: out	column );
end entity;

architecture Behavior of GF_2_multiply is
	signal C0, C1, C2, C3 : byte;

begin
	C0 <= INPUT(0);
	C1 <= INPUT(1);
	C2 <= INPUT(2);
	C3 <= INPUT(3);

	-- XOR input with "1B" (0001 1011) only when MSB (or b7) of byte is 1
	OUTPUT(0) <= (C0(6 downto 0) & '0') xor ("000" & C0(7) & C0(7) & '0' & C0(7) & C0(7));
	OUTPUT(1) <= (C1(6 downto 0) & '0') xor ("000" & C1(7) & C1(7) & '0' & C1(7) & C1(7));
	OUTPUT(2) <= (C2(6 downto 0) & '0') xor ("000" & C2(7) & C2(7) & '0' & C2(7) & C2(7));
	OUTPUT(3) <= (C3(6 downto 0) & '0') xor ("000" & C3(7) & C3(7) & '0' & C3(7) & C3(7));
	
end architecture;
