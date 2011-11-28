--    File Name:  txmit.vhd
--      Version:  1.1
--         Date:  January 22, 2000
--        Model:  Transmitter Chip
--
--      Company:  Xilinx
--
--
--   Disclaimer:  THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY 
--                WHATSOEVER AND XILINX SPECIFICALLY DISCLAIMS ANY 
--                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR
--                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.
--
--                Copyright (c) 2000 Xilinx, Inc.
--                All rights reserved

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;

entity txmit is
port (clk,wrn : in std_logic ;
	din : in std_logic_vector(7 downto 0) ;
	tbre : out std_logic ;
	sdo  : out std_logic 
);
end txmit ;

architecture v1 of txmit is
constant baudrate : integer := 115200;
signal tbr : std_logic_vector (7 downto 0) ;
begin

process (clk,wrn)
variable clk_count : integer :=0;
variable bit_count : integer :=0;
variable start_flag : boolean :=false;
begin
	if (rising_edge(clk)) then
		-- Let wrn tell us to latch input data (active low)
		if wrn='0' then			
			tbr <= din;
			tbre <= '0';
			clk_count:=0;
			start_flag:=true;
			-- We will begin sending data half a clock cycle after wrn go high
		end if;
		
		if start_flag=true then
			--since start_flag is set, clk_count continues counting
			--it will continue until start_flag is set to 0
			clk_count:= clk_count+1;
		end if;
		
		if(clk_count = 50000000/baudrate/2) then
			-- Increase bit counter
			bit_count:=bit_count+1;
			if bit_count=1 then
				-- Send start bit
				sdo <= '0';
			elsif bit_count > 1 and bit_count < 10 then
				-- bit_count will be 9 downto 2
				sdo <= tbr(bit_count-2);
			elsif bit_count=10 then
				-- Send stop bit
				sdo <= '1';
				-- Stop clk
				start_flag:=false;
				-- Reset bit and clk count
				bit_count:=0;
				clk_count:=0;
				-- Signal that transmit buffer register is empty
				tbre <= '1';
			end if;
		elsif(clk_count = 50000000/baudrate) then
			--5208 for 9600 baud[change the count for different baud(2)]
			--5208 clock pulse at 50MHz is the time for single serial pulse
			--the clk_count is reset to start for the next serial pulse
			clk_count:=0;
		end if;
	end if;
end process;
end ;
