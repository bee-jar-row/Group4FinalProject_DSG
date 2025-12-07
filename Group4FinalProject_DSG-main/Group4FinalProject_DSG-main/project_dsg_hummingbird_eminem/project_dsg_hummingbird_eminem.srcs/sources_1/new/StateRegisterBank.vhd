library IEEE;
use IEEE.std_logic_1164.all;

entity StateRegisterBank is
    port (
        clk      : in  std_logic;                          -- system clock
        rst      : in  std_logic;                          -- synchronous reset 

        -- Next values from datapath (Bijar)
        rs1_next : in  std_logic_vector(15 downto 0);
        rs2_next : in  std_logic_vector(15 downto 0);
        rs3_next : in  std_logic_vector(15 downto 0);
        rs4_next : in  std_logic_vector(15 downto 0);

        -- Write-enables from controller (Ziyad)
        rs1_we   : in  std_logic;
        rs2_we   : in  std_logic;
        rs3_we   : in  std_logic;
        rs4_we   : in  std_logic;

        -- Current register contents to datapath 
        rs1_q    : out std_logic_vector(15 downto 0);
        rs2_q    : out std_logic_vector(15 downto 0);
        rs3_q    : out std_logic_vector(15 downto 0);
        rs4_q    : out std_logic_vector(15 downto 0)
    );
end entity StateRegisterBank;

architecture rtl of StateRegisterBank is

    -- Internal storage registers
    signal rs1_reg : std_logic_vector(15 downto 0);
    signal rs2_reg : std_logic_vector(15 downto 0);
    signal rs3_reg : std_logic_vector(15 downto 0);
    signal rs4_reg : std_logic_vector(15 downto 0);

begin

    -- Drive outputs
    rs1_q <= rs1_reg;
    rs2_q <= rs2_reg;
    rs3_q <= rs3_reg;
    rs4_q <= rs4_reg;

    -- Synchronous update logic
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                -- Reset all registers to zero 
                rs1_reg <= (others => '0');
                rs2_reg <= (others => '0');
                rs3_reg <= (others => '0');
                rs4_reg <= (others => '0');

            else
                -- Update RS1 
                if rs1_we = '1' then
                    rs1_reg <= rs1_next;
                end if;

                -- Update RS2
                if rs2_we = '1' then
                    rs2_reg <= rs2_next;
                end if;

                -- Update RS3
                if rs3_we = '1' then
                    rs3_reg <= rs3_next;
                end if;

                -- Update RS4
                if rs4_we = '1' then
                    rs4_reg <= rs4_next;
                end if;
            end if;
        end if;
    end process;

end architecture rtl;
