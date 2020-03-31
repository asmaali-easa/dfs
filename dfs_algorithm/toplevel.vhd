library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity toplevel is
    port (clk, rst, go: in std_logic;
          n, v, start: in std_logic_vector (2 downto 0);
          node_out, next_node: in std_logic_vector (3 downto 0);
          print, vertex: out std_logic_vector (2 downto 0);
          node_in: out std_logic_vector (3 downto 0));
end entity;

architecture rtl of toplevel is
    component dfs is
        port (clk, rst, ctrl1_en: in std_logic;
              n: in std_logic_vector (2 downto 0);
              ctrl2_en, wr: out std_logic;
              addr: out std_logic_vector (2 downto 0));
    end component;

    component dfs_recurs is
        port (clk, rst, ctrl2_en, visit: in std_logic;
              v, start: in std_logic_vector (2 downto 0);
              node_out, next_node: in std_logic_vector (3 downto 0);
              fnsh, wr: out std_logic;
              addr, print, vertex: out std_logic_vector (2 downto 0);
              node_in: out std_logic_vector (3 downto 0));
    end component;

    component ram_8x1bit is
        port (clk, wr: in std_logic;
              addr: in std_logic_vector(2 downto 0);
              din: in std_logic;
              dout: out std_logic);
    end component;

    component  mux2_1_3bit is
        port (a, b: in std_logic_vector (2 downto 0);
              s: in std_logic;
              y: out std_logic_vector (2 downto 0));
    end component;

    type state_type is (st0, st1, st2, st3);
    signal current_state, next_state: state_type;
    signal ctrl1_en, ctrl2_en, fnsh, wr, wr1, wr2, SEL, visit, rst1, rst2: std_logic;
    signal addr, addr1, addr2: std_logic_vector (2 downto 0);
    begin
        process(current_state, go, ctrl2_en, fnsh)
        begin
            case current_state is
                when st0 =>
                    rst1 <= '0';
                    rst2 <= '0';
                    SEL <= '0';
                    next_state <= st1;
                    ctrl1_en <= '0';
                when st1 =>
                    rst1 <= '1';
                    rst2 <= '1';
                    SEL <= '0';
                    ctrl1_en <= '0';
                    if (go = '1') then
                        next_state <= st2;
                    else
                        next_state <= st1;
                    end if;
                when st2 =>
                    rst1 <= '0';
                    rst2 <= '0';
                    SEL <= '0';
                    ctrl1_en <= '1';
                    if (ctrl2_en = '1') then
                        next_state <= st3;
                    else
                        next_state <= st2;
                    end if;
                when others =>
                    rst1 <= '0';
                    rst2 <= '0';
                    SEL <= '1';
                    ctrl1_en <= '0';
                    if (fnsh = '1') then
                        next_state <= st1;
                    else
                        next_state <= st3;
                    end if;
            end case;
        end process;
    
        process (clk, rst)
        begin
            if (rst ='1') then
                current_state <= st0;
            elsif (rising_edge(clk)) then
                current_state <= next_state;
            end if;
        end process;

        u0: dfs port map (clk, rst1, ctrl1_en, n, ctrl2_en, wr1, addr1);
        u1: dfs_recurs port map (clk, rst2, ctrl2_en, visit, v, start, node_out, next_node, fnsh, wr2, addr2, print, vertex, node_in);
        u2: ram_8x1bit port map (clk, wr, addr, SEL, visit);
        u3: mux2_1_3bit port map (addr1, addr2, SEL, addr);
        wr <= wr1 or wr2;
end rtl;