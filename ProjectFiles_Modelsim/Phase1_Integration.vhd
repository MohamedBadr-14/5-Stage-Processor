LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity Phase1_Integration is

	port(
		clk		: in std_logic;
		reset	: in std_logic;
		INPORT	: in std_logic_vector(31 downto 0);
		OUTPORT	: out std_logic_vector(31 downto 0)
	);

end entity;

Architecture Arch1 of Phase1_Integration is

	component Program_Counter is

		port(
			enable		: in std_logic;
			reset		: in std_logic;
			clk			: in std_logic;
			PC			: out std_logic_vector(31 downto 0)
		);

	end component;

	component Instruction_Memory is

		port(	
			ReadAddress	: in std_logic_vector(31 downto 0); --PC applied as an input.
			reset		: in std_logic;
			Read_Port	: out std_logic_vector(15 downto 0)
		);

	end component;

	component Sign_Extender is

		port(

			input_bits	: in std_logic_vector(15 downto 0);
			output_bits	: out std_logic_vector(31 downto 0)

		);

	end component;

	component IF_ID_Pipe_Reg is

		port(
			clk,reset		: in std_logic;
			IN_PC			: in std_logic_vector(31 downto 0);
			IN_Inst			: in std_logic_vector(15 downto 0);
			IN_INPORT		: in std_logic_vector(31 downto 0);
			OUT_PC			: out std_logic_vector(31 downto 0);
			OUT_Inst		: out std_logic_vector(15 downto 0);
			OUT_INPORT		: out std_logic_vector(31 downto 0)
		);

	end component;

	component my_DFF IS
		PORT( 	d,clk,rst : IN std_logic;
			q : OUT std_logic);
	END component;

	component my_DFF_reset0 IS
		PORT( 	d,clk,rst : IN std_logic;
			enable	  : IN std_logic;
			q : OUT std_logic);
	END component;

	component Controller is

		port(
        		opcode 		: IN std_logic_vector(4 DOWNTO 0);
			IsInstIn	: IN std_logic;
			CCR_Write	: OUT std_logic_vector(3 DOWNTO 0); -- bit3 : OVF / bit2: CF / bit1 : NF / bit0 : ZF
			EX 		: OUT std_logic_vector(3 DOWNTO 0); -- bit3 : ALUOp / bit2 : RegDst / bit1 : ALUSrc1 / bit0 : ALUSrc2
			WB 		: OUT std_logic_vector(2 DOWNTO 0); -- bit2 : RegWrite1 / bit1 : RegWrite2/ bit0 : MemToReg     
			IsInstOut	: OUT std_logic
    		);

	end component;

	component Register_File is

		port(	
			ReadAddress_1, ReadAddress_2	: in std_logic_vector(2 downto 0);
			WriteAddress_1, WriteAddress_2	: in std_logic_vector(2 downto 0);
			Write_Port1,Write_Port2		: in std_logic_vector(31 downto 0);	-- value to be written in the register
			W_enable_1,W_enable_2		: in std_logic;
			reset,clk_signal		: in std_logic;
			Read_Port1,Read_Port2		: out std_logic_vector(31 downto 0)
		);

	end component;

	component ID_EX_Pipe_Reg is

		port(
			clk,reset		: in std_logic;
			IN_WB_MemToReg		: in std_logic;
			IN_WB_RegWrite1		: in std_logic;
			IN_WB_RegWrite2		: in std_logic;
			IN_EX_ALUOp		: in std_logic;
			IN_EX_RegDst		: in std_logic;
			IN_EX_CCR_Write		: in std_logic_vector(3 downto 0);
			IN_OP1			: in std_logic_vector(31 downto 0);
			IN_OP2			: in std_logic_vector(31 downto 0);
			IN_DST_7_5		: in std_logic_vector(2 downto 0);
			IN_DST_4_2		: in std_logic_vector(2 downto 0);
			IN_OPcode		: in std_logic_vector(4 downto 0);
			IN_DST_10_8		: in std_logic_vector(2 downto 0);
			IN_Rdata2_Propagated	: in std_logic_vector(31 downto 0);
			OUT_WB_MemToReg		: out std_logic;
			OUT_WB_RegWrite1	: out std_logic;
			OUT_WB_RegWrite2	: out std_logic;	
			OUT_EX_ALUOp		: out std_logic;
			OUT_EX_RegDst		: out std_logic;
			OUT_EX_CCR_Write	: out std_logic_vector(3 downto 0);
			OUT_OP1			: out std_logic_vector(31 downto 0);
			OUT_OP2			: out std_logic_vector(31 downto 0);
			OUT_DST_7_5		: out std_logic_vector(2 downto 0);
			OUT_DST_4_2		: out std_logic_vector(2 downto 0);
			OUT_OPcode		: out std_logic_vector(4 downto 0);
			OUT_DST_10_8		: out std_logic_vector(2 downto 0);
			OUT_Rdata2_Propagated	: out std_logic_vector(31 downto 0)
	);

	end component;

	component ALU_Controller is 

		port(
			OPcode 		: in STD_LOGIC_VECTOR (4 DOWNTO 0);
			IN_EX_ALUOp 	: in std_logic;
			ALU_SEL 	: out std_logic_vector(4 downto 0)
		);

	end component;

	component Forwarding_Unit is

		port(
		
			IN_ID_EX_Src1		: in std_logic_vector(2 downto 0);
			IN_ID_EX_Src2		: in std_logic_vector(2 downto 0);	

			IN_EX_MEM_RegWrite1	: in std_logic;
			IN_EX_MEM_RegWrite2	: in std_logic;
			IN_EX_MEM_RegDst	: in std_logic_vector(2 downto 0);
			IN_EX_MEM_Src_10_8	: in std_logic_vector(2 downto 0);
	
			IN_MEM_WB_RegWrite1	: in std_logic;
			IN_MEM_WB_RegWrite2	: in std_logic;
			IN_MEM_WB_RegDst	: in std_logic_vector(2 downto 0);
			IN_MEM_WB_Src_10_8	: in std_logic_vector(2 downto 0);
			IN_MEM_WB_MemToReg	: in std_logic;

			ForwardSrc1		: out std_logic_vector(2 downto 0);
			ForwardSrc2		: out std_logic_vector(2 downto 0)
		
			
		);

	end component;

	component EX_MEM_Pipe_Reg is

		port(
			clk,reset		: in std_logic;
			IN_WB_MemToReg		: in std_logic;
			IN_WB_RegWrite1		: in std_logic;
			IN_WB_RegWrite2		: in std_logic;
			IN_Rdata2_Propagated	: in std_logic_vector(31 downto 0);
			IN_Res1			: in std_logic_vector(31 downto 0);
			IN_Res2			: in std_logic_vector(31 downto 0);
			IN_MUX_RegDst_Out	: in std_logic_vector(2 downto 0);
			IN_DST_10_8		: in std_logic_vector(2 downto 0);

			OUT_WB_MemToReg		: out std_logic;
			OUT_WB_RegWrite1	: out std_logic;
			OUT_WB_RegWrite2	: out std_logic;	
			OUT_Rdata2_Propagated	: out std_logic_vector(31 downto 0);
			OUT_Res1		: out std_logic_vector(31 downto 0);
			OUT_Res2		: out std_logic_vector(31 downto 0);
			OUT_MUX_RegDst_Out	: out std_logic_vector(2 downto 0);
			OUT_DST_10_8		: out std_logic_vector(2 downto 0)
		);

	end component;

	component MEM_WB_Pipe_Reg is

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

	end component;

	component ALU is
		generic (n : integer := 32);
		port(
			Cin			: in  std_logic;
			S			: in  std_logic_vector(3 DOWNTO 0);
			A,B			: in  std_logic_vector(n-1 DOWNTO 0);
			F			: out std_logic_vector(n-1 DOWNTO 0);
			Cout			: out std_logic;
			Flags			: out std_logic_vector(3 DOWNTO 0)
		);

	end component;

	component MUX_2X1_Generic is 
		generic (n : Integer := 32);

		port( 
			in0,in1 		: in std_logic_vector (n-1 DOWNTO 0);
			sel 			: in  std_logic;
			out1 			: out std_logic_vector (n-1 DOWNTO 0)
		);

	end component;

	component MUX_2X1 is 

		port( 
			in0,in1 	: in std_logic;
			sel 		: in  std_logic;
			out1 		: out std_logic
		);

	end component;

	component MUX_8X1_Generic is 
		generic (n : Integer := 32);

		port( 
			in0,in1,in2,in3,in4,in5,in6,in7 	: in std_logic_vector (n-1 DOWNTO 0);
			sel 					: in std_logic_vector (2 downto 0);
			out1 					: out std_logic_vector (n-1 DOWNTO 0)
		);

	end component;

	
	signal PC_Address 				: std_logic_vector(31 downto 0);
	signal IC_Instruction			: std_logic_vector(15 downto 0);
	signal IC_Inst_Extended			: std_logic_vector(31 downto 0);

	signal IF_ID_PC_Out				: std_logic_vector(31 downto 0);
	signal IF_ID_Inst_Out			: std_logic_vector(15 downto 0);
	signal IF_ID_INPORT_OUT			: std_logic_vector(31 downto 0);

	signal IsInstIn_Buff_Out		: std_logic;
	signal IsInstOut_Ctrl_Out		: std_logic;
	signal CCR_Write_Ctrl_Signal	: std_logic_vector(3 downto 0);
	signal EX_Ctrl_Signal			: std_logic_vector(3 downto 0);
	signal WB_Ctrl_Signal			: std_logic_vector(2 downto 0);
	signal Rdata1,Rdata2			: std_logic_vector(31 downto 0);
	signal OP1,OP2					: std_logic_vector(31 downto 0);

	signal ID_EX_MemToReg_Out		: std_logic;
	signal ID_EX_RegWrite1_Out		: std_logic;
	signal ID_EX_RegWrite2_Out		: std_logic;
	signal ID_EX_ALUOp_Out			: std_logic;
	signal ID_EX_RegDst_Out			: std_logic;
	signal ID_EX_CCR_Write_Out		: std_logic_vector(3 downto 0);
	signal ID_EX_OP1_Out			: std_logic_vector(31 downto 0);
	signal ID_EX_OP2_Out			: std_logic_vector(31 downto 0);
	signal ID_EX_Rdata1_Out			: std_logic_vector(31 downto 0);
	signal ID_EX_Rdata2_Out			: std_logic_vector(31 downto 0);
	signal ID_EX_DST_7_5_Out		: std_logic_vector(2 downto 0);
	signal ID_EX_DST_4_2_Out		: std_logic_vector(2 downto 0);
	signal ID_EX_Opcode_Out			: std_logic_vector(4 downto 0);
	signal ID_EX_Inst_Extended_Out	: std_logic_vector(31 downto 0);
	signal ID_EX_DST_10_8_Out		: std_logic_vector(2 downto 0);
	signal ID_EX_Rdata2_Prop_Out	: std_logic_vector(31 downto 0);

	signal ALU_Sel_Bits				: std_logic_vector(4 downto 0);
	signal Operand1,Operand2		: std_logic_vector(31 downto 0);		
	signal RegDst_MUX_Out			: std_logic_vector(2 downto 0);
	signal ALU_Res1					: std_logic_vector(31 downto 0);
	signal ALU_Cout					: std_logic;
	signal ALU_Flags_Out			: std_logic_vector(3 downto 0);
	signal CCR						: std_logic_vector(3 downto 0); 

	signal FSrc1,FSrc2				: std_logic_vector(2 downto 0);

	signal EX_MEM_MemToReg_Out		: std_logic;
	signal EX_MEM_RegWrite1_Out		: std_logic;
	signal EX_MEM_RegWrite2_Out		: std_logic;
	signal EX_MEM_Rdata2_Prop_Out	: std_logic_vector(31 downto 0);
	signal EX_MEM_Res1_Out			: std_logic_vector(31 downto 0);
	signal EX_MEM_Res2_Out			: std_logic_vector(31 downto 0);
	signal EX_MEM_RegDst_Out		: std_logic_vector(2 downto 0);
	signal EX_MEM_DST_10_8_Out		: std_logic_vector(2 downto 0);

	signal MEM_WB_MemToReg_Out		: std_logic;
	signal MEM_WB_RegWrite1_Out		: std_logic;
	signal MEM_WB_RegWrite2_Out		: std_logic;
	signal MEM_WB_Res1_Out			: std_logic_vector(31 downto 0);
	signal MEM_WB_Res2_Out			: std_logic_vector(31 downto 0);
	signal MEM_WB_RegDst_Out		: std_logic_vector(2 downto 0);
	signal MEM_WB_MeM_Out_Out		: std_logic_vector(31 downto 0);
	signal MEM_WB_DST_10_8_Out		: std_logic_vector(2 downto 0);

	signal dummy_MeM_Out			: std_logic_vector(31 downto 0);
	signal dummy_ALU_Res2			: std_logic_vector(31 downto 0);
	signal dummy_32bits				: std_logic_vector(31 downto 0); -- It's used always to fill the 8X1 ALU operands MUX
	
	
