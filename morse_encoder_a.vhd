LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ARCHITECTURE morse_encoder_a OF morse_encoder_e IS

    TYPE state_t IS (idle_st, read_data_st, wait_data_st, data_bit7_st, dot_bit7_st, dash_bit7_st, wait_bit7_st,
					data_bit6_st, dot_bit6_st, dash_bit6_st, wait_bit6_st,
					data_bit5_st, dot_bit5_st, dash_bit5_st, wait_bit5_st,
					data_bit4_st, dot_bit4_st, dash_bit4_st, wait_bit4_st,
					data_bit3_st, dot_bit3_st, dash_bit3_st, wait_bit3_st,
					data_bit2_st, dot_bit2_st, dash_bit2_st, wait_bit2_st,
					data_bit1_st, dot_bit1_st, dash_bit1_st, wait_bit1_st,
					data_bit0_st, dot_bit0_st, dash_bit0_st, wait_bit0_st);
					
    SIGNAL state_s : state_t := idle_st;
    SIGNAL reg_s : STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN

	StateProcess : PROCESS (clk_i, rst_i)
	BEGIN
		IF (rst_i = '0') THEN
			state_s <= idle_st;
            reg_s <= (OTHERS => '0');
		
		ELSIF (rising_edge(clk_i)) THEN
		
			CASE state_s IS 
				
				WHEN idle_st => IF(rx_dv_i = '1' OR empty_i = '0') THEN 
									state_s <= read_data_st; 
								ELSE 
									state_s <= idle_st; 
									reg_s <= (OTHERS => '0'); 
								END IF; 
								reg_s <= (OTHERS => '0');
								
				WHEN read_data_st => IF (empty_i = '0') THEN 
										state_s <= wait_data_st; 
									ELSE 
										state_s <= read_data_st; 
									END IF; 
									reg_s <= rx_data_i;
									
				WHEN wait_data_st => state_s <= data_bit7_st;
									
				-------------------  data bit 7--------------------------------------
				WHEN data_bit7_st =>  	IF (reg_s(7) = '1' AND dot_en_i = '1') THEN
											state_s <= dot_bit7_st;
										ELSIF(reg_s(7) = '0' AND dash_en_i = '1') THEN
											state_s <= dash_bit7_st;
										ELSE
											state_s <= data_bit7_st;
										END IF;
										
				WHEN dot_bit7_st =>	IF (dot_en_i = '1') THEN
										state_s <= wait_bit7_st;
									ELSE
										state_s <= dot_bit7_st;
									END IF;
									
				WHEN dash_bit7_st => IF(dash_en_i = '1') THEN
                                    state_s <= wait_bit7_st;
                                ELSE
                                    state_s <= dash_bit7_st;
                                END IF;
								
				WHEN wait_bit7_st => IF (dot_en_i = '1') THEN 
										state_s <= data_bit6_st;
									ELSE 
										state_s <= wait_bit7_st;
									END IF;
				-------------------  data bit 6--------------------------------------
				WHEN data_bit6_st =>  	IF (reg_s(6) = '1' AND dot_en_i = '1') THEN
											state_s <= dot_bit6_st;
										ELSIF(reg_s(6) = '0' AND dash_en_i = '1') THEN
											state_s <= dash_bit6_st;
										ELSE
											state_s <= data_bit6_st;
										END IF;
										
				WHEN dot_bit6_st =>	IF (dot_en_i = '1') THEN
										state_s <= wait_bit6_st;
									ELSE
										state_s <= dot_bit6_st;
									END IF;
									
				WHEN dash_bit6_st => IF(dash_en_i = '1') THEN
                                    state_s <= wait_bit6_st;
                                ELSE
                                    state_s <= dash_bit6_st;
                                END IF;
						
				WHEN wait_bit6_st => IF (dot_en_i = '1') THEN 
										state_s <= data_bit5_st;
									ELSE 
										state_s <= wait_bit6_st;
									END IF;
								
				-------------------  data bit 5--------------------------------------
				WHEN data_bit5_st =>  	IF (reg_s(5) = '1' AND dot_en_i = '1') THEN
											state_s <= dot_bit5_st;
										ELSIF(reg_s(5) = '0' AND dash_en_i = '1') THEN
											state_s <= dash_bit5_st;
										ELSE
											state_s <= data_bit5_st;
										END IF;
										
				WHEN dot_bit5_st =>	IF (dot_en_i = '1') THEN
										state_s <= wait_bit5_st;
									ELSE
										state_s <= dot_bit5_st;
									END IF;
									
				WHEN dash_bit5_st => IF(dash_en_i = '1') THEN
                                    state_s <= wait_bit5_st;
                                ELSE
                                    state_s <= dash_bit5_st;
                                END IF;
				
				WHEN wait_bit5_st => IF (dot_en_i = '1') THEN 
										state_s <= data_bit4_st;
									ELSE 
										state_s <= wait_bit5_st;
									END IF;
								
				-------------------  data bit 4--------------------------------------
				WHEN data_bit4_st =>  	IF (reg_s(4) = '1' AND dot_en_i = '1') THEN
											state_s <= dot_bit4_st;
										ELSIF(reg_s(4) = '0' AND dash_en_i = '1') THEN
											state_s <= dash_bit4_st;
										ELSE
											state_s <= data_bit4_st;
										END IF;
										
				WHEN dot_bit4_st =>	IF (dot_en_i = '1') THEN
										state_s <= wait_bit4_st;
									ELSE
										state_s <= dot_bit4_st;
									END IF;
									
				WHEN dash_bit4_st => IF(dash_en_i = '1') THEN
                                    state_s <= wait_bit4_st;
                                ELSE
                                    state_s <= dash_bit4_st;
                                END IF;
								
				WHEN wait_bit4_st => IF (dot_en_i = '1') THEN 
										state_s <= data_bit3_st;
									ELSE 
										state_s <= wait_bit4_st;
									END IF;
								
				-------------------  data bit 3--------------------------------------
				WHEN data_bit3_st =>  	IF (reg_s(3) = '1' AND dot_en_i = '1') THEN
											state_s <= dot_bit3_st;
										ELSIF(reg_s(3) = '0' AND dash_en_i = '1') THEN
											state_s <= dash_bit3_st;
										ELSE
											state_s <= data_bit3_st;
										END IF;
										
				WHEN dot_bit3_st =>	IF (dot_en_i = '1') THEN
										state_s <= wait_bit3_st;
									ELSE
										state_s <= dot_bit3_st;
									END IF;
									
				WHEN dash_bit3_st => IF(dash_en_i = '1') THEN
                                    state_s <= wait_bit3_st;
                                ELSE
                                    state_s <= dash_bit3_st;
                                END IF;
								
				WHEN wait_bit3_st => IF (dot_en_i = '1') THEN 
										state_s <= data_bit2_st;
									ELSE 
										state_s <= wait_bit3_st;
									END IF;
								
				-------------------  data bit 2--------------------------------------
				WHEN data_bit2_st =>  	IF (reg_s(2) = '1' AND dot_en_i = '1') THEN
											state_s <= dot_bit2_st;
										ELSIF(reg_s(2) = '0' AND dash_en_i = '1') THEN
											state_s <= dash_bit2_st;
										ELSE
											state_s <= data_bit2_st;
										END IF;
										
				WHEN dot_bit2_st =>	IF (dot_en_i = '1') THEN
										state_s <= wait_bit2_st;
									ELSE
										state_s <= dot_bit2_st;
									END IF;
									
				WHEN dash_bit2_st => IF(dash_en_i = '1') THEN
                                    state_s <= wait_bit2_st;
                                ELSE
                                    state_s <= dash_bit2_st;
                                END IF;
								
				WHEN wait_bit2_st => IF (dot_en_i = '1') THEN 
										state_s <= data_bit1_st;
									ELSE 
										state_s <= wait_bit2_st;
									END IF;
								
				-------------------  data bit 1--------------------------------------
				WHEN data_bit1_st =>  	IF (reg_s(1) = '1' AND dot_en_i = '1') THEN
											state_s <= dot_bit1_st;
										ELSIF(reg_s(1) = '0' AND dash_en_i = '1') THEN
											state_s <= dash_bit1_st;
										ELSE
											state_s <= data_bit1_st;
										END IF;
										
				WHEN dot_bit1_st =>	IF (dot_en_i = '1') THEN
										state_s <= wait_bit1_st;
									ELSE
										state_s <= dot_bit1_st;
									END IF;
									
				WHEN dash_bit1_st => IF(dash_en_i = '1') THEN
                                    state_s <= wait_bit1_st;
                                ELSE
                                    state_s <= dash_bit1_st;
                                END IF;
								
				WHEN wait_bit1_st => IF (dot_en_i = '1') THEN 
										state_s <= data_bit0_st;
									ELSE 
										state_s <= wait_bit1_st;
									END IF;
								
				-------------------  data bit 0--------------------------------------
				WHEN data_bit0_st =>  	IF (reg_s(0) = '1' AND dot_en_i = '1') THEN
											state_s <= dot_bit0_st;
										ELSIF(reg_s(0) = '0' AND dash_en_i = '1') THEN
											state_s <= dash_bit0_st;
										ELSE
											state_s <= data_bit0_st;
										END IF;
										
				WHEN dot_bit0_st =>	IF (dot_en_i = '1') THEN
										state_s <= wait_bit0_st;
									ELSE
										state_s <= dot_bit0_st;
									END IF;
									
				WHEN dash_bit0_st => IF(dash_en_i = '1') THEN
                                    state_s <= wait_bit0_st;
                                ELSE
                                    state_s <= dash_bit0_st;
                                END IF;
								
				WHEN wait_bit0_st => IF (dot_en_i = '1') THEN 
										state_s <= idle_st;
									ELSE 
										state_s <= wait_bit0_st;
									END IF;
									
				WHEN OTHERS => state_s <= idle_st;
			END CASE;
		
		END IF;
	
	END PROCESS StateProcess;
	
	transition : PROCESS (state_s)
    BEGIN
        CASE state_s IS
            WHEN idle_st => morse_led_o <= '0'; rd_o <= '0'; 
            WHEN read_data_st => morse_led_o <= '0'; rd_o <= '1';
			WHEN wait_data_st => morse_led_o <= '0'; rd_o <= '0'; 
			-------------------  data bit 7--------------------------------------
			WHEN data_bit7_st => morse_led_o <= '0'; rd_o <= '0'; 
			WHEN dot_bit7_st => morse_led_o <= '1'; rd_o <= '0'; 
			WHEN dash_bit7_st => morse_led_o <= '1'; rd_o <= '0';
			WHEN wait_bit7_st => morse_led_o <= '0'; rd_o <= '0'; 
			-------------------  data bit 6--------------------------------------
			WHEN data_bit6_st => morse_led_o <= '0'; rd_o <= '0'; 
			WHEN dot_bit6_st => morse_led_o <= '1'; rd_o <= '0'; 
			WHEN dash_bit6_st => morse_led_o <= '1'; rd_o <= '0';
			WHEN wait_bit6_st => morse_led_o <= '0'; rd_o <= '0'; 
			-------------------  data bit 5--------------------------------------
			WHEN data_bit5_st => morse_led_o <= '0'; rd_o <= '0'; 
			WHEN dot_bit5_st => morse_led_o <= '1'; rd_o <= '0'; 
			WHEN dash_bit5_st => morse_led_o <= '1'; rd_o <= '0';
			WHEN wait_bit5_st => morse_led_o <= '0'; rd_o <= '0'; 
			-------------------  data bit 4--------------------------------------
			WHEN data_bit4_st => morse_led_o <= '0'; rd_o <= '0'; 
			WHEN dot_bit4_st => morse_led_o <= '1'; rd_o <= '0'; 
			WHEN dash_bit4_st => morse_led_o <= '1'; rd_o <= '0';
			WHEN wait_bit4_st => morse_led_o <= '0'; rd_o <= '0'; 
			-------------------  data bit 3--------------------------------------
			WHEN data_bit3_st => morse_led_o <= '0'; rd_o <= '0'; 
			WHEN dot_bit3_st => morse_led_o <= '1'; rd_o <= '0'; 
			WHEN dash_bit3_st => morse_led_o <= '1'; rd_o <= '0';
			WHEN wait_bit3_st => morse_led_o <= '0'; rd_o <= '0'; 
			-------------------  data bit 2--------------------------------------
			WHEN data_bit2_st => morse_led_o <= '0'; rd_o <= '0'; 
			WHEN dot_bit2_st => morse_led_o <= '1'; rd_o <= '0'; 
			WHEN dash_bit2_st => morse_led_o <= '1'; rd_o <= '0';
			WHEN wait_bit2_st => morse_led_o <= '0'; rd_o <= '0'; 
			-------------------  data bit 1--------------------------------------
			WHEN data_bit1_st => morse_led_o <= '0'; rd_o <= '0'; 
			WHEN dot_bit1_st => morse_led_o <= '1'; rd_o <= '0'; 
			WHEN dash_bit1_st => morse_led_o <= '1'; rd_o <= '0';
			WHEN wait_bit1_st => morse_led_o <= '0'; rd_o <= '0'; 
			-------------------  data bit 0--------------------------------------
			WHEN data_bit0_st => morse_led_o <= '0'; rd_o <= '0'; 
			WHEN dot_bit0_st => morse_led_o <= '1'; rd_o <= '0'; 
			WHEN dash_bit0_st => morse_led_o <= '1'; rd_o <= '0';
			WHEN wait_bit0_st => morse_led_o <= '0'; rd_o <= '0'; 
        END CASE;
    END PROCESS transition;

END morse_encoder_a;