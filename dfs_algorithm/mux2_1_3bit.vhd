library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity mux2_1_3bit is
port (a, b: in std_logic_vector (2 downto 0);
      s: in std_logic;
	  y: out std_logic_vector (2 downto 0));
end entity ;

architecture rtl of mux2_1_3bit is
begin
    y <= b when s = '1' else a;
end rtl;