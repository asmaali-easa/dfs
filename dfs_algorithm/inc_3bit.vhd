library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity inc_3bit is
port (x: in std_logic_vector (2 downto 0);
      y: out std_logic_vector (2 downto 0));
end entity ;

architecture rtl of inc_3bit is
    signal y_temp: unsigned (2 downto 0);
begin
    y_temp <= unsigned(x) + 1;
    y <= std_logic_vector(y_temp);
end rtl;