LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ARCHITECTURE clock_divider_a OF clock_divider_e IS

	SIGNAL count_dot_s : INTEGER:= 1;
	SIGNAL count_dot_en_s : INTEGER:= 1;
	SIGNAL count_dash_s : INTEGER:= 1;
	SIGNAL count_dash_en_s : INTEGER:= 1;
	SIGNAL count_brd_s : INTEGER := 1;
	SIGNAL c_4Hz_en_s, c_4Hz_co_s, c_2Hz_en_s, c_2Hz_co_s, brd_s : STD_LOGIC;

BEGIN
	
	dot : PROCESS (clk_i, rst_i)
	BEGIN
		IF (rst_i <= '0') THEN
			count_dot_s <= 1;
			c_4Hz_en_s <= '0';
		ELSIF (rising_edge(clk_i)) THEN
			
			count_dot_s <= count_dot_s + 1;
			IF (count_dot_s = 3000000) THEN
				c_4Hz_en_s <= NOT c_4Hz_en_s;
				count_dot_s <= 1;
			END IF;
				
		END IF;
	END PROCESS dot;
	
	dot_en : PROCESS (clk_i, rst_i)
	BEGIN
		IF (rst_i <= '0') THEN
			count_dot_en_s <= 1;
			c_4Hz_co_s <= '0';
		ELSIF (rising_edge(clk_i)) THEN
			count_dot_en_s <= count_dot_en_s + 1;
			c_4Hz_co_s <= '0';
			IF (count_dot_en_s = 3000000) THEN
				c_4Hz_co_s <= '1';
				count_dot_en_s <= 1;
			END IF;
				
		END IF;
	END PROCESS dot_en;
	
	dash : PROCESS (clk_i, rst_i)
	BEGIN
		IF (rst_i <= '0') THEN
			count_dash_s <= 1;
			c_2Hz_en_s <= '0';
		ELSIF (rising_edge(clk_i)) THEN
			
			count_dash_s <= count_dash_s + 1;
			IF (count_dash_s = 6000000) THEN
				c_2Hz_en_s <= NOT c_2Hz_en_s;
				count_dash_s <= 1;
			END IF;
				
		END IF;
	END PROCESS dash;
	
	dash_en : PROCESS (clk_i, rst_i)
	BEGIN
		IF (rst_i <= '0') THEN
			count_dash_en_s <= 1;
			c_2Hz_co_s <= '0';
		ELSIF (rising_edge(clk_i)) THEN
			c_2Hz_co_s <= '0';
			count_dash_en_s <= count_dash_en_s + 1;
			IF (count_dash_en_s = 6000000) THEN
				c_2Hz_co_s <= '1';
				count_dash_en_s <= 1;
			END IF;
		END IF;
	END PROCESS dash_en;
	
	brd_en : PROCESS (clk_i, rst_i)
	BEGIN
		IF (rst_i <= '0') THEN
			count_brd_s <= 1;
			brd_s <= '0';
		ELSIF (rising_edge(clk_i)) THEN
			brd_s <= '0';
			count_brd_s <= count_brd_s + 1;
			IF (count_brd_s = 1250) THEN
				brd_s <= '1';
				count_brd_s <= 1;
			END IF;
		END IF;
	END PROCESS brd_en;
	
	q4Hz_o <= c_4Hz_en_s;
	co4Hz_o <= c_4Hz_co_s;
	q2Hz_o <= c_2Hz_en_s;
	co2Hz_o <= c_2Hz_co_s;
	brd_o <= brd_s;

END clock_divider_a;
