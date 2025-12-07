library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RoundDatapath is
    port (
        rs1_q    : in  std_logic_vector(15 downto 0);
        rs2_q    : in  std_logic_vector(15 downto 0);
        lfsr_q   : in  std_logic_vector(15 downto 0);

        rs1_next : out std_logic_vector(15 downto 0);
        rs2_next : out std_logic_vector(15 downto 0)
    );
end entity;

architecture rtl of RoundDatapath is
begin
    rs1_next <= std_logic_vector(unsigned(rs1_q) xor unsigned(lfsr_q));
    rs2_next <= std_logic_vector(unsigned(rs2_q) xor unsigned(lfsr_q));
end architecture;
