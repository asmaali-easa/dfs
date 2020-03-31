library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tb is
end tb ;

architecture behav of tb is
    constant clockperiod: time:= 0.1 ns;
    signal clk: std_logic:='1';
    signal rst, go: std_logic;
    signal start, print: std_logic_vector (2 downto 0);

    component test is
        port (clk, rst, go: in std_logic;
              start: in std_logic_vector (2 downto 0);
              print: out std_logic_vector (2 downto 0));
    end component;
begin
    clk <= not clk after clockperiod /2;
    rst <= '1' , '0' after 0.05 ns;
    start <= "001";
    go <= '0' , '1' after 0.05 ns, '0' after 0.25 ns;
    u0: test port map(clk, rst, go, start, print);
end behav;