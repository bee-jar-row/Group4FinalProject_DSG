library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ControlCore is
    port (
        clk       : in  std_logic;
        rst       : in  std_logic;
        start     : in  std_logic;
        mode_enc  : in  std_logic;
        busy      : out std_logic;
        ready     : out std_logic;
        lfsr_en   : out std_logic;
        lfsr_load : out std_logic;
        rs1_we    : out std_logic;
        rs2_we    : out std_logic;
        rs3_we    : out std_logic;
        rs4_we    : out std_logic;
        init_mode : out std_logic;
        block_sel : out std_logic_vector(1 downto 0);
        round_cnt : out std_logic_vector(2 downto 0)
    );
end entity;

architecture rtl of ControlCore is

    type state_t is (
        S_IDLE,
        S_INIT,
        S_R1,
        S_R2,
        S_R3,
        S_R4,
        S_DONE
    );

    constant NUM_ROUNDS  : integer := 4;
    constant INIT_CYCLES : integer := 8;

    signal s_reg, s_next : state_t;
    signal r_reg, r_next : integer range 0 to NUM_ROUNDS-1;
    signal i_reg, i_next : integer range 0 to INIT_CYCLES-1;

    signal busy_i, ready_i : std_logic;
    signal lfsr_en_i, lfsr_load_i : std_logic;
    signal rs1_we_i, rs2_we_i, rs3_we_i, rs4_we_i : std_logic;
    signal init_mode_i : std_logic;
    signal block_sel_i : std_logic_vector(1 downto 0);
    signal round_cnt_i : std_logic_vector(2 downto 0);

begin

    busy      <= busy_i;
    ready     <= ready_i;
    lfsr_en   <= lfsr_en_i;
    lfsr_load <= lfsr_load_i;
    rs1_we    <= rs1_we_i;
    rs2_we    <= rs2_we_i;
    rs3_we    <= rs3_we_i;
    rs4_we    <= rs4_we_i;
    init_mode <= init_mode_i;
    block_sel <= block_sel_i;
    round_cnt <= round_cnt_i;

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                s_reg <= S_IDLE;
                r_reg <= 0;
                i_reg <= 0;
            else
                s_reg <= s_next;
                r_reg <= r_next;
                i_reg <= i_next;
            end if;
        end if;
    end process;

    process(s_reg, r_reg, i_reg, start)
    begin
        busy_i      <= '0';
        ready_i     <= '0';
        lfsr_en_i   <= '0';
        lfsr_load_i <= '0';
        rs1_we_i    <= '0';
        rs2_we_i    <= '0';
        rs3_we_i    <= '0';
        rs4_we_i    <= '0';
        init_mode_i <= '0';
        block_sel_i <= "00";

        round_cnt_i <= std_logic_vector(to_unsigned(r_reg, 3));

        s_next <= s_reg;
        r_next <= r_reg;
        i_next <= i_reg;

        case s_reg is
            when S_IDLE =>
                if start = '1' then
                    s_next <= S_INIT;
                    i_next <= 0;
                    r_next <= 0;
                end if;

            when S_INIT =>
                busy_i      <= '1';
                init_mode_i <= '1';

                if i_reg = 0 then
                    lfsr_load_i <= '1';
                    rs1_we_i    <= '1';
                    rs2_we_i    <= '1';
                    rs3_we_i    <= '1';
                    rs4_we_i    <= '1';
                else
                    lfsr_en_i   <= '1';
                    rs1_we_i    <= '1';
                    rs2_we_i    <= '1';
                    rs3_we_i    <= '1';
                    rs4_we_i    <= '1';
                end if;

                if i_reg = INIT_CYCLES-1 then
                    s_next <= S_R1;
                    r_next <= 0;
                else
                    i_next <= i_reg + 1;
                end if;

            when S_R1 =>
                busy_i      <= '1';
                block_sel_i <= "00";
                lfsr_en_i   <= '1';
                rs1_we_i    <= '1';

                if r_reg = NUM_ROUNDS-1 then
                    r_next <= 0;
                    s_next <= S_R2;
                else
                    r_next <= r_reg + 1;
                end if;

            when S_R2 =>
                busy_i      <= '1';
                block_sel_i <= "01";
                lfsr_en_i   <= '1';
                rs2_we_i    <= '1';

                if r_reg = NUM_ROUNDS-1 then
                    r_next <= 0;
                    s_next <= S_R3;
                else
                    r_next <= r_reg + 1;
                end if;

            when S_R3 =>
                busy_i      <= '1';
                block_sel_i <= "10";
                lfsr_en_i   <= '1';
                rs3_we_i    <= '1';

                if r_reg = NUM_ROUNDS-1 then
                    r_next <= 0;
                    s_next <= S_R4;
                else
                    r_next <= r_reg + 1;
                end if;

            when S_R4 =>
                busy_i      <= '1';
                block_sel_i <= "11";
                lfsr_en_i   <= '1';
                rs4_we_i    <= '1';

                if r_reg = NUM_ROUNDS-1 then
                    s_next <= S_DONE;
                else
                    r_next <= r_reg + 1;
                end if;

            when S_DONE =>
                ready_i <= '1';
                s_next  <= S_IDLE;
        end case;
    end process;

end architecture;
