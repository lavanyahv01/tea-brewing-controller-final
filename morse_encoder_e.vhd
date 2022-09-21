LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY morse_encoder_e IS
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
END morse_encoder_e;