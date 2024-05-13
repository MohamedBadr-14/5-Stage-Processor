LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity MEM_WB_Pipe_Reg is

	port(
		clk,reset		: in std_logic;
		IN_WB_MemToReg		: in std_logic;
		IN_WB_RegWrite1		: in std_logic;
		IN_WB_RegWrite2		: in std_logic;
		--IN_WB_Pout		: in std_logic; Later to be implemented (rekhma 3ashan hazawed control signal hato3od te propagate fe kolo
		IN_Res1			: in std_logic_vector(31 downto 0);
		IN_Res2			: in std_logic_vector(31 downto 0);
		IN_MUX_RegDst_Out	: in std_logic_vector(2 downto 0);
		IN_MeM_Out		: in std_logic_vector(31 downto 0);
		IN_DST_10_8		: in std_logic_vector(2 downto 0);

		OUT_WB_MemToReg		: out std_logic;
		OUT_WB_RegWrite1	: out std_logic;
		OUT_WB_RegWrite2	: out std_logic;	
		OUT_Res1		: out std_logic_vector(31 downto 0);
		OUT_Res2		: out std_logic_vector(31 downto 0);
		OUT_MUX_RegDst_Out	: out std_logic_vector(2 downto 0);
		OUT_MeM_Out		: out std_logic_vector(31 downto 0);
		OUT_DST_10_8		: out std_logic_vector(2 downto 0)
	);

end entity;

Architecture Arch1 of MEM_WB_Pipe_Reg is

begin

	process(clk,reset)
	
	begin

		if (reset = '1') then
			OUT_WB_MemToReg <= '0';
			OUT_WB_RegWrite1 <= '0';
			OUT_WB_RegWrite2 <= '0';
			OUT_Res1 <= (others => '0');
			OUT_Res2 <= (others => '0');
			OUT_MUX_RegDst_Out <= (others => '0');
			OUT_MeM_Out <= (others => '0');
			OUT_DST_10_8 <= (others => '0');
		elsif rising_edge(clk) then
			OUT_WB_MemToReg <= IN_WB_MemToReg;
			OUT_WB_RegWrite1 <= IN_WB_RegWrite1;
			OUT_WB_RegWrite2 <= IN_WB_RegWrite2;
			OUT_Res1 <= IN_Res1;
			OUT_Res2 <= IN_Res2;
			OUT_MUX_RegDst_Out <= IN_MUX_RegDst_Out;
			OUT_MeM_Out <= IN_MeM_Out;
			OUT_DST_10_8 <= IN_DST_10_8;
		end if;

	end process;

end Arch1;