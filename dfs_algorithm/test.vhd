library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity test is
    port (clk, rst, go: in std_logic;
          start: in std_logic_vector (2 downto 0);
          print: out std_logic_vector (2 downto 0));
end entity;

architecture rtl of test is
    component toplevel is
        port (clk, rst, go: in std_logic;
              n, v, start: in std_logic_vector (2 downto 0);
              node_out, next_node: in std_logic_vector (3 downto 0);
              print, vertex: out std_logic_vector (2 downto 0);
              node_in: out std_logic_vector (3 downto 0));
    end component;

    component  adj is
        port (vertex_in: in std_logic_vector (2 downto 0);
              node_in: in std_logic_vector (3 downto 0);
              n, vertex_out: out std_logic_vector (2 downto 0);
              node_out, next_node: out std_logic_vector (3 downto 0));
    end component;

    signal n, v, vertex: std_logic_vector (2 downto 0);
    signal node_out, next_node, node_in: std_logic_vector (3 downto 0);
begin
    u0: toplevel port map (clk, rst, go, n, v, start, node_out, next_node, print, vertex, node_in);
    u1: adj port map (vertex, node_in, n, v, node_out, next_node);
end rtl;