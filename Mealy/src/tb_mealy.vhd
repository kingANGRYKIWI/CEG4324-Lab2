LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_moore IS
END tb_moore;

ARCHITECTURE behavior OF tb_moore IS

-- Component Declaration for the Unit Under Test (UUT)

COMPONENT mealy
PORT(
clk : IN std_logic;
din : IN std_logic;
rst : IN std_logic;
dout : OUT std_logic
);
END COMPONENT;

--Inputs
signal clk : std_logic := '0';
signal din : std_logic := '0';
signal rst : std_logic := '0';

--Outputs
signal dout : std_logic;

-- Clock period definitions
constant clk_period : time := 20 ns;

BEGIN

-- Instantiate the Unit Under Test (UUT)
uut: mealy PORT MAP (
clk => clk,
din => din,
rst => rst,
dout => dout
);

-- Clock process definitions
clk_process :process
begin
clk <= '0';
wait for clk_period/2;
clk <= '1';
wait for clk_period/2;
end process;

-- Stimulus process
stim_proc: process
begin

rst <= '1';

wait for 100 ns;

rst <= '0';

din <= '0';

wait for 20 ns;

din <= '1';

wait for 20 ns;

din <= '0';

wait for 20 ns;

din <= '1';

wait for 20 ns;

din <= '0';

wait for 20 ns;

din <= '0';

wait for 20 ns;

din <= '0';

wait for 20 ns;

din <= '1';

wait for 20 ns;

din <= '0';

wait for 20 ns;

din <= '1';

wait for 20 ns;

din <= '0';

wait for 20 ns;

din <= '0';

wait for 20 ns;

din <= '1';

wait for 20 ns;

din <= '0';

wait for 20 ns;

end process;

END;
