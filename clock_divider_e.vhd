LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY clock_divider_e IS
    PORT(
        clk_i       :   IN STD_LOGIC;
        rst_i     :   IN STD_LOGIC;
        q4Hz_o      :   OUT STD_LOGIC;
        co4Hz_o     :   OUT STD_LOGIC;
        q2Hz_o      :   OUT STD_LOGIC;
        co2Hz_o     :   OUT STD_LOGIC;
        brd_o       :   OUT STD_LOGIC
    );
END clock_divider_e;