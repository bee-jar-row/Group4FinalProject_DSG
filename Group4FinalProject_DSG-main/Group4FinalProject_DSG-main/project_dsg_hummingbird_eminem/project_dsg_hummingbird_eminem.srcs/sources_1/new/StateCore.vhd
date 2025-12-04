library IEEE;
use IEEE.std_logic_1164.all;

entity StateCore is
    port (
        -- Global clock and reset
        clk      : in  std_logic;
        rst      : in  std_logic;

        -- 256-bit secret key input and 16 x 16-bit subkeys output
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

        -- LFSR control and observation
        lfsr_seed : in  std_logic_vector(15 downto 0);
        lfsr_load : in  std_logic;
        lfsr_en   : in  std_logic;
        lfsr_q    : out std_logic_vector(15 downto 0);

        -- State registers RS1-RS4: next values, write enables, outputs
        rs1_next : in  std_logic_vector(15 downto 0);
        rs2_next : in  std_logic_vector(15 downto 0);
        rs3_next : in  std_logic_vector(15 downto 0);
        rs4_next : in  std_logic_vector(15 downto 0);

        rs1_we   : in  std_logic;
        rs2_we   : in  std_logic;
        rs3_we   : in  std_logic;
        rs4_we   : in  std_logic;

        rs1_q    : out std_logic_vector(15 downto 0);
        rs2_q    : out std_logic_vector(15 downto 0);
        rs3_q    : out std_logic_vector(15 downto 0);
        rs4_q    : out std_logic_vector(15 downto 0)
    );
end entity StateCore;

architecture structural of StateCore is

    component LFSR16 is
        port (
            clk    : in  std_logic;
            rst    : in  std_logic;
            enable : in  std_logic;
            load   : in  std_logic;
            seed   : in  std_logic_vector(15 downto 0);
            q      : out std_logic_vector(15 downto 0)
        );
    end component;

    component StateRegisterBank is
        port (
            clk      : in  std_logic;
            rst      : in  std_logic;

            rs1_next : in  std_logic_vector(15 downto 0);
            rs2_next : in  std_logic_vector(15 downto 0);
            rs3_next : in  std_logic_vector(15 downto 0);
            rs4_next : in  std_logic_vector(15 downto 0);

            rs1_we   : in  std_logic;
            rs2_we   : in  std_logic;
            rs3_we   : in  std_logic;
            rs4_we   : in  std_logic;

            rs1_q    : out std_logic_vector(15 downto 0);
            rs2_q    : out std_logic_vector(15 downto 0);
            rs3_q    : out std_logic_vector(15 downto 0);
            rs4_q    : out std_logic_vector(15 downto 0)
        );
    end component;

    component KeyScheduler is
        port (
            key_256 : in  std_logic_vector(255 downto 0);

            k1      : out std_logic_vector(15 downto 0);
            k2      : out std_logic_vector(15 downto 0);
            k3      : out std_logic_vector(15 downto 0);
            k4      : out std_logic_vector(15 downto 0);
            k5      : out std_logic_vector(15 downto 0);
            k6      : out std_logic_vector(15 downto 0);
            k7      : out std_logic_vector(15 downto 0);
            k8      : out std_logic_vector(15 downto 0);
            k9      : out std_logic_vector(15 downto 0);
            k10     : out std_logic_vector(15 downto 0);
            k11     : out std_logic_vector(15 downto 0);
            k12     : out std_logic_vector(15 downto 0);
            k13     : out std_logic_vector(15 downto 0);
            k14     : out std_logic_vector(15 downto 0);
            k15     : out std_logic_vector(15 downto 0);
            k16     : out std_logic_vector(15 downto 0)
        );
    end component;

begin

    -- Split the 256-bit key into 16 x 16-bit subkeys
    u_KeyScheduler : KeyScheduler
        port map (
            key_256 => key_256,
            k1      => k1,
            k2      => k2,
            k3      => k3,
            k4      => k4,
            k5      => k5,
            k6      => k6,
            k7      => k7,
            k8      => k8,
            k9      => k9,
            k10     => k10,
            k11     => k11,
            k12     => k12,
            k13     => k13,
            k14     => k14,
            k15     => k15,
            k16     => k16
        );

    -- LFSR
    u_LFSR16 : LFSR16
        port map (
            clk    => clk,
            rst    => rst,
            enable => lfsr_en,
            load   => lfsr_load,
            seed   => lfsr_seed,
            q      => lfsr_q
        );

    -- State registers
    u_StateRegisterBank : StateRegisterBank
        port map (
            clk      => clk,
            rst      => rst,

            rs1_next => rs1_next,
            rs2_next => rs2_next,
            rs3_next => rs3_next,
            rs4_next => rs4_next,

            rs1_we   => rs1_we,
            rs2_we   => rs2_we,
            rs3_we   => rs3_we,
            rs4_we   => rs4_we,

            rs1_q    => rs1_q,
            rs2_q    => rs2_q,
            rs3_q    => rs3_q,
            rs4_q    => rs4_q
        );

end architecture structural;
