library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ram_8x1bit is
    port (clk, wr: in std_logic;
          addr: in std_logic_vector(2 downto 0);
          din: in std_logic;
          dout: out std_logic);
end entity;

architecture rtl of ram_8x1bit is
    signal ram: std_logic_vector (7 downto 0);
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (wr = '1') then
                ram(conv_integer(unsigned(addr))) <= din;
            end if;
        end if;
    end process;
    dout <= ram(conv_integer(unsigned(addr)));
end rtl;