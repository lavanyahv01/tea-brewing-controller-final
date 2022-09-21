LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Source : https://www.edaplayground.com/x/5vEh

-- Set Generic g_CLKS_PER_BIT as follows:
-- g_CLKS_PER_BIT = (Frequency of i_Clk)/(Frequency of UART)
-- Example: 25 MHz Clock, 115200 baud UART
-- (25000000)/(115200) = 217
--
ENTITY uart_receiver_e is
	GENERIC(
		clk_per_bdrate	:	INTEGER := 1250
	);
	PORT(
			clk_i		:	IN STD_LOGIC;						-- system clock
			rst_i		:	IN STD_LOGIC;						-- reset system
			rx_data_i	:	IN STD_LOGIC;						-- input data serially
			rx_data_o	:	OUT STD_LOGIC_VECTOR(7 DOWNTO 0);	-- output 8-bit data
			rx_dv_o		:	OUT STD_LOGIC						-- output data valid
	);
END uart_receiver_e;