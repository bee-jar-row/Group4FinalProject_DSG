library IEEE;
use IEEE.std_logic_1164.all;

entity tb_TopLevel is
end entity;

architecture sim of tb_TopLevel is

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal start : std_logic := '0';

    signal key_256 : std_logic_vector(255 downto 0);
    signal seed    : std_logic_vector(15 downto 0);

    signal ciphertext : std_logic_vector(15 downto 0);
    signal done       : std_logic;

begin

    clk <= not clk after 5 ns;

    uut : entity work.TopLevel
        port map (
            clk => clk,
            rst => rst,
            start => start,
            key_256 => key_256,
            lfsr_seed => seed,
            ciphertext => ciphertext,
            done => done
        );

    process
    begin
        key_256 <= (others => '1');
        seed <= x"ACE1";

        wait for 20 ns;
        rst <= '0';

        wait for 10 ns;
        start <= '1';

        wait for 10 ns;
        start <= '0';

        wait until done = '1';
        assert false report "Simulation finished. Ciphertext = " & to_hstring(ciphertext) severity note;
        wait;
    end process;

end architecture;
