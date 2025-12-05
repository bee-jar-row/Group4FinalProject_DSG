library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Linear Transform: L(m) = m xor (m rol 6) xor (m rol 10)
entity LinearTransform is
    port (
        m_in  : in  std_logic_vector(15 downto 0);
        m_out : out std_logic_vector(15 downto 0)
    );
end entity;

architecture Behavioral of LinearTransform is

    -- Robust 16-bit rotate-left by k (0..15) using modular indexing
    function rol16(x : std_logic_vector(15 downto 0); k : integer range 0 to 15)
        return std_logic_vector is
        variable tmp : std_logic_vector(15 downto 0);
        variable i   : integer;
        variable src : integer;
    begin
        for i in 0 to 15 loop
            -- result bit at index i comes from input bit (i - k) mod 16
            src := (i - k);
            while src < 0 loop
                src := src + 16;
            end loop;
            src := src mod 16;
            tmp(i) := x(src);
        end loop;
        return tmp;
    end function;

begin
    -- Note: indexing uses 15 downto 0 for the vectors; the function preserves that mapping.
    m_out <= m_in xor rol16(m_in, 6) xor rol16(m_in, 10);
end architecture;
