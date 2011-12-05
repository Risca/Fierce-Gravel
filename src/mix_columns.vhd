library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use ieee.std_logic_unsigned.all ;
use work.resources.all;

entity mix_columns is
PORT (INPUT : in state_array;
		OUTPUT : out state_array
		);
end mix_columns;

architecture Behavior of mix_columns is
component mix_columns_column
	PORT (INPUT : in column;
			OUTPUT : out column
			);
end component;

begin
	u1: for n in 3 downto 0 generate
		u: mix_columns_column PORT MAP( INPUT => INPUT(n), OUTPUT => OUTPUT(n));
	end generate;
end architecture;
