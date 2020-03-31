library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity isEqual_4bit is
port (x, y: in std_logic_vector (3 downto 0);
      isEqual: out std_logic);
end entity ;

architecture rtl of isEqual_4bit is
begin
    process(x, y)
    begin
        if (x = y) then
            isEqual <= '1';
        else
            isEqual <= '0';
        end if;
    end process;
end rtl;