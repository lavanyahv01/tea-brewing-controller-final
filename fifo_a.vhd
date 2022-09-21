LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ARCHITECTURE fifo_a OF fifo_e IS

    TYPE FIFO_DATA_t IS ARRAY (0 TO DEPTH_g-1) of STD_LOGIC_VECTOR(WIDTH_g-1 downto 0);
    SIGNAL FIFO_DATA_s : FIFO_DATA_t;

    SIGNAL WR_INDEX_s   : INTEGER RANGE 0 TO DEPTH_g-1 := 0;
    SIGNAL RD_INDEX_s   : INTEGER RANGE 0 TO DEPTH_g-1 := 0;

    -- # Words in FIFO, has extra range to allow for assert conditions
    SIGNAL FIFO_COUNT_s : INTEGER RANGE -1 TO DEPTH_g+1 := 0;

    SIGNAL FULL_s  : STD_LOGIC;
    signal EMPTY_s : STD_LOGIC;

BEGIN

    controlling : PROCESS (clk_i) IS
    BEGIN
      IF rising_edge(clk_i) THEN
        IF rst_i = '0' THEN
          FIFO_COUNT_s <= 0;
          WR_INDEX_s   <= 0;
          RD_INDEX_s   <= 0;
		  FIFO_DATA_s <= (others => (others => '0'));
        ELSE
   
          -- Keeps track of the total number of words in the FIFO
          IF (wr_en_i = '1' AND rd_en_i = '0') THEN
            FIFO_COUNT_s <= FIFO_COUNT_s + 1;
          ELSIF (wr_en_i = '0' AND rd_en_i = '1') THEN
            FIFO_COUNT_s <= FIFO_COUNT_s - 1;
          END IF;
   
          -- Keeps track of the write index (and controls roll-over)
          IF (wr_en_i = '1' AND FULL_s = '0') THEN
            IF WR_INDEX_s = DEPTH_g-1 THEN
              WR_INDEX_s <= 0;
            ELSE
              WR_INDEX_s <= WR_INDEX_s + 1;
            END IF;
          END IF;
   
          -- Keeps track of the read index (and controls roll-over)        
          IF (rd_en_i = '1' and EMPTY_s = '0') THEN
            IF RD_INDEX_s = DEPTH_g-1 THEN
              RD_INDEX_s <= 0;
            ELSE
              RD_INDEX_S <= RD_INDEX_s + 1;
            END IF;
          END IF;
   
          -- Registers the input data when there is a write
          IF wr_en_i = '1' then
            FIFO_DATA_s(WR_INDEX_s) <= wr_data_i;
          END IF;
           
        END IF;                           -- sync reset
      END IF;                             -- rising_edge(clk_i)
    END PROCESS controlling;
     
    rd_data_o <= FIFO_DATA_s(RD_INDEX_s);
   
    FULL_s  <= '1' when FIFO_COUNT_s = DEPTH_g else '0';
    EMPTY_s <= '1' when FIFO_COUNT_s = 0       else '0';
   
    full_o  <= FULL_s;
    empty_o <= EMPTY_s;


END fifo_a;