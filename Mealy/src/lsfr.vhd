------------------------------------------------------------------
-- Name		   : lfsr1.vhd
-- Description : Part of the LFSR tutorial
-- Designed by : Claudio Avi Chami - FPGA Site
--               https://fpgasite.wordpress.com
-- Date        : 09/Aug/2016
-- Version     : 01
------------------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;

entity lfsr is
  port (
    reset  : in  std_logic;
    clk    : in  std_logic; 
    count  : out std_logic_vector (14 downto 0) -- lfsr output
  );
end entity;

architecture rtl of lfsr is
    signal count_i    	: std_logic_vector (14 downto 0):="101100100110101";
    signal feedback 	: std_logic;

begin
    feedback <= not(count_i(14) xor count_i(13) xor count_i(10));		-- LFSR size 4

    process (reset, clk) 
	begin
        if (reset = '1') then
            count_i <= "101100100110101";
        elsif (rising_edge(clk)) then
			count_i <= count_i(13 downto 0) & feedback;
        end if;
    end process;
    count <= count_i;
end architecture;
