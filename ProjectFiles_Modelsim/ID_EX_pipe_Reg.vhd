LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity ID_EX_Pipe_Reg is

	port(
		clk,reset				: in std_logic;
		enable					: in std_logic;
		Flush					: in std_logic;
		IN_WB_MemToReg			: in std_logic;
		IN_WB_RegWrite1			: in std_logic;
		IN_WB_RegWrite2			: in std_logic;
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
		IN_MemWrite		 		: in std_logic;
		IN_MemRead				: in std_logic;
		IN_Protect_Free 		: in std_logic;
		IN_PS_W_EN 				: in std_logic;
		IN_PC_Address			: in std_logic_vector(31 downto 0);
		IN_Rdst_Val				: in std_logic_vector(31 downto 0);
		IN_Push_Pop				: in std_logic;
		IN_SP_Enable			: in std_logic;
		IN_Pout					: in std_logic;
		IN_Inst_outRange		: in std_logic;
		IN_PC_Selector			: in std_logic;
		IN_Prediction			: in std_logic;
		IN_Cond_Branch_flag 	: in std_logic;
		IN_MeM_In_Adrs			: in std_logic_vector(1 downto 0);
		IN_MeM_Data				: in std_logic_vector(1 downto 0);
		IN_PC_Plus_One			: in std_logic_vector(31 downto 0);
		IN_Interrupt			: in std_logic;

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
		OUT_MemWrite		 	: out std_logic;
		OUT_MemRead				: out std_logic;
		OUT_Protect_Free 		: out std_logic;
		OUT_PS_W_EN 			: out std_logic;
		OUT_PC_Address			: out std_logic_vector(31 downto 0);
		OUT_Rdst_Val			: out std_logic_vector(31 downto 0);
		OUT_Push_Pop			: out std_logic;
		OUT_SP_Enable			: out std_logic;
		OUT_Pout				: out std_logic;
		OUT_Inst_outRange		: out std_logic;
		OUT_PC_Selector			: out std_logic;
		OUT_Prediction			: out std_logic;
		OUT_Cond_Branch_flag 	: out std_logic;
		OUT_MeM_In_Adrs			: out std_logic_vector(1 downto 0);
		OUT_MeM_Data			: out std_logic_vector(1 downto 0);
		OUT_PC_Plus_One			: out std_logic_vector(31 downto 0);
		OUT_Interrupt 			: out std_logic
	);

end entity;

Architecture Arch1 of ID_EX_Pipe_Reg is

begin

	process(clk,reset)
	
	begin

		if (reset = '1' or ( Flush = '1' and rising_edge(clk))) then
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
			OUT_MemWrite <= '0';
			OUT_MemRead <= '0';
			OUT_Protect_Free <= '0';
			OUT_PS_W_EN <= '0';
			OUT_PC_Address <= (others => '0');
			OUT_Rdst_Val <= (others => '0');
			OUT_Push_Pop <= '0';
			OUT_SP_Enable <= '0';
			OUT_Pout <= '0';
			OUT_Inst_outRange <= '0';
			OUT_PC_Selector <= '0';
			OUT_Prediction <= '0';
			OUT_Cond_Branch_flag <= '0';
			OUT_MeM_In_Adrs <= "00";
			OUT_MeM_Data <= "00";
			OUT_PC_Plus_One <= (others => '0');
			OUT_Interrupt <= '0';

		elsif rising_edge(clk) and enable = '1' then
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
			OUT_MemWrite <= IN_MemWrite;
			OUT_MemRead <= IN_MemRead;
			OUT_Protect_Free <= IN_Protect_Free;
			OUT_PS_W_EN <= IN_PS_W_EN;
			OUT_Rdst_Val <= IN_Rdst_Val;
			OUT_PC_Address <= IN_PC_Address;
			OUT_Push_Pop <= IN_Push_Pop;
			OUT_SP_Enable <= IN_SP_Enable;
			OUT_Pout <= IN_Pout;
			OUT_Inst_outRange <= IN_Inst_outRange;
			OUT_PC_Selector <= IN_PC_Selector;
			OUT_Prediction <= IN_Prediction;
			OUT_Cond_Branch_flag <= IN_Cond_Branch_flag;
			OUT_MeM_In_Adrs <= IN_MeM_In_Adrs;
			OUT_MeM_Data <= IN_MeM_Data;
			OUT_PC_Plus_One <= IN_PC_Plus_One;
			OUT_Interrupt <= IN_Interrupt;

		end if;

	end process;

end Arch1;