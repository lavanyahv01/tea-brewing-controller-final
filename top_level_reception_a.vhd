LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ARCHITECTURE top_level_reception_a OF top_level_reception_e IS

    COMPONENT clock_divider_e IS
        PORT(
            clk_i       :   IN STD_LOGIC;
            rst_i     :   IN STD_LOGIC;
            q4Hz_o      :   OUT STD_LOGIC;
            co4Hz_o     :   OUT STD_LOGIC;
            q2Hz_o      :   OUT STD_LOGIC;
            co2Hz_o     :   OUT STD_LOGIC;
            brd_o       :   OUT STD_LOGIC
        );
    END COMPONENT clock_divider_e;

    COMPONENT fifo_e IS
        GENERIC (
            WIDTH_g : natural := 8;
            DEPTH_g : integer := 128
            );
        PORT (
            rst_i : IN std_logic;
            clk_i : IN std_logic;
        
            -- FIFO Write Interface
            wr_en_i   : IN  std_logic;
            wr_data_i : IN  std_logic_vector(WIDTH_g-1 DOWNTO 0);
            full_o    : OUT std_logic;
        
            -- FIFO Read Interface
            rd_en_i   : IN  std_logic;
            rd_data_o : OUT std_logic_vector(WIDTH_g-1 DOWNTO 0);
            empty_o   : OUT std_logic
            );
    END COMPONENT fifo_e;

    
    COMPONENT morse_encoder_e IS
        PORT (
            clk_i       : IN STD_LOGIC;
            rst_i     : IN STD_LOGIC;
            rx_data_i   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            rx_dv_i     : IN STD_LOGIC;
            dot_i       : IN STD_LOGIC;
            dot_en_i    : IN STD_LOGIC;
            dash_i       : IN STD_LOGIC;
            dash_en_i    : IN STD_LOGIC;
            empty_i     : IN STD_LOGIC;
            morse_led_o : OUT STD_LOGIC;
            rd_o : OUT STD_LOGIC
        );
    END COMPONENT morse_encoder_e;

    COMPONENT uart_receiver_e is
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
    END COMPONENT uart_receiver_e;

    SIGNAL rx_data_s, rd_data_s  : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL rx_dv_s, q4Hz_s, co4Hz_s, q2Hz_s, co2Hz_s, brd_s :   STD_LOGIC;
    SIGNAL full_s, empty_s, morse_led_s, rd_s : STD_LOGIC;

BEGIN

    uart_receiver_ut :  uart_receiver_e GENERIC MAP (clk_per_bdrate => 1250)
                        PORT MAP (clk_i, rst_i, rx_data_i, rx_data_s, rx_dv_s);
    
    clock_divider_ut: clock_divider_e PORT MAP (clk_i, rst_i, q4Hz_s, co4Hz_s, q2Hz_s, co2Hz_s, brd_s);

    fifo_ut : fifo_e GENERIC MAP (WIDTH_g => 8, DEPTH_g => 512)
                     PORT MAP (rst_i, clk_i, rx_dv_s, rx_data_s, full_s, rd_s, rd_data_s, empty_s);

    morse_encoder_ut : morse_encoder_e PORT MAP (clk_i, rst_i, rd_data_s, rx_dv_s, q4Hz_s, co4Hz_s, q2Hz_s, co2Hz_s, empty_s, morse_led_s, rd_s);

    morse_led_o <= morse_led_s;
	ram_full_o <= full_s;
	heart_beat_o <= q2Hz_s;

END top_level_reception_a;