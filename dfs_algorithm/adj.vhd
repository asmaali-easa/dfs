library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity adj is
    port (vertex_in: in std_logic_vector (2 downto 0);
          node_in: in std_logic_vector (3 downto 0);
          n, vertex_out: out std_logic_vector (2 downto 0);
          node_out, next_node: out std_logic_vector (3 downto 0));
end entity;

architecture rtl of adj is
    type rom0 is array (0 to 7) of std_logic_vector (3 downto 0);
    constant nodes: rom0:= (
        "1111",
        "0000",
        "0001",
        "0010",
        "0011",
        "0100",
        "1111",
        "1111"
    );
    type rom1 is array (0 to 15) of std_logic_vector (2 downto 0);
    constant vertices: rom1:= (
        "010",
        "001",
        "001",
        "010",
        "100",
        "011",
        "100",
        "100",
        "011",
        "101",
        "000",
        "000",
        "000",
        "000",
        "000",
        "000"
    );
    type rom2 is array (0 to 15) of std_logic_vector (3 downto 0);
    constant next_nodes: rom2:= (
        "0101",
        "0110",
        "0111",
        "1000",
        "1111",
        "1111",
        "1111",
        "1111",
        "1001",
        "1111",
        "1111",
        "1111",
        "1111",
        "1111",
        "1111",
        "1111"
    );
begin
    n <= "101";
    node_out <= nodes(conv_integer(unsigned(vertex_in)));
    vertex_out <= vertices(conv_integer(unsigned(node_in)));
    next_node <= next_nodes(conv_integer(unsigned(node_in)));
end rtl;