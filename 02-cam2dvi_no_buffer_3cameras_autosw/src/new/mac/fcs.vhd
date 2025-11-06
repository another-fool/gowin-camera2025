library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fcs is
    port (
		reset_n			: in std_logic;
        MAC_data		: in std_logic_vector(7 downto 0);
		MAC_en			: in std_logic;
		E_TXC   		: in std_logic;
		E_TXD			: out std_logic_vector(7 downto 0);
		E_TXEN  		: out std_logic
    );
end fcs;

architecture rtl of fcs is

signal MAC_en_shift : std_logic_vector(11 downto 0);
signal MAC_en_reg   : std_logic;
signal MAC_FCS      : std_logic_vector(31 downto 0);
signal MAC_data_reg : std_logic_vector(7 downto 0);
signal E_TXEN_reg   : std_logic;
signal E_TXD_reg    : std_logic_vector(7 downto 0);

begin
process(reset_n,E_TXC)
    begin
        if reset_n='0' then
            MAC_en_shift <= (others=>'0');
        elsif rising_edge( E_TXC ) then
            MAC_en_shift <= MAC_en_shift(10 downto 0) & MAC_en ;
        end if;
end process;
MAC_en_reg <= MAC_en_shift(7) and MAC_en;
Inst_CRC32_GMII : entity work.CRC32_GMII(rtl) 
    PORT MAP(
		E_TXC => E_TXC,
		reset_n => reset_n,
		MAC_data => MAC_data,
		MAC_en => MAC_en_reg,
		MAC_FCS => MAC_FCS
	);
process(reset_n,E_TXC)
    begin
        if reset_n='0' then
            MAC_data_reg <= (others=>'0');
        elsif rising_edge( E_TXC ) then
			MAC_data_reg <= MAC_data ;
        end if;
end process;
process(reset_n,E_TXC)
    begin
        if reset_n='0' then
            E_TXD_reg <= (others=>'0');
        elsif rising_edge( E_TXC ) then
            if MAC_en_shift(1)='1' and MAC_en_shift(0)='0' then
                E_TXD_reg <= MAC_FCS(31 downto 24);
            elsif MAC_en_shift(2)='1' and MAC_en_shift(1)='0' then
                E_TXD_reg <= MAC_FCS(23 downto 16);
            elsif MAC_en_shift(3)='1' and MAC_en_shift(2)='0' then
                E_TXD_reg <= MAC_FCS(15 downto 8);
            elsif MAC_en_shift(4)='1' and MAC_en_shift(3)='0' then
                E_TXD_reg <= MAC_FCS(7 downto 0);
            else
                E_TXD_reg <= MAC_data_reg ;
            end if;
        end if;
end process;
process(reset_n,E_TXC)
    begin
        if reset_n='0' then
            E_TXEN_reg <= '0';
        elsif rising_edge( E_TXC ) then
			E_TXEN_reg <= MAC_en_shift(0) or MAC_en_shift(4);
        end if;
end process; 
process(reset_n,E_TXC)
    begin
        if reset_n='0' then
            E_TXEN <= '0';
            E_TXD <= (others=>'0');
        elsif rising_edge( E_TXC ) then
            E_TXEN <= E_TXEN_reg ;
            E_TXD <= E_TXD_reg ;
        end if;
end process;
end rtl ;