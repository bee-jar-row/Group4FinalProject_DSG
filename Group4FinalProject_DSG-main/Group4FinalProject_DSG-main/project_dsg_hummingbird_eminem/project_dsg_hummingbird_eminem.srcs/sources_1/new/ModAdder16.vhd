library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- 16-bit modulo-2^16 adder (wrap-around)
entity ModAdder16 is
  port (
    A, B : in  std_logic_vector(15 downto 0);
    SUM  : out std_logic_vector(15 downto 0)
  );
end ModAdder16;

architecture Behavioral of ModAdder16 is
begin
  SUM <= std_logic_vector(unsigned(A) + unsigned(B));
end Behavioral;
