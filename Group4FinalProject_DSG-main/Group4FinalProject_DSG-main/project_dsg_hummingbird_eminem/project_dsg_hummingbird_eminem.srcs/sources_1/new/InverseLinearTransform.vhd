library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Inverse Linear Transform:
-- m = x xor (x rol 2) xor (x rol 4) xor (x rol 12) xor (x rol 14)
entity InverseLinearTransform is
    port (
        x_in  : in  std_logic_vector(15 downto 0);
        m_out : out std_logic_vector(15 downto 0)
    );
end entity;

architecture Behavioral of InverseLinearTransform is

    function rol16(x : std_logic_vector(15 downto 0); k : integer range 0 to 15)
        return std_logic_vector is
        variable tmp : std_logic_vector(15 downto 0);
        variable i   : integer;
        variable src : integer;
    begin
        for i in 0 to 15 loop
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
    m_out <= x_in
             xor rol16(x_in, 2)
             xor rol16(x_in, 4)
             xor rol16(x_in, 12)
             xor rol16(x_in, 14);
end architecture;
