LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity ID_EX_Pipe_Reg is

	port(
		clk,reset				: in std_logic;
		IN_WB_MemToReg			: in std_logic;
		IN_WB_RegWrite1			: in std_logic;
		IN_WB_RegWrite2			: in std_logic;
		-- There is missing control signals but these are only used for phase 1.
		-- ID_EX_M same as above
		-- same goes for the PC, IN
		-- same goes for Dst[10 - 8]
		IN_EX_ALUOp				: in std_logic;
		IN_EX_RegDst			: in std_logic;
		IN_EX_CCR_Write			: in std_logic_vector(3 downto 0);
		IN_OP1					: in std_logic_vector(31 downto 0);
		IN_OP2					: in std_logic_vector(31 downto 0);
		IN_DST_7_5				: in std_logic_vector(2 downto 0);
		IN_DST_4_2				: in std_logic_vector(2 downto 0);
		IN_OPcode				: in std_logic_vector(4 downto 0);
		IN_DST_10_8				: in std_logic_vector(2 downto 0);
		IN_Rdata2_Propagated	: in std_logic_vector(31 downto 0);
		IN_Protect_Free 		: in std_logic;
		IN_PS_W_EN 				: in std_logic;
		OUT_WB_MemToReg			: out std_logic;
		OUT_WB_RegWrite1		: out std_logic;
		OUT_WB_RegWrite2		: out std_logic;	
		OUT_EX_ALUOp			: out std_logic;
		OUT_EX_RegDst			: out std_logic;
		OUT_EX_CCR_Write		: out std_logic_vector(3 downto 0);
		OUT_OP1					: out std_logic_vector(31 downto 0);
		OUT_OP2					: out std_logic_vector(31 downto 0);
		OUT_DST_7_5				: out std_logic_vector(2 downto 0);
		OUT_DST_4_2				: out std_logic_vector(2 downto 0);
		OUT_OPcode				: out std_logic_vector(4 downto 0);
		OUT_DST_10_8			: out std_logic_vector(2 downto 0);
		OUT_Rdata2_Propagated	: out std_logic_vector(31 downto 0);
		OUT_Protect_Free 		: out std_logic;
		OUT_PS_W_EN 			: out std_logic	
	);

end entity;

Architecture Arch1 of ID_EX_Pipe_Reg is

begin

	process(clk,reset)
	
	begin

		if (reset = '1') then
			OUT_WB_MemToReg <= '0';		
			OUT_WB_RegWrite1 <= '0';	
			OUT_WB_RegWrite2 <= '0';
			OUT_EX_ALUOp <= '0';
			OUT_EX_RegDst <= '0';
			OUT_OP1 <= (others => '0');
			OUT_OP2 <= (others => '0');
			OUT_DST_7_5 <= (others => '0');		
			OUT_DST_4_2 <= (others => '0');		
			OUT_OPcode <= (others => '0');
			OUT_EX_CCR_Write <= (others => '0');
			OUT_DST_10_8 <= (others => '0');
			OUT_Rdata2_Propagated <= (others => '0');
			OUT_Protect_Free <= '0';
			OUT_PS_W_EN <= '0';
		elsif rising_edge(clk) then
			OUT_WB_MemToReg <= IN_WB_MemToReg;		
			OUT_WB_RegWrite1 <=IN_WB_RegWrite1;	
			OUT_WB_RegWrite2 <= IN_WB_RegWrite2;		
			OUT_EX_ALUOp <= IN_EX_ALUOp;		
			OUT_EX_RegDst <= IN_EX_RegDst;	
			OUT_OP1 <= IN_OP1;	
			OUT_OP2 <= IN_OP2;		
			OUT_DST_7_5 <= IN_DST_7_5;		
			OUT_DST_4_2 <= IN_DST_4_2;
			OUT_OPcode <= IN_OPcode;
			OUT_EX_CCR_Write <= IN_EX_CCR_Write;
			OUT_DST_10_8 <= IN_DST_10_8;
			OUT_Rdata2_Propagated <= IN_Rdata2_Propagated;
			OUT_Protect_Free <= IN_Protect_Free;
			OUT_PS_W_EN <= IN_PS_W_EN;
		end if;

	end process;

end Arch1;