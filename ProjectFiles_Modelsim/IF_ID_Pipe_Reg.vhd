LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity IF_ID_Pipe_Reg is

	port(
		clk,reset		: in std_logic;
		IN_PC			: in std_logic_vector(31 downto 0);
		IN_Inst			: in std_logic_vector(15 downto 0);
		IN_INPORT		: in std_logic_vector(31 downto 0);
		OUT_PC			: out std_logic_vector(31 downto 0);
		OUT_Inst		: out std_logic_vector(15 downto 0);
		OUT_INPORT		: out std_logic_vector(31 downto 0)
	);

end entity;

Architecture Arch1 of IF_ID_Pipe_Reg is

begin

	process(clk,reset)
	
	begin

		if (reset = '1') then
			OUT_PC <= (others => '0');
			OUT_Inst <= (others => '0');
			OUT_INPORT <= (others => '0');
		elsif rising_edge(clk) then
			OUT_PC <= IN_PC;
			OUT_Inst <= IN_Inst;
			OUT_INPORT <= IN_INPORT;
		end if;

	end process;

end Arch1;