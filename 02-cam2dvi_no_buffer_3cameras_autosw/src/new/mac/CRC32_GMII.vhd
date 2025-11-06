library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity CRC32_GMII is
    Port ( 
		--时钟及复位
		E_TXC			: in std_logic;
		reset_n			: in std_logic;
		-- clk_byte		: in std_logic;
		--MAC帧数据
		MAC_data		: in std_logic_vector(7 downto 0);
		MAC_en			: in std_logic;
		--CRC32校验值
		MAC_FCS			: out std_logic_vector(31 downto 0)
	);
end CRC32_GMII;

architecture rtl of CRC32_GMII is
signal MAC_en_reg : std_logic;
signal d : std_logic_vector(7 downto 0);
signal c : std_logic_vector(31 downto 0);
begin
process(E_TXC,reset_n)
	begin
		if reset_n='0' then
			MAC_FCS<=(others=>'0');
		elsif rising_edge(E_TXC) then
			if MAC_en_reg='1' then
				MAC_FCS<=not(c(24)&c(25)&c(26)&c(27)&c(28)&c(29)&c(30)&c(31)&c(16)&c(17)&c(18)&c(19)&c(20)&c(21)&c(22)&c(23)&c(8)&c(9)&c(10)&c(11)&c(12)&c(13)&c(14)&c(15)&c(0)&c(1)&c(2)&c(3)&c(4)&c(5)&c(6)&c(7));
			end if;
		end if;
end process;
process(E_TXC,reset_n)
	begin
		if reset_n='0' then
			MAC_en_reg<='0';
		elsif rising_edge(E_TXC) then
			MAC_en_reg<=MAC_en;
		end if;
end process;
d<=MAC_data(0)&MAC_data(1)&MAC_data(2)&MAC_data(3)&MAC_data(4)&MAC_data(5)&MAC_data(6)&MAC_data(7);
process(E_TXC,reset_n)
	begin
		if reset_n='0' then
			c<=(others=>'1');
		elsif rising_edge(E_TXC) then
            if MAC_en='0' then
                c<=(others=>'1');
            else
                c(0) <= d(6) xor d(0) xor c(24) xor c(30);
                c(1) <= d(7) xor d(6) xor d(1) xor d(0) xor c(24) xor c(25) xor c(30) xor c(31);
                c(2) <= d(7) xor d(6) xor d(2) xor d(1) xor d(0) xor c(24) xor c(25) xor c(26) xor c(30) xor c(31);
                c(3) <= d(7) xor d(3) xor d(2) xor d(1) xor c(25) xor c(26) xor c(27) xor c(31);
                c(4) <= d(6) xor d(4) xor d(3) xor d(2) xor d(0) xor c(24) xor c(26) xor c(27) xor c(28) xor c(30);
                c(5) <= d(7) xor d(6) xor d(5) xor d(4) xor d(3) xor d(1) xor d(0) xor c(24) xor c(25) xor c(27) xor c(28) xor c(29) xor c(30) xor c(31);
                c(6) <= d(7) xor d(6) xor d(5) xor d(4) xor d(2) xor d(1) xor c(25) xor c(26) xor c(28) xor c(29) xor c(30) xor c(31);
                c(7) <= d(7) xor d(5) xor d(3) xor d(2) xor d(0) xor c(24) xor c(26) xor c(27) xor c(29) xor c(31);
                c(8) <= d(4) xor d(3) xor d(1) xor d(0) xor c(0) xor c(24) xor c(25) xor c(27) xor c(28);
                c(9) <= d(5) xor d(4) xor d(2) xor d(1) xor c(1) xor c(25) xor c(26) xor c(28) xor c(29);
                c(10) <= d(5) xor d(3) xor d(2) xor d(0) xor c(2) xor c(24) xor c(26) xor c(27) xor c(29);
                c(11) <= d(4) xor d(3) xor d(1) xor d(0) xor c(3) xor c(24) xor c(25) xor c(27) xor c(28);
                c(12) <= d(6) xor d(5) xor d(4) xor d(2) xor d(1) xor d(0) xor c(4) xor c(24) xor c(25) xor c(26) xor c(28) xor c(29) xor c(30);
                c(13) <= d(7) xor d(6) xor d(5) xor d(3) xor d(2) xor d(1) xor c(5) xor c(25) xor c(26) xor c(27) xor c(29) xor c(30) xor c(31);
                c(14) <= d(7) xor d(6) xor d(4) xor d(3) xor d(2) xor c(6) xor c(26) xor c(27) xor c(28) xor c(30) xor c(31);
                c(15) <= d(7) xor d(5) xor d(4) xor d(3) xor c(7) xor c(27) xor c(28) xor c(29) xor c(31);
                c(16) <= d(5) xor d(4) xor d(0) xor c(8) xor c(24) xor c(28) xor c(29);
                c(17) <= d(6) xor d(5) xor d(1) xor c(9) xor c(25) xor c(29) xor c(30);
                c(18) <= d(7) xor d(6) xor d(2) xor c(10) xor c(26) xor c(30) xor c(31);
                c(19) <= d(7) xor d(3) xor c(11) xor c(27) xor c(31);
                c(20) <= d(4) xor c(12) xor c(28);
                c(21) <= d(5) xor c(13) xor c(29);
                c(22) <= d(0) xor c(14) xor c(24);
                c(23) <= d(6) xor d(1) xor d(0) xor c(15) xor c(24) xor c(25) xor c(30);
                c(24) <= d(7) xor d(2) xor d(1) xor c(16) xor c(25) xor c(26) xor c(31);
                c(25) <= d(3) xor d(2) xor c(17) xor c(26) xor c(27);
                c(26) <= d(6) xor d(4) xor d(3) xor d(0) xor c(18) xor c(24) xor c(27) xor c(28) xor c(30);
                c(27) <= d(7) xor d(5) xor d(4) xor d(1) xor c(19) xor c(25) xor c(28) xor c(29) xor c(31);
                c(28) <= d(6) xor d(5) xor d(2) xor c(20) xor c(26) xor c(29) xor c(30);
                c(29) <= d(7) xor d(6) xor d(3) xor c(21) xor c(27) xor c(30) xor c(31);
                c(30) <= d(7) xor d(4) xor c(22) xor c(28) xor c(31);
                c(31) <= d(5) xor c(23) xor c(29);
            end if;
		end if;
end process;
end rtl ;