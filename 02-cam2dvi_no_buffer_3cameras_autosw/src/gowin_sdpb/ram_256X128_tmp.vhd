--Copyright (C)2014-2025 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--Tool Version: V1.9.12 (64-bit)
--Part Number: GW5AST-LV138FPG676AES
--Device: GW5AST-138
--Device Version: B
--Created Time: Sat Nov  1 23:43:07 2025

--Change the instance name and port connections to the signal names
----------Copy here to design--------

component ram_256x128
    port (
        dout: out std_logic_vector(255 downto 0);
        clka: in std_logic;
        cea: in std_logic;
        clkb: in std_logic;
        ceb: in std_logic;
        oce: in std_logic;
        reset: in std_logic;
        ada: in std_logic_vector(6 downto 0);
        din: in std_logic_vector(255 downto 0);
        adb: in std_logic_vector(6 downto 0)
    );
end component;

your_instance_name: ram_256x128
    port map (
        dout => dout,
        clka => clka,
        cea => cea,
        clkb => clkb,
        ceb => ceb,
        oce => oce,
        reset => reset,
        ada => ada,
        din => din,
        adb => adb
    );

----------Copy end-------------------
