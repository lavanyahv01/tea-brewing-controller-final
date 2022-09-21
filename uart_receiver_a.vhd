LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ARCHITECTURE uart_receiver_a OF uart_receiver_e IS

	TYPE state_t IS (idle_st, rx_start_bit_st, rx_data_bits_st,
                     rx_stop_bit_st, cleanup_st);
	SIGNAL state_s : state_t := idle_st;
	
	SIGNAL clk_count_s	:	INTEGER range 0 to clk_per_bdrate-1 := 0;
	SIGNAL bit_index_s	:	INTEGER range 0 to 7 := 0;	-- 8 bits total
	SIGNAL rx_byte_s	:	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL rx_dv_s		: 	STD_LOGIC := '0';

BEGIN

	uart_rx : PROCESS (clk_i, rst_i)
	BEGIN
		IF(rst_i='0') THEN 
            state_s <= idle_st;
        ELSIF(clk_i = '1' AND clk_i'EVENT AND clk_i'LAST_VALUE = '0') THEN
			
			CASE state_s IS
				
				WHEN idle_st =>	rx_dv_s <= '0';
								clk_count_s <= 0;	
								bit_index_s <= 0;
								
								IF (rx_data_i = '0') THEN
									state_s <= rx_start_bit_st;
								ELSE
									state_s <= idle_st;
								END IF;
								
				-- start bit detected
				WHEN rx_start_bit_st => IF (clk_count_s = (clk_per_bdrate-1)/2) THEN
											IF (rx_data_i = '0') THEN
												clk_count_s <= 0;
												state_s <= rx_data_bits_st;
											ELSE 
												state_s <= idle_st;
											END IF;	
										ELSE 
											clk_count_s <= clk_count_s + 1;
											state_s <= rx_start_bit_st;
										END IF;
				
				-- Check middle of start bit to make sure it's still low
				WHEN rx_data_bits_st => IF(clk_count_s < (clk_per_bdrate-1)) THEN
											clk_count_s <= clk_count_s + 1;
											state_s <= rx_data_bits_st;
										ELSE
											clk_count_s <= 0;
											rx_byte_s(bit_index_s) <= rx_data_i;
											
											-- check if we have sent out all bits
											IF bit_index_s < 7 THEN
												bit_index_s <= bit_index_s + 1;
												state_s <= rx_data_bits_st;
											ELSE
												bit_index_s <= 0;
												state_s <= rx_stop_bit_st;
											END IF;
										END IF;
										
				-- Receive Stop bit, stop bit = 1
				-- wait for clk_per_bdrate-1 clock cycles for stop bit to finish
				WHEN rx_stop_bit_st => 	IF (clk_count_s < clk_per_bdrate-1) THEN
											clk_count_s <= clk_count_s + 1;
											state_s <= rx_stop_bit_st;
										ELSE
											rx_dv_s <= '1';
											clk_count_s <= 0;
											state_s <= cleanup_st;
										END IF;
										
				-- stay put for 1 clock cycle
				WHEN cleanup_st => 	state_s <= idle_st;
									rx_dv_s <= '0';
				
				WHEN OTHERS => 		state_s <= idle_st;
										
				
			END CASE;
			
		END IF;
	END PROCESS uart_rx;
	
	rx_data_o <= rx_byte_s;
	rx_dv_o <= rx_dv_s;
	

END uart_receiver_a;