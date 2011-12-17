library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use ieee.std_logic_unsigned.all ;
use work.resources.all;

entity inv_mix_columns is
PORT (INPUT : in state_array;
		OUTPUT : out state_array
		);
end inv_mix_columns;

architecture Behavior of inv_mix_columns is
component inv_mix_columns_column
	PORT (INPUT : in column;
			OUTPUT : out column
			);
end component;

begin
	u1: for n in 0 to 3 generate
		u: inv_mix_columns_column PORT MAP( INPUT => INPUT(n), OUTPUT => OUTPUT(n));
	end generate;
end architecture;