begin


	PC		: Program_Counter port map('1',reset,clk,PC_Address);

	IC		: Instruction_Memory port map(PC_Address,'0',IC_Instruction);

	Sign_Extend	: Sign_Extender port map(IC_Instruction,IC_Inst_Extended);

	IF_ID		: IF_ID_Pipe_Reg port map(clk,reset,PC_Address,IC_Instruction,INPORT,IF_ID_PC_Out,IF_ID_Inst_Out,IF_ID_INPORT_OUT);

	Imm_Flag_Buffer	: my_DFF port map(IsInstOut_Ctrl_Out,clk,reset,IsInstIn_Buff_Out);
	
	ID_Controller 	: Controller port map(IF_ID_Inst_Out(15 downto 11),IsInstIn_Buff_Out,CCR_Write_Ctrl_Signal,EX_Ctrl_Signal,WB_Ctrl_Signal,IsInstOut_Ctrl_Out);

	Reg_File	: Register_File port map(IF_ID_Inst_Out(10 downto 8),IF_ID_Inst_Out(7 downto 5),MEM_WB_RegDst_Out,MEM_WB_DST_10_8_Out,
						MEM_WB_Res1_Out,MEM_WB_Res2_Out,MEM_WB_RegWrite1_Out,MEM_WB_RegWrite2_Out,
						reset,clk,Rdata1,Rdata2);

	OP1_MUX		: MUX_2X1_Generic port map(Rdata1,IF_ID_INPORT_OUT,EX_Ctrl_Signal(1),OP1);

	OP2_MUX		: MUX_2X1_Generic port map(Rdata2,IC_Inst_Extended,EX_Ctrl_Signal(0),OP2);

	ID_EX		: ID_EX_Pipe_Reg port map(clk,reset,WB_Ctrl_Signal(0),WB_Ctrl_Signal(2),WB_Ctrl_Signal(1),
						EX_Ctrl_Signal(3),EX_Ctrl_Signal(2),CCR_Write_Ctrl_Signal,
						OP1,OP2,IF_ID_Inst_Out(7 downto 5),IF_ID_Inst_Out(4 downto 2),IF_ID_Inst_Out(15 downto 11),
						IF_ID_Inst_Out(10 downto 8),Rdata2,ID_EX_MemToReg_Out,ID_EX_RegWrite1_Out,ID_EX_RegWrite2_Out,
						ID_EX_ALUOp_Out,ID_EX_RegDst_Out,ID_EX_CCR_Write_Out,ID_EX_OP1_Out,ID_EX_OP2_Out,
						ID_EX_DST_7_5_Out,ID_EX_DST_4_2_Out,ID_EX_Opcode_Out,ID_EX_DST_10_8_Out,ID_EX_Rdata2_Prop_Out);

	ALU_CTRL	: ALU_Controller port map(ID_EX_Opcode_Out,ID_EX_ALUOp_Out,ALU_Sel_Bits);

	FU		: Forwarding_Unit port map(ID_EX_DST_10_8_Out,ID_EX_DST_7_5_Out,EX_MEM_RegWrite1_Out,EX_MEM_RegWrite2_Out,
						EX_MEM_RegDst_Out,EX_MEM_DST_10_8_Out,MEM_WB_RegWrite1_Out,MEM_WB_RegWrite2_Out,
						MEM_WB_RegDst_Out,MEM_WB_DST_10_8_Out,MEM_WB_MemToReg_Out,FSrc1,FSrc2);
	
	Operand1_MUX	: MUX_8X1_Generic port map(ID_EX_OP1_Out,EX_MEM_Res1_Out,EX_MEM_Res2_Out,MEM_WB_Res1_Out,MEM_WB_Res2_Out,
						MEM_WB_MeM_Out_Out,dummy_32bits,dummy_32bits,FSrc1,Operand1);

	Operand2_MUX	: MUX_8X1_Generic port map(ID_EX_OP2_Out,EX_MEM_Res1_Out,EX_MEM_Res2_Out,MEM_WB_Res1_Out,MEM_WB_Res2_Out,
						MEM_WB_MeM_Out_Out,dummy_32bits,dummy_32bits,FSrc2,Operand2);

	DST_MUX		: MUX_2X1_Generic generic map(3) port map(ID_EX_DST_7_5_Out,ID_EX_DST_4_2_Out,ID_EX_RegDst_Out,RegDst_MUX_Out);

	A_L_U		: ALU port map(ALU_Sel_Bits(0),ALU_Sel_Bits(4 downto 1),Operand1,Operand2,ALU_Res1,ALU_Cout,ALU_Flags_Out);

	ZF_Flag_Buffer	: my_DFF_reset0 port map(ALU_Flags_Out(0),clk,reset,ID_EX_CCR_Write_Out(0),CCR(0));

	NF_Flag_Buffer	: my_DFF_reset0 port map(ALU_Flags_Out(1),clk,reset,ID_EX_CCR_Write_Out(1),CCR(1));

	CF_Flag_Buffer	: my_DFF_reset0 port map(ALU_Flags_Out(2),clk,reset,ID_EX_CCR_Write_Out(2),CCR(2));

	OVF_Flag_Buffer	: my_DFF_reset0 port map(ALU_Flags_Out(3),clk,reset,ID_EX_CCR_Write_Out(3),CCR(3));

	EX_MEM		: EX_MEM_Pipe_Reg port map(clk,reset,ID_EX_MemToReg_Out,ID_EX_RegWrite1_Out,ID_EX_RegWrite2_Out,ID_EX_Rdata2_Prop_Out,
						ALU_Res1,dummy_ALU_Res2,RegDst_MUX_Out,ID_EX_DST_10_8_Out,EX_MEM_MemToReg_Out,EX_MEM_RegWrite1_Out,
						EX_MEM_RegWrite2_Out,EX_MEM_Rdata2_Prop_Out,EX_MEM_Res1_Out,EX_MEM_Res2_Out,EX_MEM_RegDst_Out,
						EX_MEM_DST_10_8_Out);

	MEM_WB		: MEM_WB_Pipe_Reg port map(clk,reset,EX_MEM_MemToReg_Out,EX_MEM_RegWrite1_Out,EX_MEM_RegWrite2_Out,
						EX_MEM_Res1_Out,EX_MEM_Res2_Out,EX_MEM_RegDst_Out,dummy_MeM_Out,EX_MEM_DST_10_8_Out,
						MEM_WB_MemToReg_Out,MEM_WB_RegWrite1_Out,MEM_WB_RegWrite2_Out,MEM_WB_Res1_Out,MEM_WB_Res2_Out,
						MEM_WB_RegDst_Out,MEM_WB_MeM_Out_Out,MEM_WB_DST_10_8_Out);
	
end Arch1;