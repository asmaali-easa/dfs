library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity stack_15x4bit is
    port (clk: in std_logic;
          i: in std_logic_vector (1 downto 0); -- instructions: 00:nothing, 01:push, 10:pop, 11:clear
          val: in std_logic_vector (3 downto 0);
          top: out std_logic_vector (3 downto 0);
          empty: out std_logic);
end entity;

architecture rtl of stack_15x4bit is
    type stack is array (0 to 15) of std_logic_vector(3 downto 0);
    signal program: stack;
    signal t: unsigned (3 downto 0);
    signal i_temp: std_logic_vector (1 downto 0);
    signal val_temp: std_logic_vector (3 downto 0);
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (i_temp = "11") then
                t <= "1111";
            elsif ((i_temp = "01") and (t /= 14))then
                t <= t + 1;
                program(conv_integer(t + 1)) <= val_temp;
            elsif ((i_temp = "10") and (t /= 15)) then
                t <= t - 1;
            end if;
        end if;
    end process;

    top <= program(conv_integer(t));
    empty <= '1' when (t = 15) else '0';
    i_temp <= i;
    val_temp <= val;
end rtl;