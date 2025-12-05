library ieee;
use ieee.std_logic_1164.all;

-- 4-bit substitution box (S3 from Hummingbird)
entity SBox4 is
  port (
    a : in  std_logic_vector(3 downto 0);   -- input nibble
    y : out std_logic_vector(3 downto 0)    -- substituted output
  );
end SBox4;

architecture Behavioral of SBox4 is
begin
  process(a)
  begin
    -- lookup table substitution
    case a is
      when "0000" => y <= "0010";  -- S3 index 0
      when "0001" => y <= "1110";
      when "0010" => y <= "1111";
      when "0011" => y <= "0101";
      when "0100" => y <= "1100";
      when "0101" => y <= "0001";
      when "0110" => y <= "1001";
      when "0111" => y <= "1010";
      when "1000" => y <= "1011";
      when "1001" => y <= "0100";
      when "1010" => y <= "0110";
      when "1011" => y <= "1000";
      when "1100" => y <= "0000";
      when "1101" => y <= "0111";
      when "1110" => y <= "0011";
      when "1111" => y <= "1101";

      when others => y <= (others => '0');  -- unused pattern fallback
    end case;
  end process;
end Behavioral;