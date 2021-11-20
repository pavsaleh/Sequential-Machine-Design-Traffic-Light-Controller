LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY traffic_light_controller_wrap IS
  PORT (--GClock, GReset: IN STD_LOGIC;
        --MSC, SSC : IN STD_LOGIC_VECTOR(3 downto 0);
        --SSCS: IN STD_LOGIC;
        --MSTL, SSTL: OUT STD_LOGIC_VECTOR (2 downto 0);
        --BCD1, BCD2: OUT STD_LOGIC_VECTOR (3 downto 0)
        CLOCK_50: IN STD_LOGIC;
        SW: IN STD_LOGIC_VECTOR (15 downto 0);
        HEX1, HEX0: OUT STD_LOGIC_VECTOR (6 downto 0);
        LEDR, LEDG: OUT STD_LOGIC_VECTOR(2 downto 0)
        );
END traffic_light_controller_wrap;

  ARCHITECTURE struct of traffic_light_controller_wrap IS
  SIGNAL bcd_led1, bcd_led0: STD_LOGIC_VECTOR(3 downto 0);
  SIGNAL LClock: STD_LOGIC;
  BEGIN
  traffic_light_controller: work.traffic_light_controller PORT MAP (
        GReset => SW(15), 
        GClock => lClock,

        MSC => SW(7 downto 4), SSC => SW(3 downto 0),
        SSCS => SW(8),-- Push Button (0)
        MSTL => LEDR(2 downto 0), SSTL => LEDG(2 downto 0),
        BCD1 => bcd_led0, BCD2 => bcd_led1
      );

  clk_div: entity work.clk_div port map (
      clock_25Mhz => CLOCK_50,
      clock_1Hz => lClock
    );

  led1: work.dec_7seg port map(i_hexDigit => bcd_led1,
                               o_segment_a=> HEX1(0),
                               o_segment_b=> HEX1(1),
                               o_segment_c=> HEX1(2),
                               o_segment_d=> HEX1(3),
                               o_segment_e=> HEX1(4),
                               o_segment_f=> HEX1(5),
                               o_segment_g=> HEX1(6));

  led0: work.dec_7seg port map(i_hexDigit => bcd_led0,
                               o_segment_a=> HEX0(0),
                               o_segment_b=> HEX0(1),
                               o_segment_c=> HEX0(2),
                               o_segment_d=> HEX0(3),
                               o_segment_e=> HEX0(4),
                               o_segment_f=> HEX0(5),
                               o_segment_g=> HEX0(6));

  end ARCHITECTURE struct;