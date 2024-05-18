LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity Pipeline_Integration is

	port(
		clk			 : in std_logic;
		reset	 	 : in std_logic;
		INPORT	 	 : in std_logic_vector(31 downto 0);
		OUTPORT		 : out std_logic_vector(31 downto 0);
		Exception_out: out std_logic
	);

end entity;

Architecture Pipeline_Integration_arch of Pipeline_Integration is

	component Program_Counter is

		port(
			PC_Prev_Val : in std_logic_vector(31 downto 0);
			enable		: in std_logic;
			reset		: in std_logic;
			clk			: in std_logic;
			PC			: out std_logic_vector(31 downto 0);
			PC_Plus_One : out std_logic_vector(31 downto 0)
		);

	end component;

	component PC_Circuit is

		Port (
        PC_New_Value		: in  std_logic_vector(31 downto 0);
        PC_From_EX			: in  std_logic_vector(31 downto 0);
        Rdst       			: in  std_logic_vector(31 downto 0);
		Rdst_From_EX     	: in  std_logic_vector(31 downto 0);
        Mem_Out       		: in  std_logic_vector(31 downto 0);
        unCond_or_Pred 		: in std_logic := '0';
        Should_Branch 		: in std_logic :='0';
        Should_Not_Branch 	: in std_logic := '0';
        PC_Selector_Mem 	: in std_logic :='0';
        Outp     			: out std_logic_vector(31 downto 0)
    	);

	end component;

	component Instruction_Memory is

		port(	
			ReadAddress	: in std_logic_vector(31 downto 0); --PC applied as an input.
			reset		: in std_logic;
			Read_Port	: out std_logic_vector(15 downto 0);
			outRange	: out std_logic
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
			clk,reset			: in std_logic;
			Flush				: in std_logic;
			IN_PC				: in std_logic_vector(31 downto 0);
			IN_Inst				: in std_logic_vector(15 downto 0);
			IN_INPORT			: in std_logic_vector(31 downto 0);
			IN_inst_outRange	: in std_logic;
			OUT_PC				: out std_logic_vector(31 downto 0);
			OUT_Inst			: out std_logic_vector(15 downto 0);
			OUT_INPORT			: out std_logic_vector(31 downto 0);
			OUT_inst_outRange	: out std_logic
		);
	
	end component;

	component my_DFF IS
		PORT( 	
			d,clk,rst	: IN std_logic;
			q			: OUT std_logic
		);
	END component;

	component my_DFF_reset0 IS
		PORT( 	
			d,clk,rst	: IN std_logic;
			enable	  	: IN std_logic;
			q : OUT std_logic
		);
	END component;

	component Controller is

		port(
			opcode 			: IN std_logic_vector(4 DOWNTO 0);
			IsInstIn		: IN std_logic;
			CCR_Write		: OUT std_logic_vector(3 DOWNTO 0); -- bit3 : OVF / bit2: CF / bit1 : NF / bit0 : ZF
			EX 				: OUT std_logic_vector(3 DOWNTO 0); -- bit3 : ALUOp / bit2 : RegDst / bit1 : ALUSrc1 / bit0 : ALUSrc2
			WB 				: OUT std_logic_vector(2 DOWNTO 0); -- bit2 : RegWrite1 / bit1 : RegWrite2 / bit0 : MemToReg
			M 				: OUT std_logic_vector(3 DOWNTO 0); -- bit3 : MemWrite / bit2 : MemRead / bit1 : Protect_Free / bit0 : PS_W_EN
			IsInstOut		: OUT std_logic;
			Cond_Branch 	: OUT std_logic;
			unCond_Branch	: OUT std_logic;
			PC_Selector 	: OUT std_logic;
			Push_Pop_Ctrl	: OUT std_logic_vector(1 downto 0); -- bit1 : Push/Pop / bit0 : SP_Enable
			Pout			: OUT std_logic;
			M_DataMeM		: OUT std_logic_vector(3 downto 0) -- bit3 and bit2 : MeM_In_Adrs / bit1 and bit0 : MeM_Data
			);
	
	end component;

	component Hazard_Detection_Unit is

		port(
			Cond_Branch : in std_logic;
			unCond_Branch : in std_logic;
			PC_Selector_From_Mem : in std_logic;
			Prediction : in std_logic;
			Cond_Branch_From_EX : in std_logic;
			Prev_Prediction : in std_logic;
			Zero_Flag : in std_logic;
			Should_Branch : out std_logic;
			Should_Not_Branch : out std_logic;
			unCond_or_Prediction : out std_logic;
			OUT_PC_Selector_From_Mem : out std_logic;
			IF_ID_Flush : out std_logic;
			ID_EX_Flush : out std_logic;
			EX_MEM_Flush : out std_logic;
			Enable_PC     : out std_logic;
			Zero_Flag_Reset     : out std_logic
    	);

	end component;

	component Register_File is

		port(	
			ReadAddress_1, ReadAddress_2	: in std_logic_vector(2 downto 0);
			WriteAddress_1, WriteAddress_2	: in std_logic_vector(2 downto 0);
			Write_Port1,Write_Port2			: in std_logic_vector(31 downto 0);	-- value to be written in the register
			W_enable_1,W_enable_2			: in std_logic;
			reset,clk_signal				: in std_logic;
			Read_Port1,Read_Port2			: out std_logic_vector(31 downto 0)
		);

	end component;

	component Branching_Decode is

		PORT( 
    		Rdst, IN_Rdst_EX_MEM_1 , IN_Rdst_EX_MEM_2 , Rdst_EX_MEM_OUT_1, Rdst_EX_MEM_OUT_2	: in std_logic_vector(2 downto 0);
    		RData , Res1 , Res2 , Res1_OUT_EX_MEM , Res2_OUT_EX_MEM 							: in std_logic_vector(31 downto 0);
    		RegWrite_1 , RegWrite_2 , OUT_EX_MEM_RegWrite_1 , OUT_EX_MEM_RegWrite_2 			: in std_logic;
    		Rdst_Val 																			: out std_logic_vector(31 downto 0) 
    	);

	end component;

	component Predictor is

		PORT(
			clk,rst 							: IN std_logic;
            Should_Branch , Shoud_Not_Branch	: IN std_logic;
			Decision 							: OUT std_logic
		);

	end component;

	component ID_EX_Pipe_Reg is

		port(
			clk,reset				: in std_logic;
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
			OUT_MeM_Data			: out std_logic_vector(1 downto 0)
		);
	
	end component;

	component ALU_Controller is 

		port(
			OPcode 			: in STD_LOGIC_VECTOR (4 DOWNTO 0);
			IN_EX_ALUOp 	: in std_logic;
			ALU_SEL 		: out std_logic_vector(4 downto 0)
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
			IN_EX_MEM_MemToReg	: in std_logic;
		
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
	
	end component;

	component SP_Circuit is

		port(
	
				Reset         : in std_logic;
				CLK           : in std_logic;
				SP_Enable     : in std_logic;
				Push_Pop      : in std_logic;
				SP            : out std_logic_vector(31 downto 0)
	
		);
	
	end component;

	component MEM_WB_Pipe_Reg is

		port(
			clk,reset			: in std_logic;
			IN_WB_MemToReg		: in std_logic;
			IN_WB_RegWrite1		: in std_logic;
			IN_WB_RegWrite2		: in std_logic;
			IN_MeM_Out			: in std_logic_vector(31 downto 0);
			IN_Res1				: in std_logic_vector(31 downto 0);
			IN_Res2				: in std_logic_vector(31 downto 0);
			IN_MUX_RegDst_Out	: in std_logic_vector(2 downto 0);
			IN_DST_10_8			: in std_logic_vector(2 downto 0);
			IN_Pout				: in std_logic;
			IN_Inst_outRange	: in std_logic;
			IN_OVFL				: in std_logic;
			IN_isProtected		: in std_logic;
			IN_Data_outRange	: in std_logic;

			OUT_WB_MemToReg		: out std_logic;
			OUT_WB_RegWrite1	: out std_logic;
			OUT_WB_RegWrite2	: out std_logic;
			OUT_MeM_Out			: out std_logic_vector(31 downto 0);	
			OUT_Res1			: out std_logic_vector(31 downto 0);
			OUT_Res2			: out std_logic_vector(31 downto 0);
			OUT_MUX_RegDst_Out	: out std_logic_vector(2 downto 0);
			OUT_DST_10_8		: out std_logic_vector(2 downto 0);
			OUT_Pout			: out std_logic;
			OUT_Inst_outRange	: out std_logic;
			OUT_OVFL			: out std_logic;
			OUT_isProtected		: out std_logic;
			OUT_Data_outRange	: out std_logic
	);

	end component;

	component ALU is
		generic (n : integer := 32);
		port(
			Cin			: in  std_logic;
			S			: in  std_logic_vector(3 DOWNTO 0);
			A,B			: in  std_logic_vector(n-1 DOWNTO 0);
			F1,F2		: out std_logic_vector(n-1 DOWNTO 0);
			Cout		: out std_logic;
			Flags		: out std_logic_vector(3 DOWNTO 0)
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

	component MUX_4X1_Generic is 
		generic (n : Integer := 32);

		port( 
			in0,in1,in2,in3 	: in std_logic_vector (n-1 DOWNTO 0);
			sel 				: in std_logic_vector (1 downto 0);
			out1 				: out std_logic_vector (n-1 DOWNTO 0)
		);

	end component;
	

	component MUX_8X1_Generic is 
		generic (n : Integer := 32);

		port( 
			in0,in1,in2,in3,in4,in5,in6,in7 	: in std_logic_vector (n-1 DOWNTO 0);
			sel 								: in std_logic_vector (2 downto 0);
			out1 								: out std_logic_vector (n-1 DOWNTO 0)
		);

	end component;

	component ProtectStatusRegister is
		port(
			RST,CLK	        : in std_logic;
			Write_enable	: in std_logic;
			Res1	        : in std_logic_vector(31 downto 0);
			Protect_Free	: in std_logic; -- 1: Protect, 0: Free
			isProtected		: out std_logic
		);
	end component;

	component Data_Memory is

		port(
			Rst,Clk         : in std_logic;
			Mem_Write   	: in std_logic;
			Address         : in std_logic_vector(31 downto 0);
			Data            : in std_logic_vector(31 downto 0);
			Mem_Read        : in std_logic;
			Push_Pop        : in std_logic;
			SP_Enable       : in std_logic;
			Mem_Out         : out std_logic_vector(31 downto 0);
			Mem_outRange    : out std_logic
		);
	
	end component;

	
	signal PC_Address 				: std_logic_vector(31 downto 0);
	signal PC_Plus_One 				: std_logic_vector(31 downto 0);
	signal IC_Instruction			: std_logic_vector(15 downto 0);
	signal IC_Inst_Extended			: std_logic_vector(31 downto 0);
	signal IC_Inst_OutRange			: std_logic;

	signal IF_ID_PC_Out				: std_logic_vector(31 downto 0);
	signal IF_ID_Inst_Out			: std_logic_vector(15 downto 0);
	signal IF_ID_INPORT_OUT			: std_logic_vector(31 downto 0);
	signal IF_ID_Inst_OutRange		: std_logic;

	--controller signals

	signal Cond_Branch				: std_logic := '0';
	signal unCond_Branch_from_ID	: std_logic := '0';
	signal PC_Selector_from_MEM		: std_logic := '0';
	signal IF_ID_Flush 				: std_logic := '0';
    signal ID_EX_Flush 				: std_logic := '0';
    signal EX_MEM_Flush 			: std_logic := '0';
	signal Enable_PC 				: std_logic := '1';

	
	signal unCond_or_Pred			: std_logic := '0';
	signal Should_Branch			: std_logic := '0';
	signal Should_Not_Branch		: std_logic := '0';
	signal PC_Selector_Mem			: std_logic := '0';
	signal PC_Selector				: std_logic := '0';
	signal Rdst_Val					: std_logic_vector(31 downto 0);
	signal Branch_Prediction		: std_logic;
	signal PC_Val					: std_logic_vector(31 downto 0) := (others => '0');
	signal OUT_HAZARD_PC_Selector_Mem			: std_logic := '0';
	signal Zero_Flag_Reset			: std_logic := '0';
	signal AUX_ZERO_Flag_Reset		: std_logic := '0';
	signal AUX_Enable_Flag 			: std_logic := '0';

	signal IsInstIn_Buff_Out		: std_logic;
	signal IsInstOut_Ctrl_Out		: std_logic;
	signal CCR_Write_Ctrl_Signal	: std_logic_vector(3 downto 0);
	signal EX_Ctrl_Signal			: std_logic_vector(3 downto 0);
	signal WB_Ctrl_Signal			: std_logic_vector(2 downto 0);
	signal M_Ctrl_Signal			: std_logic_vector(3 downto 0);
	signal P_P_Ctrl_Signal			: std_logic_vector(1 downto 0);
	signal Pout_Ctrl_Signal			: std_logic;
	signal M_DataMeM_Ctrl_Signal	: std_logic_vector(3 downto 0);
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
	signal ID_EX_MemWrite_Out		: std_logic;
	signal ID_EX_MemRead_Out		: std_logic;
	signal ID_EX_Protect_Free_Out	: std_logic;
	signal ID_EX_PS_W_EN_Out		: std_logic;
	signal ID_EX_PC_Out				: std_logic_vector(31 downto 0);
	signal ID_EX_Rdst_Val_OUT		: std_logic_vector(31 downto 0);
	signal ID_EX_Push_Pop_Out		: std_logic;
	signal ID_EX_SP_Enable_Out		: std_logic;
	signal ID_EX_Pout_Out			: std_logic;
	signal ID_EX_Inst_OutRange		: std_logic;
	signal ID_EX_PC_Selector_OUT	: std_logic;
	signal ID_EX_Prediction_OUT		: std_logic;
	signal ID_EX_Cond_Branch_OUT	: std_logic;
	signal ID_EX_MeM_In_Adrs_Out	: std_logic_vector(1 downto 0);
	signal ID_EX_MeM_Data_Out		: std_logic_vector(1 downto 0);

	signal ALU_Sel_Bits				: std_logic_vector(4 downto 0);
	signal Operand1,Operand2		: std_logic_vector(31 downto 0);		
	signal RegDst_MUX_Out			: std_logic_vector(2 downto 0);
	signal ALU_Res1					: std_logic_vector(31 downto 0);
	signal ALU_Res2					: std_logic_vector(31 downto 0);
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
	signal EX_MEM_MemWrite_Out		: std_logic;
	signal EX_MEM_MemRead_Out		: std_logic;
	signal EX_MEM_Protect_Free_Out	: std_logic;
	signal EX_MEM_PS_W_EN_Out		: std_logic;
	signal EX_MEM_Push_Pop_Out		: std_logic;
	signal EX_MEM_SP_Enable_Out		: std_logic;
	signal EX_MEM_Pout_Out			: std_logic;
	signal EX_MEM_Inst_OutRange		: std_logic;
	signal EX_MEM_OVFL				: std_logic;
	signal EX_MEM_PC_Selector_OUT	: std_logic;
	signal EX_MEM_MeM_In_Adrs_Out	: std_logic_vector(1 downto 0);
	signal EX_MEM_MeM_Data_Out		: std_logic_vector(1 downto 0);

	signal Stack_Pointer			: std_logic_vector(31 downto 0);
	signal Stack_Pointer_plus_2		: std_logic_vector(31 downto 0);

	signal MEM_WB_MemToReg_Out		: std_logic;
	signal MEM_WB_RegWrite1_Out		: std_logic;
	signal MEM_WB_RegWrite2_Out		: std_logic;
	signal MEM_WB_Res1_Out			: std_logic_vector(31 downto 0);
	signal MEM_WB_Res2_Out			: std_logic_vector(31 downto 0);
	signal MEM_WB_RegDst_Out		: std_logic_vector(2 downto 0);
	signal MEM_WB_MeM_Out_Out		: std_logic_vector(31 downto 0);
	signal MEM_WB_DST_10_8_Out		: std_logic_vector(2 downto 0);
	signal MEM_WB_Pout_Out			: std_logic;
	signal MEM_WB_Inst_OutRange		: std_logic;
	signal MEM_WB_OVFL				: std_logic;
	signal MEM_WB_isProtected		: std_logic;
	signal MEM_WB_Data_outRange		: std_logic;

	signal WB_Data_1				: std_logic_vector(31 downto 0);

	signal dummy_MeM_Out			: std_logic_vector(31 downto 0);
	signal dummy_ALU_Res2			: std_logic_vector(31 downto 0);
	signal dummy_32bits				: std_logic_vector(31 downto 0); -- It's used always to fill the 8X1 ALU operands MUX

	signal Prot_Reg_isProtected		: std_logic;
	signal MemWrite_Final			: std_logic;

	signal Memory_Data				: std_logic_vector(31 downto 0);
	signal Memory_Address			: std_logic_vector(31 downto 0);
	signal Memory_Out				: std_logic_vector(31 downto 0);
	signal Memory_Out_Range			: std_logic;

	signal dummy_Added_PC			: std_logic_vector(31 downto 0);
	
	
begin


PC					: Program_Counter port map				( PC_Val, Enable_PC , reset,clk,PC_Address , PC_Plus_One);

PC_Circuit_label 	: PC_Circuit port map					(PC_Address, ID_EX_PC_Out , Rdst_Val , ID_EX_Rdst_Val_OUT ,  
															dummy_MeM_Out , unCond_or_Pred , Should_Branch , Should_Not_Branch , 
															OUT_HAZARD_PC_Selector_Mem , PC_Val); --hazard detection unit and forward unit

Hazard_Det_Unit   	: Hazard_Detection_Unit port map 		(Cond_Branch , unCond_Branch_from_ID , EX_MEM_PC_Selector_OUT , Branch_Prediction,
														  	ID_EX_Cond_Branch_OUT , ID_EX_Prediction_OUT , CCR(0), Should_Branch,Should_Not_Branch, 
														  	unCond_or_Pred, OUT_HAZARD_PC_Selector_Mem, IF_ID_Flush , ID_EX_Flush , EX_MEM_Flush , 
														  	Enable_PC , Zero_Flag_Reset);

IC					: Instruction_Memory port map			(PC_Val,'0',IC_Instruction,IC_Inst_OutRange); -- PC_Val is replaced with PC_Address to test

Sign_Extend			: Sign_Extender port map				(IC_Instruction,IC_Inst_Extended);

IF_ID				: IF_ID_Pipe_Reg port map				(clk,reset,IF_ID_Flush,PC_Plus_One,IC_Instruction,INPORT,IC_Inst_OutRange,
															IF_ID_PC_Out,IF_ID_Inst_Out,IF_ID_INPORT_OUT,IF_ID_Inst_OutRange);

Branching_Unit 		: Branching_Decode port map				(IF_ID_Inst_Out(7 downto 5) , RegDst_MUX_Out , ID_EX_DST_10_8_Out , EX_MEM_RegDst_Out , 
															EX_MEM_DST_10_8_Out , OP2, ALU_Res1 , dummy_ALU_Res2 , EX_MEM_Res1_Out , EX_MEM_Res2_Out ,
															ID_EX_RegWrite1_Out ,ID_EX_RegWrite2_Out, EX_MEM_RegWrite1_Out,EX_MEM_RegWrite2_Out, Rdst_Val);

Pred 				: Predictor port map					(clk , reset , Should_Branch ,  Should_Not_Branch , Branch_Prediction); --output to hazard detection

Imm_Flag_Buffer		: my_DFF port map						(IsInstOut_Ctrl_Out,clk,reset,IsInstIn_Buff_Out);
	
ID_Controller 		: Controller port map					(IF_ID_Inst_Out(15 downto 11),IsInstIn_Buff_Out,CCR_Write_Ctrl_Signal,
															EX_Ctrl_Signal,WB_Ctrl_Signal,M_Ctrl_Signal,IsInstOut_Ctrl_Out , Cond_Branch , 
															unCond_Branch_from_ID , PC_Selector, P_P_Ctrl_Signal, Pout_Ctrl_Signal,M_DataMeM_Ctrl_Signal);

Reg_File			: Register_File port map				(IF_ID_Inst_Out(10 downto 8),IF_ID_Inst_Out(7 downto 5),MEM_WB_RegDst_Out,
															MEM_WB_DST_10_8_Out,WB_Data_1,MEM_WB_Res2_Out,MEM_WB_RegWrite1_Out,
															MEM_WB_RegWrite2_Out,reset,clk,Rdata1,Rdata2);

OP1_MUX				: MUX_2X1_Generic port map				(Rdata1,IF_ID_INPORT_OUT,EX_Ctrl_Signal(1),OP1);

OP2_MUX				: MUX_2X1_Generic port map				(Rdata2,IC_Inst_Extended,EX_Ctrl_Signal(0),OP2);

ID_EX				: ID_EX_Pipe_Reg port map				(clk,reset,ID_EX_Flush,WB_Ctrl_Signal(0),WB_Ctrl_Signal(2),WB_Ctrl_Signal(1),
															EX_Ctrl_Signal(3),EX_Ctrl_Signal(2),CCR_Write_Ctrl_Signal,
															OP1,OP2,IF_ID_Inst_Out(7 downto 5),IF_ID_Inst_Out(4 downto 2),IF_ID_Inst_Out(15 downto 11),
															IF_ID_Inst_Out(10 downto 8),Rdata1,M_Ctrl_Signal(3),M_Ctrl_Signal(2),M_Ctrl_Signal(1),M_Ctrl_Signal(0),IF_ID_PC_Out,Rdst_Val,
															P_P_Ctrl_Signal(1),P_P_Ctrl_Signal(0),Pout_Ctrl_Signal,IF_ID_Inst_OutRange,PC_Selector, Branch_Prediction, Cond_Branch,
															M_DataMeM_Ctrl_Signal(3 downto 2),M_DataMeM_Ctrl_Signal(1 downto 0),
															ID_EX_MemToReg_Out,ID_EX_RegWrite1_Out,ID_EX_RegWrite2_Out,
															ID_EX_ALUOp_Out,ID_EX_RegDst_Out,ID_EX_CCR_Write_Out,ID_EX_OP1_Out,ID_EX_OP2_Out,
															ID_EX_DST_7_5_Out,ID_EX_DST_4_2_Out,ID_EX_Opcode_Out,ID_EX_DST_10_8_Out,ID_EX_Rdata2_Prop_Out,ID_EX_MemWrite_Out,
															ID_EX_MemRead_Out,ID_EX_Protect_Free_Out,ID_EX_PS_W_EN_Out,ID_EX_PC_Out,ID_EX_Rdst_Val_OUT,
															ID_EX_Push_Pop_Out,ID_EX_SP_Enable_Out,ID_EX_Pout_Out,ID_EX_Inst_OutRange,
															ID_EX_PC_Selector_OUT , ID_EX_Prediction_OUT , ID_EX_Cond_Branch_OUT,
															ID_EX_MeM_In_Adrs_Out,ID_EX_MeM_Data_Out);

ALU_CTRL			: ALU_Controller port map				(ID_EX_Opcode_Out,ID_EX_ALUOp_Out,ALU_Sel_Bits);

FU					: Forwarding_Unit port map				(ID_EX_DST_10_8_Out,ID_EX_DST_7_5_Out,
															EX_MEM_RegWrite1_Out,EX_MEM_RegWrite2_Out,EX_MEM_RegDst_Out,EX_MEM_DST_10_8_Out,EX_MEM_MemToReg_Out,
															MEM_WB_RegWrite1_Out,MEM_WB_RegWrite2_Out,MEM_WB_RegDst_Out,MEM_WB_DST_10_8_Out,MEM_WB_MemToReg_Out,
															FSrc1,FSrc2);
	
Operand1_MUX		: MUX_8X1_Generic port map				(ID_EX_OP1_Out,EX_MEM_Res1_Out,EX_MEM_Res2_Out,MEM_WB_Res1_Out,MEM_WB_Res2_Out,
															MEM_WB_MeM_Out_Out,Memory_Out,dummy_32bits,FSrc1,Operand1);

Operand2_MUX		: MUX_8X1_Generic port map				(ID_EX_OP2_Out,EX_MEM_Res1_Out,EX_MEM_Res2_Out,MEM_WB_Res1_Out,MEM_WB_Res2_Out,
															MEM_WB_MeM_Out_Out,Memory_Out,dummy_32bits,FSrc2,Operand2);

DST_MUX				: MUX_2X1_Generic generic map(3) port map(ID_EX_DST_7_5_Out,ID_EX_DST_4_2_Out,ID_EX_RegDst_Out,RegDst_MUX_Out);

A_L_U				: ALU port map							(ALU_Sel_Bits(0),ALU_Sel_Bits(4 downto 1),Operand1,Operand2,ALU_Res1,ALU_Res2,ALU_Cout,ALU_Flags_Out);

	AUX_ZERO_Flag_Reset <=  ALU_Flags_Out(0) and (not Zero_Flag_Reset);
	AUX_Enable_Flag <= ID_EX_CCR_Write_Out(0) or Zero_Flag_Reset;

ZF_Flag_Buffer		: my_DFF_reset0 port map				(AUX_ZERO_Flag_Reset,clk,reset,AUX_Enable_Flag,CCR(0));

NF_Flag_Buffer		: my_DFF_reset0 port map				(ALU_Flags_Out(1),clk,reset,ID_EX_CCR_Write_Out(1),CCR(1));

CF_Flag_Buffer		: my_DFF_reset0 port map				(ALU_Flags_Out(2),clk,reset,ID_EX_CCR_Write_Out(2),CCR(2));

OVF_Flag_Buffer		: my_DFF_reset0 port map				(ALU_Flags_Out(3),clk,reset,ID_EX_CCR_Write_Out(3),CCR(3));

EX_MEM				: EX_MEM_Pipe_Reg port map				(clk,reset,EX_MEM_Flush,ID_EX_MemToReg_Out,ID_EX_RegWrite1_Out,
															ID_EX_RegWrite2_Out,ID_EX_Rdata2_Prop_Out,
															ALU_Res1,ALU_Res2,RegDst_MUX_Out,ID_EX_DST_10_8_Out,ID_EX_MemWrite_Out,ID_EX_MemRead_Out,ID_EX_Protect_Free_Out,
															ID_EX_PS_W_EN_Out,ID_EX_Push_Pop_Out,ID_EX_SP_Enable_Out,ID_EX_Pout_Out,ID_EX_Inst_OutRange,CCR(3),ID_EX_PC_Selector_OUT,
															ID_EX_MeM_In_Adrs_Out,ID_EX_MeM_Data_Out,
															EX_MEM_MemToReg_Out,EX_MEM_RegWrite1_Out,EX_MEM_RegWrite2_Out,
															EX_MEM_Rdata2_Prop_Out,EX_MEM_Res1_Out,EX_MEM_Res2_Out,EX_MEM_RegDst_Out,EX_MEM_DST_10_8_Out,
															EX_MEM_MemWrite_Out,EX_MEM_MemRead_Out,EX_MEM_Protect_Free_Out,EX_MEM_PS_W_EN_Out,EX_MEM_Push_Pop_Out,
															EX_MEM_SP_Enable_Out,EX_MEM_Pout_Out,EX_MEM_Inst_OutRange,EX_MEM_OVFL,EX_MEM_PC_Selector_OUT,
															EX_MEM_MeM_In_Adrs_Out,EX_MEM_MeM_Data_Out);

SP 					: SP_Circuit port map					(reset,clk,EX_MEM_SP_Enable_Out,EX_MEM_Push_Pop_Out,Stack_Pointer);

Memory_Data_MUX		: MUX_4X1_Generic port map				(EX_MEM_Rdata2_Prop_Out,EX_MEM_Res1_Out,dummy_Added_PC,x"00000000",
															EX_MEM_MeM_Data_Out,Memory_Data);

Stack_Pointer_plus_2 <= std_logic_vector(to_unsigned((to_integer(unsigned(Stack_Pointer)) + 2),32));

Memory_Address_MUX	: MUX_4X1_Generic port map				(Stack_Pointer,Stack_Pointer_plus_2,EX_MEM_Res2_Out,x"00000000",EX_MEM_MeM_In_Adrs_Out,
															Memory_Address);

Data_Mem			: Data_Memory port map					(Rst=>reset,Clk=>clk,Mem_Write=>EX_MEM_MemWrite_Out,
															Address=>Memory_Address,Data=>Memory_Data,Mem_Read=>EX_MEM_MemRead_Out,Push_Pop=>EX_MEM_Push_Pop_Out,
															SP_Enable=>EX_MEM_SP_Enable_Out,
															Mem_Out=>Memory_Out,Mem_outRange=>Memory_Out_Range);

PSR					: ProtectStatusRegister port map		(RST=>reset, CLK=>clk, Write_enable=>EX_MEM_PS_W_EN_Out, Res1=>ALU_Res1, 
															Protect_Free=>EX_MEM_Protect_Free_Out, isProtected=>Prot_Reg_isProtected);

MemWrite_Final <= not(Prot_Reg_isProtected) AND EX_MEM_MemWrite_Out;


MEM_WB				: MEM_WB_Pipe_Reg port map				(clk,reset,EX_MEM_MemToReg_Out,EX_MEM_RegWrite1_Out,EX_MEM_RegWrite2_Out,
															Memory_Out,EX_MEM_Res1_Out,EX_MEM_Res2_Out,EX_MEM_RegDst_Out,EX_MEM_DST_10_8_Out,EX_MEM_Pout_Out,EX_MEM_Inst_OutRange,EX_MEM_OVFL,Prot_Reg_isProtected,Memory_Out_Range,
															MEM_WB_MemToReg_Out,MEM_WB_RegWrite1_Out,MEM_WB_RegWrite2_Out,MEM_WB_MeM_Out_Out,
															MEM_WB_Res1_Out,MEM_WB_Res2_Out,MEM_WB_RegDst_Out,MEM_WB_DST_10_8_Out,MEM_WB_Pout_Out,MEM_WB_Inst_OutRange,MEM_WB_OVFL,MEM_WB_isProtected,MEM_WB_Data_outRange);

MeMToReg_MUX		: MUX_2X1_Generic port map				(MEM_WB_Res1_Out,MEM_WB_MeM_Out_Out,MEM_WB_MemToReg_Out,WB_Data_1);

OUT_MUX				: MUX_2X1_Generic port map				(x"00000000",MEM_WB_Res1_Out,MEM_WB_Pout_Out,OUTPORT);

	Exception_out <= CCR(3) or Prot_Reg_isProtected;

	 
end Pipeline_Integration_arch;