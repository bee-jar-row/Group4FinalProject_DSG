library IEEE;
use IEEE.std_logic_1164.all;

entity LFSR16 is
    port (
        clk    : in  std_logic;                          -- clock
        rst    : in  std_logic;                          -- synchronous reset, active high
        enable : in  std_logic;                          -- when 1, advance one LFSR step
        load   : in  std_logic;                          -- when 1, load seed instead of stepping
        seed   : in  std_logic_vector(15 downto 0);      -- initial non-zero seed
        q      : out std_logic_vector(15 downto 0)       -- current LFSR state
    );
end entity LFSR16;

architecture rtl of LFSR16 is

    signal lfsr_reg : std_logic_vector(15 downto 0);

begin

    -- Expose internal register as output
    q <= lfsr_reg;

    process(clk)
        variable feedback : std_logic;
    begin
        if rising_edge(clk) then
            if rst = '1' then
                -- reset LFSR to all zeros 
                lfsr_reg <= (others => '0');

            elsif load = '1' then
                -- load the provided seed
                lfsr_reg <= seed;

            elsif enable = '1' then
                -- Galois LFSR update for polynomial:
                -- x^16 + x^15 + x^12 + x^10 + x^7 + x^3 + 1

                feedback := lfsr_reg(15);  -- MSB as feedback bit

                -- shift with taps 
                lfsr_reg(15) <= lfsr_reg(14);
                lfsr_reg(14) <= lfsr_reg(13);
                lfsr_reg(13) <= lfsr_reg(12) xor feedback;   -- tap for x^15
                lfsr_reg(12) <= lfsr_reg(11);
                lfsr_reg(11) <= lfsr_reg(10);
                lfsr_reg(10) <= lfsr_reg(9)  xor feedback;   -- tap for x^12
                lfsr_reg(9)  <= lfsr_reg(8);
                lfsr_reg(8)  <= lfsr_reg(7)  xor feedback;   -- tap for x^10
                lfsr_reg(7)  <= lfsr_reg(6);
                lfsr_reg(6)  <= lfsr_reg(5);
                lfsr_reg(5)  <= lfsr_reg(4) xor feedback;    -- tap for x^7
                lfsr_reg(4)  <= lfsr_reg(3);
                lfsr_reg(3)  <= lfsr_reg(2);
                lfsr_reg(2)  <= lfsr_reg(1);
                lfsr_reg(1)  <= lfsr_reg(0) xor feedback;    -- tap for x^3
                lfsr_reg(0)  <= feedback;                    -- new incoming bit

            else
                null;
            end if;
        end if;
    end process;

end architecture rtl;
