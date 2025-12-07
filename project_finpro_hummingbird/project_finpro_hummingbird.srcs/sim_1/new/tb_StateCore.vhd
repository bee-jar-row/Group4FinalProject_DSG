library IEEE;
use IEEE.std_logic_1164.all;

entity tb_StateCore is
end entity tb_StateCore;

architecture sim of tb_StateCore is

    -- Signals to drive the DUT 
    signal clk       : std_logic := '0';
    signal rst       : std_logic := '0';

    -- Key interface
    signal key_256   : std_logic_vector(255 downto 0) := (others => '0');
    signal k1        : std_logic_vector(15 downto 0);
    signal k2        : std_logic_vector(15 downto 0);
    signal k3        : std_logic_vector(15 downto 0);
    signal k4        : std_logic_vector(15 downto 0);
    signal k5        : std_logic_vector(15 downto 0);
    signal k6        : std_logic_vector(15 downto 0);
    signal k7        : std_logic_vector(15 downto 0);
    signal k8        : std_logic_vector(15 downto 0);
    signal k9        : std_logic_vector(15 downto 0);
    signal k10       : std_logic_vector(15 downto 0);
    signal k11       : std_logic_vector(15 downto 0);
    signal k12       : std_logic_vector(15 downto 0);
    signal k13       : std_logic_vector(15 downto 0);
    signal k14       : std_logic_vector(15 downto 0);
    signal k15       : std_logic_vector(15 downto 0);
    signal k16       : std_logic_vector(15 downto 0);

    -- LFSR interface
    signal lfsr_seed : std_logic_vector(15 downto 0) := (others => '0');
    signal lfsr_load : std_logic := '0';
    signal lfsr_en   : std_logic := '0';
    signal lfsr_q    : std_logic_vector(15 downto 0);

    -- State registers RS1-RS4
    signal rs1_next  : std_logic_vector(15 downto 0) := (others => '0');
    signal rs2_next  : std_logic_vector(15 downto 0) := (others => '0');
    signal rs3_next  : std_logic_vector(15 downto 0) := (others => '0');
    signal rs4_next  : std_logic_vector(15 downto 0) := (others => '0');

    signal rs1_we    : std_logic := '0';
    signal rs2_we    : std_logic := '0';
    signal rs3_we    : std_logic := '0';
    signal rs4_we    : std_logic := '0';

    signal rs1_q     : std_logic_vector(15 downto 0);
    signal rs2_q     : std_logic_vector(15 downto 0);
    signal rs3_q     : std_logic_vector(15 downto 0);
    signal rs4_q     : std_logic_vector(15 downto 0);

begin

    -- Clock generation: 10 ns period 
    clk_process : process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process clk_process;

    -- DUT instantiation
    uut_StateCore : entity work.StateCore
        port map (
            clk       => clk,
            rst       => rst,

            key_256   => key_256,
            k1        => k1,
            k2        => k2,
            k3        => k3,
            k4        => k4,
            k5        => k5,
            k6        => k6,
            k7        => k7,
            k8        => k8,
            k9        => k9,
            k10       => k10,
            k11       => k11,
            k12       => k12,
            k13       => k13,
            k14       => k14,
            k15       => k15,
            k16       => k16,

            lfsr_seed => lfsr_seed,
            lfsr_load => lfsr_load,
            lfsr_en   => lfsr_en,
            lfsr_q    => lfsr_q,

            rs1_next  => rs1_next,
            rs2_next  => rs2_next,
            rs3_next  => rs3_next,
            rs4_next  => rs4_next,

            rs1_we    => rs1_we,
            rs2_we    => rs2_we,
            rs3_we    => rs3_we,
            rs4_we    => rs4_we,

            rs1_q     => rs1_q,
            rs2_q     => rs2_q,
            rs3_q     => rs3_q,
            rs4_q     => rs4_q
        );

    -- Stimulus process
    stim_proc : process
    begin
        -- Apply reset
        rst <= '1';
        wait for 20 ns;
        rst <= '0';

        -- 256-bit key example 
        key_256 <= x"0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF";
        wait for 20 ns;

        -- Initialize and run the LFSR
        lfsr_seed <= x"0001";
        lfsr_load <= '1';
        wait for 10 ns;
        lfsr_load <= '0';

        lfsr_en <= '1';
        wait for 100 ns;

        -- Test RS1-RS4 register writes

        -- RS1 = 0x1111
        rs1_next <= x"1111";
        rs1_we   <= '1';
        wait for 10 ns;
        rs1_we   <= '0';

        -- RS2 = 0x2222
        rs2_next <= x"2222";
        rs2_we   <= '1';
        wait for 10 ns;
        rs2_we   <= '0';

        -- RS3 = 0x3333 and RS4 = 0x4444
        rs3_next <= x"3333";
        rs4_next <= x"4444";
        rs3_we   <= '1';
        rs4_we   <= '1';
        wait for 10 ns;
        rs3_we   <= '0';
        rs4_we   <= '0';

        wait for 100 ns;

        lfsr_en <= '0';
        wait for 50 ns;

        wait;
    end process stim_proc;

end architecture sim;
