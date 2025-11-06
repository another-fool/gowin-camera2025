--Copyright (C)2014-2025 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--Tool Version: V1.9.12 (64-bit)
--Part Number: GW5AST-LV138FPG676AES
--Device: GW5AST-138
--Device Version: B
--Created Time: Sat Nov  1 17:22:57 2025

--Change the instance name and port connections to the signal names
----------Copy here to design--------

component fifo_16x8192_256x512
	port (
		Data: in std_logic_vector(15 downto 0);
		Reset: in std_logic;
		WrClk: in std_logic;
		RdClk: in std_logic;
		WrEn: in std_logic;
		RdEn: in std_logic;
		Rnum: out std_logic_vector(9 downto 0);
		Almost_Empty: out std_logic;
		Q: out std_logic_vector(255 downto 0);
		Empty: out std_logic;
		Full: out std_logic
	);
end component;

your_instance_name: fifo_16x8192_256x512
	port map (
		Data => Data,
		Reset => Reset,
		WrClk => WrClk,
		RdClk => RdClk,
		WrEn => WrEn,
		RdEn => RdEn,
		Rnum => Rnum,
		Almost_Empty => Almost_Empty,
		Q => Q,
		Empty => Empty,
		Full => Full
	);

----------Copy end-------------------
