library IEEE;
use IEEE.std_logic_1164.all;

entity KeyScheduler is
    port (
        -- 256-bit secret key input
        key_256 : in  std_logic_vector(255 downto 0);

        -- 16 x 16-bit subkeys (total 256 bits)
        k1      : out std_logic_vector(15 downto 0);
        k2      : out std_logic_vector(15 downto 0);
        k3      : out std_logic_vector(15 downto 0);
        k4      : out std_logic_vector(15 downto 0);
        k5      : out std_logic_vector(15 downto 0);
        k6      : out std_logic_vector(15 downto 0);
        k7      : out std_logic_vector(15 downto 0);
        k8      : out std_logic_vector(15 downto 0);
        k9      : out std_logic_vector(15 downto 0);
        k10     : out std_logic_vector(15 downto 0);
        k11     : out std_logic_vector(15 downto 0);
        k12     : out std_logic_vector(15 downto 0);
        k13     : out std_logic_vector(15 downto 0);
        k14     : out std_logic_vector(15 downto 0);
        k15     : out std_logic_vector(15 downto 0);
        k16     : out std_logic_vector(15 downto 0)
    );
end entity KeyScheduler;

architecture rtl of KeyScheduler is
begin

    -- Combinational splitting of the 256-bit key into 16 x 16-bit subkeys
    
    k1  <= key_256(255 downto 240);  
    k2  <= key_256(239 downto 224); 
    k3  <= key_256(223 downto 208);  
    k4  <= key_256(207 downto 192);  
    k5  <= key_256(191 downto 176);  
    k6  <= key_256(175 downto 160);  
    k7  <= key_256(159 downto 144);  
    k8  <= key_256(143 downto 128);  
    k9  <= key_256(127 downto 112);  
    k10 <= key_256(111 downto 96);   
    k11 <= key_256(95 downto 80);    
    k12 <= key_256(79 downto 64);    
    k13 <= key_256(63 downto 48);    
    k14 <= key_256(47 downto 32);    
    k15 <= key_256(31 downto 16);   
    k16 <= key_256(15 downto 0);     

end architecture rtl;