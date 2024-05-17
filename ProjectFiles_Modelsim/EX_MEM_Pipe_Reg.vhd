LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity EX_MEM_Pipe_Reg is

	port(
		clk,reset				: in std_logic;
		Flush					: in std_logic;
		IN_WB_MemToReg			: in std_logic;
		IN_WB_RegWrite1			: in std_logic;
		IN_WB_RegWrite2			: in std_logic;
		IN_Rdata2_Propagated	: in std_logic_vector(31 downto 0);
		IN_Res1					: in std_logic_vector(31 downto 0);
		IN_Res2					: in std_logic_vector(31 downto 0);
		IN_MUX_RegDst_Out		: in std_logic_vector(2 downto 0);
		IN_DST_10_8				: in std_logic_vector(2 downto 0);
		IN_MemWrite		 		: in std_logic;
		IN_MemRead				: in std_logic;
		IN_Protect_Free 		: in std_logic;
		IN_PS_W_EN 				: in std_logic;
		IN_Push_Pop				: in std_logic;
		IN_SP_Enable			: in std_logic;
		IN_Pout					: in std_logic;
		IN_Inst_outRange		: in std_logic;
		IN_OVFL					: in std_logic;
		IN_PC_Selector			: in std_logic;
		IN_MeM_In_Adrs			: in std_logic_vector(1 downto 0);
		IN_MeM_Data				: in std_logic_vector(1 downto 0);

		OUT_WB_MemToReg			: out std_logic;
		OUT_WB_RegWrite1		: out std_logic;
		OUT_WB_RegWrite2		: out std_logic;	
		OUT_Rdata2_Propagated	: out std_logic_vector(31 downto 0);
		OUT_Res1				: out std_logic_vector(31 downto 0);
		OUT_Res2				: out std_logic_vector(31 downto 0);
		OUT_MUX_RegDst_Out		: out std_logic_vector(2 downto 0);
		OUT_DST_10_8			: out std_logic_vector(2 downto 0);
		OUT_MemWrite		 	: out std_logic;
		OUT_MemRead				: out std_logic;
		OUT_Protect_Free 		: out std_logic;
		OUT_PS_W_EN 			: out std_logic;
		OUT_Push_Pop			: out std_logic;
		OUT_SP_Enable			: out std_logic;
		OUT_Pout				: out std_logic;
		OUT_Inst_outRange		: out std_logic;
		OUT_OVFL				: out std_logic;
		OUT_PC_Selector			: out std_logic;
		OUT_MeM_In_Adrs			: out std_logic_vector(1 downto 0);
		OUT_MeM_Data			: out std_logic_vector(1 downto 0)
	);

end entity;

Architecture Arch1 of EX_MEM_Pipe_Reg is

begin

	process(clk,reset)
	
	begin

		if (reset = '1' or ( Flush = '1' and rising_edge(clk))) then
			OUT_WB_MemToReg <= '0';
			OUT_WB_RegWrite1 <= '0';
			OUT_WB_RegWrite2 <= '0';
			OUT_Rdata2_Propagated <= (others => '0');
			OUT_Res1 <= (others => '0');
			OUT_Res2 <= (others => '0');
			OUT_MUX_RegDst_Out <= (others => '0');
			OUT_DST_10_8 <= (others => '0');
			OUT_MemWrite <= '0';
			OUT_MemRead <= '0';
			OUT_Protect_Free <= '0';
			OUT_PS_W_EN <= '0';
			OUT_Push_Pop <= '0';
			OUT_SP_Enable <= '0';
			OUT_Pout <= '0';
			OUT_Inst_outRange <= '0';
			OUT_OVFL <= '0';
			OUT_PC_Selector <= '0';
			OUT_MeM_In_Adrs <= "00";
			OUT_MeM_Data <= "00";
			
		elsif rising_edge(clk) then
			OUT_WB_MemToReg <= IN_WB_MemToReg;
			OUT_WB_RegWrite1 <= IN_WB_RegWrite1;
			OUT_WB_RegWrite2 <= IN_WB_RegWrite2;
			OUT_Rdata2_Propagated <= IN_Rdata2_Propagated;
			OUT_Res1 <= IN_Res1;
			OUT_Res2 <= IN_Res2;
			OUT_MUX_RegDst_Out <= IN_MUX_RegDst_Out;
			OUT_DST_10_8 <= IN_DST_10_8;
			OUT_MemWrite <= IN_MemWrite;
			OUT_MemRead <= IN_MemRead;
			OUT_Protect_Free <= IN_Protect_Free;
			OUT_PS_W_EN <= IN_PS_W_EN;
			OUT_Push_Pop <= IN_Push_Pop;
			OUT_SP_Enable <= IN_SP_Enable;
			OUT_Pout <= IN_Pout;
			OUT_Inst_outRange <= IN_Inst_outRange;
			OUT_OVFL <= IN_OVFL;
			OUT_PC_Selector <= IN_PC_Selector;
			OUT_MeM_In_Adrs <= IN_MeM_In_Adrs;
			OUT_MeM_Data <= IN_MeM_Data;
		end if;

	end process;

end Arch1;