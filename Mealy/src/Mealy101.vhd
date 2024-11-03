library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mealy is
Port ( clk : in STD_LOGIC;
din : in STD_LOGIC;
rst : in STD_LOGIC;
dout : out STD_LOGIC);
end mealy;

architecture Behavioral of mealy is
type state is (st0, st1, st2, st3);
signal present_state, next_state : state;
begin

syncronous_process : process (clk)
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                present_state <= st0;
            else
                present_state <= next_state;
            end if;
        end if;
end process;

next_state_and_output_decoder : process(present_state, din)
    begin
        dout <= '0';
            case (present_state) is
                when st0 => 
                    if (din = '0') then 
                        next_state <= st0;
                        dout <= '0';
                    else
                        next_state <= st1; 
                        dout <= '0';
                    end if; 
                when st1 =>
                    if (din = '1') then 
                        next_state <= st1;
                        dout <= '0';
                    else
                        next_state <= st2;
                        dout <= '0';
                    end if;
                when st2 => 
                    if (din = '0')
                        next_state <= st0;
                        dout <= '0';
                    else
                        next_state <= st1;
                        dout <= '1';
                when others
                        next_state <= st0;
                        dout <= '0';
            end case;
end process;

end Behavioral;
