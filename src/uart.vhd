--    File Name:  uart.vhd
--      Version:  1.2
--         Date:  January 22, 2000
--        Model:  Uart Chip
-- Dependencies:  txmit.hd, rcvr.vhd
--
--      Company:  Xilinx
--  Modified by:  Patrik Dahlström
--
--   Disclaimer:  THESE DESIGNS ARE PROVIDED "AS IS" WITH NO WARRANTY 
--                WHATSOEVER AND XILINX SPECIFICALLY DISCLAIMS ANY 
--                IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR
--                A PARTICULAR PURPOSE, OR AGAINST INFRINGEMENT.
--
--                Copyright (c) 2000 Xilinx, Inc.
--                All rights reserved


library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use ieee.std_logic_unsigned.all ;

entity uart is
PORT (clk,rxd,rdn,wrn : in std_logic;
	din : in std_logic_vector(7 downto 0);
	dout : out std_logic_vector(7 downto 0);
	data_ready : out std_logic;
	tbre : out std_logic;
	sdo : out std_logic);
end uart;

architecture v1 of uart is

component txmit
port (clk,wrn : in std_logic ;
	din  : in std_logic_vector(7 downto 0) ;
	tbre : out std_logic ;
	sdo  : out std_logic 
);
end component ;

component rcvr 
port (clk,rxd,rdn : in std_logic;
	data_ready : out std_logic;
	dout       : out std_logic_vector(7 downto 0)
);
end component ;

begin
   
u1 : txmit PORT MAP 
	(clk => clk,
	wrn => wrn,
	din => din,
	tbre => tbre,
	sdo => sdo);

u2 : rcvr PORT MAP  
	(clk => clk,
	rxd => rxd,
	rdn => rdn,
	data_ready => data_ready,
	dout => dout) ;

end v1 ;



