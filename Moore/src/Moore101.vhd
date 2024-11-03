library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity moore is
Port (  clk : in STD_LOGIC;
        din : in STD_LOGIC;
        rst : in STD_LOGIC;
        dout : out STD_LOGIC);
end moore;

architecture Behavioral of moore is
type state is (st0, st1, st2, st3);
signal present_state, next_state : state;
begin

synchronous_process: process (clk)
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                present_state <= st0;
            else
                present_state <= next_state;
            end if;
        end if;
end process;

output_decoder : process(present_state, din)
begin
    case (present_state) is
        when st0 =>
            if (din = '1') then
                next_state <= st1;
            else
                next_state <= st0;
            end if;
        when st1 =>
            if (din = '1') then
                next_state <= st1;
            else
                next_state <= st2;
            end if;
        when st2 =>
            if (din = '1') then
                next_state <= st3;
            else
                next_state <= st0;
            end if;
        when st3 =>
            if (din = '1') then
                next_state <= st1;
            else
                next_state <= st2;
            end if;
        when others =>
                next_state <= st0;
    end case;
end process;
    dout <= '1' WHEN (present_state = st3) ELSE '0';
end Behavioral;
