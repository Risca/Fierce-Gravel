library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use ieee.resources.all ;

entity rcvr is
port (clk,rxd,rdn : in std_logic ;
	dout : out byte ;
	data_ready : out std_logic
) ;
end rcvr ;

architecture v1 of rcvr is
constant baudrate : integer := 115200;
signal rbr : byte := "00000000" ;
signal rsr: std_logic_vector(9 downto 0);
begin

process (clk)
variable clk_count : integer :=0;
variable bit_count : integer :=0;
variable start_flag : boolean :=false;
begin
	if (rising_edge(clk)) then
		--counting starts when receive line goes low (start bit).
		if (rxd= '0') then
			--start_flag is used to start counting clock pulse
			start_flag:=true;
		end if;
		if (start_flag = true) then
			--since start_flag is set, clk_count continues counting
			--it will continue until start_flag is set to 0
			clk_count:= clk_count+1;
		end if;
		if(clk_count = 50000000/baudrate/2) then
			--2604 for 9600 baud[change the count for different baud(1)]
			--means time to sample 9600 serial data
			--at 2604 times 50MHz clock cycle from the start of the start bit
			--the time is correct to sample at middle point of the received pulse
			if(bit_count < 10) then
				--the received data in 10 bit with start and stop bit
				--so only take first 10 samples from once the start_flag is set
				rsr(bit_count) <= rxd;
				--after sampling bit_count is incremented
				bit_count:=bit_count+1;
			elsif(bit_count = 10) then
				--coupling data to receive buffer register for 8 data bits
			   rbr <= byte(rsr(8 downto 1));
				--once the 10 bits are captured, the start_flag is reset
				start_flag:=false;
				--bit_count is reset to 0
				bit_count:=0;
				--reseting clk_count
				clk_count:=0;
				--signal that data is ready
				data_ready <= '1';
			end if;
		elsif(clk_count = 50000000/baudrate) then
			--5208 for 9600 baud[change the count for different baud(2)]
			--5208 clock pulse at 50MHz is the time for single serial pulse
			--the clk_count is reset to start for the next serial pulse
			clk_count:=0;
		end if;
		
		if rdn='0' then
			data_ready <= '0';
		end if ;
	end if;
end process;
-- Latch dout when rdn=0
dout <= rbr when rdn = '0' else "ZZZZZZZZ" ;

end ;
