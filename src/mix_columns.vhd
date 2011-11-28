library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use ieee.std_logic_unsigned.all ;

entity mix_columns is
PORT (INPUT : in std_logic_vector(31 downto 0);
		OUTPUT : out std_logic_vector(31 downto 0)
		);
end mix_columns;

architecture Behavior of mix_columns is
--		  0	  1     2     3		  C
--		|"02"	"03"	"01"	"01"|		| C3 |
--		|"01"	"02"	"03"	"01"| *	| C2 |
--		|"01"	"01"	"02"	"03"|		| C1 |
--		|"03"	"01"	"01"	"02"|		| C0 |

signal C3 : std_logic_vector(7 downto 0);
signal C2 : std_logic_vector(7 downto 0);
signal C1 : std_logic_vector(7 downto 0);
signal C0 : std_logic_vector(7 downto 0);
begin
	C3 <= INPUT(31 downto 24);
	C2 <= INPUT(23 downto 16);
	C1 <= INPUT(15 downto 8);
	C0 <= INPUT(7 downto 0);

	-- XOR input with "1B" (0001 1011) only when MSB (or b7) of byte is 1
	OUTPUT(31 downto 24) <= ((C3(6 downto 0) & '0') xor ("000" & C3(7) & C3(7) & '0' & C3(7) & C3(7))) xor 			--x02
								  (((C2(6 downto 0) & '0') xor ("000" & C2(7) & C2(7) & '0' & C2(7) & C2(7))) xor C2) xor	--x03
									  C1 xor																											--x01
									  C0;																												--x01

	OUTPUT(23 downto 16) <=	  C3 xor																											--x01
									((C2(6 downto 0) & '0') xor ("000" & C2(7) & C2(7) & '0' & C2(7) & C2(7))) xor			--x02
								  (((C1(6 downto 0) & '0') xor ("000" & C1(7) & C1(7) & '0' & C1(7) & C1(7))) xor C1) xor	--x03
									  C0;																												--x01

	OUTPUT(15 downto 8) <=	  C3 xor																											--x01
									  C2 xor																											--x01
									((C1(6 downto 0) & '0') xor ("000" & C1(7) & C1(7) & '0' & C1(7) & C1(7))) xor			--x02
								  (((C0(6 downto 0) & '0') xor ("000" & C0(7) & C0(7) & '0' & C0(7) & C0(7))) xor C0);		--x03

	OUTPUT(7 downto 0) <=  (((C3(6 downto 0) & '0') xor ("000" & C3(7) & C3(7) & '0' & C3(7) & C3(7))) xor C3) xor	--x03
									  C2 xor																											--x01
									  C1 xor																											--x01
									((C0(6 downto 0) & '0') xor ("000" & C0(7) & C0(7) & '0' & C0(7) & C0(7)));				--x02
end architecture;
