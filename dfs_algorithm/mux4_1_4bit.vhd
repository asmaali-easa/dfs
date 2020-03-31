library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity mux4_1_4bit is
port (sel: in std_logic_vector (1 downto 0);
      a, b, c, d: in std_logic_vector (3 downto 0);
	  y: out std_logic_vector (3 downto 0));
end entity ;

architecture rtl of mux4_1_4bit is
    begin
        with sel select
            y <= a when "00",
                 b when "01",
                 c when "10",
                 d when others;
end rtl;