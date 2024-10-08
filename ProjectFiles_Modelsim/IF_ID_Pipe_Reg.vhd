LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity IF_ID_Pipe_Reg is

	port(
		clk,reset			: in std_logic;
		enable				: in std_logic;
		Flush				: in std_logic;
		IN_Interrupt		: in std_logic;
		IN_PC				: in std_logic_vector(31 downto 0);
		IN_PC_Plus_one		: in std_logic_vector(31 downto 0);
		IN_Inst				: in std_logic_vector(15 downto 0);
		IN_INPORT			: in std_logic_vector(31 downto 0);
		IN_inst_outRange	: in std_logic;
		OUT_Interrutpt		: out std_logic;
		OUT_PC				: out std_logic_vector(31 downto 0);
		OUT_PC_Plus_One		: out std_logic_vector(31 downto 0);
		OUT_Inst			: out std_logic_vector(15 downto 0);
		OUT_INPORT			: out std_logic_vector(31 downto 0);
		OUT_inst_outRange	: out std_logic
	);

end entity;

Architecture Arch1 of IF_ID_Pipe_Reg is

begin

	process(clk,reset)
	
	begin

		if (reset = '1' or ( Flush = '1' and rising_edge(clk))) then
			OUT_PC <= (others => '0');
			OUT_Inst <= (others => '0');
			OUT_INPORT <= (others => '0');
			OUT_inst_outRange <= '0';
			OUT_PC_Plus_One <= (others => '0');
			OUT_Interrutpt <= '0';
		elsif (rising_edge(clk) and enable = '1')then
			OUT_PC <= IN_PC;
			OUT_Interrutpt <= IN_Interrupt;
			OUT_PC_Plus_One <= IN_PC_Plus_one;
			OUT_Inst <= IN_Inst;
			OUT_INPORT <= IN_INPORT;
			OUT_inst_outRange <= IN_inst_outRange;
		end if;

	end process;

end Arch1;