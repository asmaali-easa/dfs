library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity dfs is
    port (clk, rst, ctrl1_en: in std_logic;
          n: in std_logic_vector (2 downto 0);
          ctrl2_en, wr: out std_logic;
          addr: out std_logic_vector (2 downto 0));
end entity;

architecture rtl of dfs is
    component counter_3bit is
        port (clk, rst, en: in std_logic;
              count: out std_logic_vector(2 downto 0));
    end component;

    component inc_3bit is
        port (x: in std_logic_vector (2 downto 0);
              y: out std_logic_vector (2 downto 0));
    end component;

    component isEqual_3bit is
        port (x, y: in std_logic_vector (2 downto 0);
              isEqual: out std_logic);
    end component;

    type state_type is (st0, st1, st2);
    signal current_state, next_state: state_type;
    signal fnsh, count_rst, count_en: std_logic;
    signal count, count_plus: std_logic_vector (2 downto 0);
begin
    process(current_state, ctrl1_en, fnsh)
    begin
        case current_state is
            when st0 =>
                count_rst <= '1';
                count_en <= '0';
                wr <= '0';
                ctrl2_en <= '0';
                if (ctrl1_en = '1') then
                    next_state <= st1;
                else
                    next_state <= st0;
                end if;
            when st1 =>
                count_rst <= '0';
                count_en <= '1';
                wr <= '1';
                ctrl2_en <= '0';
                if (fnsh = '1') then
                    next_state <= st2;
                else
                    next_state <= st1;
                end if;
            when others =>
                count_rst <= '0';
                count_en <= '0';
                wr <= '0';
                ctrl2_en <= '1';
                next_state <= st2;
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

    u0: counter_3bit port map (clk, count_rst, count_en, count);
    u1: inc_3bit port map (count, count_plus);
    u2: isEqual_3bit port map (count_plus, n, fnsh);
    addr <= count_plus;
end rtl;