library IEEE;
use IEEE.std_logic_1164.all;

entity TopLevel is
    port (
        clk       : in  std_logic;
        rst       : in  std_logic;
        start     : in  std_logic;
        mode_enc  : in  std_logic;

        key_256   : in  std_logic_vector(255 downto 0);
        lfsr_seed : in  std_logic_vector(15 downto 0)
    );
end entity TopLevel;

architecture structural of TopLevel is

    component ControlCore is
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
    end component;

    component RoundDatapath is
        port (
            block_sel : in  std_logic_vector(1 downto 0);
            round_cnt : in  std_logic_vector(2 downto 0);

            rs1_q     : in  std_logic_vector(15 downto 0);
            rs2_q     : in  std_logic_vector(15 downto 0);
            rs3_q     : in  std_logic_vector(15 downto 0);
            rs4_q     : in  std_logic_vector(15 downto 0);
            lfsr_q    : in  std_logic_vector(15 downto 0);

            rs1_next  : out std_logic_vector(15 downto 0);
            rs2_next  : out std_logic_vector(15 downto 0);
            rs3_next  : out std_logic_vector(15 downto 0);
            rs4_next  : out std_logic_vector(15 downto 0)
        );
    end component;

    component StateCore is
        port (
            clk      : in  std_logic;
            rst      : in  std_logic;

            key_256  : in  std_logic_vector(255 downto 0);
            k1       : out std_logic_vector(15 downto 0);
            k2       : out std_logic_vector(15 downto 0);
            k3       : out std_logic_vector(15 downto 0);
            k4       : out std_logic_vector(15 downto 0);
            k5       : out std_logic_vector(15 downto 0);
            k6       : out std_logic_vector(15 downto 0);
            k7       : out std_logic_vector(15 downto 0);
            k8       : out std_logic_vector(15 downto 0);
            k9       : out std_logic_vector(15 downto 0);
            k10      : out std_logic_vector(15 downto 0);
            k11      : out std_logic_vector(15 downto 0);
            k12      : out std_logic_vector(15 downto 0);
            k13      : out std_logic_vector(15 downto 0);
            k14      : out std_logic_vector(15 downto 0);
            k15      : out std_logic_vector(15 downto 0);
            k16      : out std_logic_vector(15 downto 0);

            lfsr_seed : in std_logic_vector(15 downto 0);
            lfsr_load : in std_logic;
            lfsr_en   : in std_logic;
            lfsr_q    : out std_logic_vector(15 downto 0);

            rs1_next : in std_logic_vector(15 downto 0);
            rs2_next : in std_logic_vector(15 downto 0);
            rs3_next : in std_logic_vector(15 downto 0);
            rs4_next : in std_logic_vector(15 downto 0);

            rs1_we   : in std_logic;
            rs2_we   : in std_logic;
            rs3_we   : in std_logic;
            rs4_we   : in std_logic;

            rs1_q    : out std_logic_vector(15 downto 0);
            rs2_q    : out std_logic_vector(15 downto 0);
            rs3_q    : out std_logic_vector(15 downto 0);
            rs4_q    : out std_logic_vector(15 downto 0)
        );
    end component;

    signal busy_s, ready_s : std_logic;
    signal lfsr_en_s, lfsr_load_s : std_logic;
    signal rs1_we_s, rs2_we_s, rs3_we_s, rs4_we_s : std_logic;
    signal block_sel_s : std_logic_vector(1 downto 0);
    signal round_cnt_s : std_logic_vector(2 downto 0);
    signal rs1_q_s, rs2_q_s, rs3_q_s, rs4_q_s : std_logic_vector(15 downto 0);
    signal rs1_next_s, rs2_next_s, rs3_next_s, rs4_next_s : std_logic_vector(15 downto 0);
    signal lfsr_q_s : std_logic_vector(15 downto 0);

begin

    ctrl : ControlCore
        port map (
            clk       => clk,
            rst       => rst,
            start     => start,
            mode_enc  => mode_enc,
            busy      => busy_s,
            ready     => ready_s,
            lfsr_en   => lfsr_en_s,
            lfsr_load => lfsr_load_s,
            rs1_we    => rs1_we_s,
            rs2_we    => rs2_we_s,
            rs3_we    => rs3_we_s,
            rs4_we    => rs4_we_s,
            init_mode => open,
            block_sel => block_sel_s,
            round_cnt => round_cnt_s
        );

    datapath : RoundDatapath
        port map (
            block_sel => block_sel_s,
            round_cnt => round_cnt_s,

            rs1_q => rs1_q_s,
            rs2_q => rs2_q_s,
            rs3_q => rs3_q_s,
            rs4_q => rs4_q_s,
            lfsr_q => lfsr_q_s,

            rs1_next => rs1_next_s,
            rs2_next => rs2_next_s,
            rs3_next => rs3_next_s,
            rs4_next => rs4_next_s
        );

    core : StateCore
        port map (
            clk   => clk,
            rst   => rst,

            key_256 => key_256,
            k1 => open, k2 => open, k3 => open, k4 => open,
            k5 => open, k6 => open, k7 => open, k8 => open,
            k9 => open, k10 => open, k11 => open, k12 => open,
            k13 => open, k14 => open, k15 => open, k16 => open,

            lfsr_seed => lfsr_seed,
            lfsr_load => lfsr_load_s,
            lfsr_en   => lfsr_en_s,
            lfsr_q    => lfsr_q_s,

            rs1_next => rs1_next_s,
            rs2_next => rs2_next_s,
            rs3_next => rs3_next_s,
            rs4_next => rs4_next_s,

            rs1_we => rs1_we_s,
            rs2_we => rs2_we_s,
            rs3_we => rs3_we_s,
            rs4_we => rs4_we_s,

            rs1_q => rs1_q_s,
            rs2_q => rs2_q_s,
            rs3_q => rs3_q_s,
            rs4_q => rs4_q_s
        );

end architecture structural;
