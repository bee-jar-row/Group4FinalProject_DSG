library ieee;
use ieee.std_logic_1164.all;

entity InverseSBox is
  port (
    y : in  std_logic_vector(3 downto 0);   -- substituted value
    a : out std_logic_vector(3 downto 0)    -- original nibble
  );
end InverseSBox;

architecture BehavioralInverseSBox of InverseSBox is
begin
  process(y)
  begin
    -- reverse lookup (undo S3 substitution)
    case y is
      when "0000" => a <= "1100";  -- y=0  ? 12
      when "0001" => a <= "0101";  -- y=1  ? 5
      when "0010" => a <= "0000";  -- y=2  ? 0
      when "0011" => a <= "1110";  -- y=3  ? 14
      when "0100" => a <= "1001";  -- y=4  ? 9
      when "0101" => a <= "0011";  -- y=5  ? 3
      when "0110" => a <= "1010";  -- y=6  ? 10
      when "0111" => a <= "1101";  -- y=7  ? 13
      when "1000" => a <= "1011";  -- y=8  ? 11
      when "1001" => a <= "0110";  -- y=9  ? 6
      when "1010" => a <= "0111";  -- y=10 ? 7
      when "1011" => a <= "1000";  -- y=11 ? 8
      when "1100" => a <= "0100";  -- y=12 ? 4
      when "1101" => a <= "1111";  -- y=13 ? 15
      when "1110" => a <= "0001";  -- y=14 ? 1
      when "1111" => a <= "0010";  -- y=15 ? 2

      when others => a <= (others => '0');  -- fallback
    end case;
  end process;
end BehavioralInverseSBox;

