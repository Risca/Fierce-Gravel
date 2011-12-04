library ieee;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use ieee.std_logic_unsigned.all ;
use work.resources.all ;

entity uart is
PORT (clk,rxd,rdn,wrn : in std_logic;
	din : in byte;
	dout : out byte;
	data_ready : out std_logic;
	tbre : out std_logic;
	sdo : out std_logic);
end uart;

architecture v1 of uart is

component txmit
port (clk,wrn : in std_logic ;
	din  : in byte ;
	tbre : out std_logic ;
	sdo  : out std_logic 
);
end component ;

component rcvr 
port (clk,rxd,rdn : in std_logic;
	data_ready : out std_logic;
	dout       : out byte
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



