library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity dfs_recurs is
    port (clk, rst, ctrl2_en, visit: in std_logic;
          v, start: in std_logic_vector (2 downto 0);
          node_out, next_node: in std_logic_vector (3 downto 0);
          fnsh, wr: out std_logic;
          addr, print, vertex: out std_logic_vector (2 downto 0);
          node_in: out std_logic_vector (3 downto 0));
end entity;

architecture rtl of dfs_recurs is
    component isEqual_4bit is
        port (x, y: in std_logic_vector (3 downto 0);
              isEqual: out std_logic);
    end component;

    component mux2_1_3bit is
        port (a, b: in std_logic_vector (2 downto 0);
              s: in std_logic;
              y: out std_logic_vector (2 downto 0));
    end component;

    component mux4_1_4bit is
        port (sel: in std_logic_vector (1 downto 0);
              a, b, c, d: in std_logic_vector (3 downto 0);
              y: out std_logic_vector (3 downto 0));
    end component;

    component reg_3bit is
        port (clk, rst, load: in std_logic;
              d: in std_logic_vector (2 downto 0);
              q: out std_logic_vector (2 downto 0));
    end component;

    component reg_4bit is
        port (clk, rst, load: in std_logic;
              d: in std_logic_vector (3 downto 0);
              q: out std_logic_vector (3 downto 0));
    end component;

    component stack_15x4bit is
        port (clk: in std_logic;
              i: in std_logic_vector (1 downto 0); -- instructions: 00:nothing, 01:push, 10:pop, 11:clear
              val: in std_logic_vector (3 downto 0);
              top: out std_logic_vector (3 downto 0);
              empty: out std_logic);
    end component;

    type state_type is (st0, st1, st2, st3, st4, st5, st6, st7);
    signal current_state, next_state: state_type;
    signal empty, x, sel0, sel1, s_ld, t_ld: std_logic;
    signal i, sel2: std_logic_vector (1 downto 0);
    signal s_in, start_Reg: std_logic_vector (2 downto 0);
    signal t_in, trav, top: std_logic_vector (3 downto 0);
begin
    process(current_state, ctrl2_en, x, visit, empty)
    begin
        case current_state is
            when st0 =>
                wr <= '0';
                i <= "11";
                sel0 <= '0';
                sel1 <= '0';
                sel2 <= "00";
                s_ld <= '0';
                t_ld <= '0';
                fnsh <= '0';
                if (ctrl2_en = '1') then
                    next_state <= st1;
                else
                    next_state <= st0;
                end if;
            when st1 =>
                wr <= '0';
                i <= "00";
                sel0 <= '0';
                sel1 <= '0';
                sel2 <= "00";
                s_ld <= '1';
                t_ld <= '0';
                fnsh <= '0';
                next_state <= st2;
            when st2 =>
                wr <= '1';
                i <= "00";
                sel0 <= '0';
                sel1 <= '0';
                sel2 <= "00";
                s_ld <= '0';
                t_ld <= '1';
                fnsh <= '0';
                next_state <= st3;
            when st3 =>
                wr <= '0';
                i <= "00";
                sel0 <= '1';
                sel1 <= '0';
                sel2 <= "00";
                s_ld <= '0';
                t_ld <= '0';
                fnsh <= '0';
                if (x = '0') then
                    if (visit = '0') then
                        next_state <= st4;
                    else
                        next_state <= st5;
                    end if;
                else
                    if (empty = '0') then
                        next_state <= st6;
                    else
                        next_state <= st7;
                    end if;
                end if;
            when st4 =>
                wr <= '0';
                i <= "01";
                sel0 <= '0';
                sel1 <= '1';
                sel2 <= "00";
                s_ld <= '1';
                t_ld <= '0';
                fnsh <= '0';
                next_state <= st2;
            when st5 =>
                wr <= '0';
                i <= "00";
                sel0 <= '0';
                sel1 <= '0';
                sel2 <= "01";
                s_ld <= '0';
                t_ld <= '1';
                fnsh <= '0';
                next_state <= st3;
            when st6 =>
                wr <= '0';
                i <= "10";
                sel0 <= '0';
                sel1 <= '0';
                sel2 <= "10";
                s_ld <= '0';
                t_ld <= '1';
                fnsh <= '0';
                next_state <= st5;
            when others =>
                wr <= '0';
                i <= "00";
                sel0 <= '0';
                sel1 <= '0';
                sel2 <= "00";
                s_ld <= '0';
                t_ld <= '0';
                fnsh <= '1';
                next_state <= st7;
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

    u0: isEqual_4bit port map (trav, "1111", x);
    u1: mux2_1_3bit port map (start_Reg, v, sel0, addr);
    u2: mux2_1_3bit port map (start, v, sel1, s_in);
    u3: mux4_1_4bit port map (sel2, node_out, next_node, top, "0000", t_in);
    u4: reg_3bit port map (clk, rst, s_ld, s_in, start_Reg);
    u5: reg_4bit port map (clk, rst, t_ld, t_in, trav);
    u6: stack_15x4bit port map (clk, i, trav, top, empty);
    print <= start_Reg;
    vertex <= start_Reg;
    node_in <= trav;
end rtl;
