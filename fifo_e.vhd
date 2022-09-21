LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
ENTITY fifo_e IS
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
END fifo_e;