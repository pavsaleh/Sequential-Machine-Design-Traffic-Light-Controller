LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.numeric_std.all;

ENTITY tb IS
END ENTITY tb;

ARCHITECTURE timer_tb of tb is 
SIGNAL pLoadValue: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL load, enable: STD_LOGIC;
SIGNAL clk, rst: STD_LOGIC := '0';
SIGNAL value: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL done: STD_LOGIC;
BEGIN
	dut: entity work.nbit_timer generic map(4) port map(pLoadValue, load, enable, clk, rst, value, done);

	clock: clk <= '1' after 50 ns when clk = '0' else
			      '0' after 50ns when clk = '1';

    stimulus: process is 
    BEGIN
    	wait for 50ns;
    	rst <= '1';

		wait for 100ns;

    	pLoadValue <= "1111"; load <= '1'; enable <= '1';
    	wait for 100ns; 
    	load <= '0';

--    	enable <= '1';
    	wait for 2000ns;

    END process stimulus;
end architecture timer_tb;


ARCHITECTURE bcd_decoder_tb of tb is
SIGNAL hex: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL bcd1, bcd0: STD_LOGIC_VECTOR(3 downto 0);
BEGIN
	dut: Entity work.bcd_decoder PORT MAP(hex, bcd1, bcd0);

	stimulus: process is
	Begin
		for i in 0 to 15 loop
			hex <= std_logic_vector(to_unsigned(i, 4)); 
			wait for 100ns;
		END loop;
	END process stimulus;
END ARCHITECTURE bcd_decoder_tb;


ARCHITECTURE traffic_light_behav_tb of tb is
SIGNAL GClock, GReset: STD_LOGIC := '0';
SIGNAL MSC, SSC : STD_LOGIC_VECTOR(3 downto 0);
SIGNAL SSCS: STD_LOGIC := '0';
SIGNAL MSTL, SSTL: STD_LOGIC_VECTOR (2 downto 0);
SIGNAL BCD1, BCD2: STD_LOGIC_VECTOR (3 downto 0);
BEGIN 
	dut: ENTITY work.traffic_light_controller PORT MAP (GClock, GReset, MSC, SSC, SSCS, MSTL, SSTL, BCD1, BCD2);


	clock: GClock <= '1' after 50 ns when GClock = '0' else
			         '0' after 50ns when GClock = '1';

	stimulus: process is
	Begin
		wait for 50ns;
		MSC <= "1000"; SSC <= "0011"; 
		GReset <= '1';

		wait for 1200ns; 
		SSCS <= '1';


		wait for 800ns;
	end process stimulus;
end architecture ;


