library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ModSub16 is
  port (
    A, B  : in  std_logic_vector(15 downto 0);
    DIFF  : out std_logic_vector(15 downto 0)
  );
end ModSub16;

architecture Behavioral of ModSub16 is
begin
  DIFF <= std_logic_vector(unsigned(A) - unsigned(B));
end Behavioral;