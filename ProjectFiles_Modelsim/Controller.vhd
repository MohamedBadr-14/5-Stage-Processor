LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity Controller is

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

end entity;

Architecture Arch1 of Controller is
	
begin
	-- IsInstOut is an indicator that the next fetched Instruction is an immediate value
	-- it takes a 1 clk cycle delay to be an input to the next decode stage where 0 CTRL signals is produced 
	IsInstOut<= '0' WHEN opcode = "01010" -- ADDI
	ELSE 		'0' WHEN opcode = "01100" -- SUBI
	ELSE        '0' WHEN opcode = "10001" -- LDM
	ELSE        '0' WHEN opcode = "10100" -- LDD
	ELSE        '0' WHEN opcode = "10101" -- STD
	ELSE '1';

	Cond_Branch <= '1' When opcode = "11000"
	else '0';
	
	unCond_Branch <= '1' when (opcode = "11001" or opcode = "11010" or opcode = "11011" or opcode = "11100") 
	else '0';

	PC_Selector <= '1' when (opcode = "11011" or opcode = "11100")
	else '0';

	Pout <= '1' WHEN opcode = "00101"
	ELSE '0';

	-- bit3 : ALUOp / bit2 : RegDst / bit1 : ALUSrc1 / bit0 : ALUSrc2
	EX <= "0000" WHEN IsInstIn = '0'
	ELSE  "0000" WHEN opcode = "00000" -- NOP
	ELSE  "1100" WHEN opcode = "00001" -- NOT
	ELSE  "1100" WHEN opcode = "00010" -- NEG
	ELSE  "1100" WHEN opcode = "00011" -- INC
	ELSE  "1100" WHEN opcode = "00100" -- DEC
	ELSE  "1000" WHEN opcode = "00101" -- OUT
	ELSE  "1010" WHEN opcode = "00110" -- IN
	ELSE  "1100" WHEN opcode = "00111" -- MOV
	ELSE  "1000" WHEN opcode = "01000" -- SWAP
	ELSE  "1100" WHEN opcode = "01001" -- ADD
	ELSE  "1101" WHEN opcode = "01010" -- ADDI
	ELSE  "1100" WHEN opcode = "01011" -- SUB
	ELSE  "1101" WHEN opcode = "01100" -- SUBI
	ELSE  "1100" WHEN opcode = "01101" -- AND
	ELSE  "1100" WHEN opcode = "01110" -- OR
	ELSE  "1100" WHEN opcode = "01111" -- XOR
	ELSE  "1000" WHEN opcode = "10000" -- CMP
	ELSE  "1001" WHEN opcode = "10001" -- LDM
	ELSE  "1000" WHEN opcode = "10010" -- PUSH
	ELSE  "0000" WHEN opcode = "10011" -- POP
	ELSE  "1001" WHEN opcode = "10100" -- LDD
	ELSE  "1001" WHEN opcode = "10101" -- STD
	ELSE  "0000";

	-- bit2 : RegWrite1 / bit1 : RegWrite2 / bit0 : MemToReg
	WB <= "000" WHEN IsInstIN = '0'
	ELSE  "000" WHEN opcode = "00000" -- NOP
	ELSE  "100" WHEN opcode = "00001" -- NOT
	ELSE  "100" WHEN opcode = "00010" -- NEG
	ELSE  "100" WHEN opcode = "00011" -- INC
	ELSE  "100" WHEN opcode = "00100" -- DEC
	ELSE  "000" WHEN opcode = "00101" -- OUT
	ELSE  "100" WHEN opcode = "00110" -- IN
	ELSE  "100" WHEN opcode = "00111" -- MOV
	ELSE  "110" WHEN opcode = "01000" -- SWAP
	ELSE  "100" WHEN opcode = "01001" -- ADD
	ELSE  "100" WHEN opcode = "01010" -- ADDI
	ELSE  "100" WHEN opcode = "01011" -- SUB
	ELSE  "100" WHEN opcode = "01100" -- SUBI
	ELSE  "100" WHEN opcode = "01101" -- AND
	ELSE  "100" WHEN opcode = "01110" -- OR
	ELSE  "100" WHEN opcode = "01111" -- XOR
	ELSE  "000" WHEN opcode = "10000" -- CMP
	ELSE  "100" WHEN opcode = "10001" -- LDM
	ELSE  "000" WHEN opcode = "10010" -- PUSH
	ELSE  "101" WHEN opcode = "10011" -- POP
	ELSE  "101" WHEN opcode = "10100" -- LDD
	ELSE  "000" WHEN opcode = "10101" -- STD
	ELSE  "000";

	--OVF CF NF ZF
	CCR_Write <= "0000" WHEN opcode = "00000" -- NOP
	ELSE         "0011" WHEN opcode = "00001" -- NOT
	ELSE         "0011" WHEN opcode = "00010" -- NEG
	ELSE         "1111" WHEN opcode = "00011" -- INC
	ELSE         "1111" WHEN opcode = "00100" -- DEC
	ELSE         "0000" WHEN opcode = "00101" -- OUT
	ELSE         "0000" WHEN opcode = "00110" -- IN
	ELSE         "0000" WHEN opcode = "00111" -- MOV
	ELSE         "0000" WHEN opcode = "01000" -- SWAP
	ELSE         "1111" WHEN opcode = "01001" -- ADD
	ELSE         "1111" WHEN opcode = "01010" -- ADDI
	ELSE         "1111" WHEN opcode = "01011" -- SUB
	ELSE         "1111" WHEN opcode = "01100" -- SUBI
	ELSE         "0011" WHEN opcode = "01101" -- AND
	ELSE         "0011" WHEN opcode = "01110" -- OR
	ELSE         "0011" WHEN opcode = "01111" -- XOR
	ELSE         "0011" WHEN opcode = "10000" -- CMP
	ELSE	     "0000";

	-- bit3 : MemWrite / bit2 : MemRead / bit1 : Protect_Free / bit0 : PS_W_EN
	M <= "1000" WHEN opcode = "10010" -- Push
	ELSE "0100" WHEN opcode = "10011" -- Pop
	ELSE "0100" WHEN opcode = "10100" -- LDD
	ELSE "1000" WHEN opcode = "10101" -- STD
	ELSE "0011" WHEN opcode = "10110" -- Protect
	ELSE "1001" WHEN opcode = "10111" -- Free
	ELSE "0000";

	--bit3 and bit2 : MeM_In_Adrs / bit1 and bit0 : MeM_Data
	M_DataMeM <= "0001" WHEN opcode = "10010" -- Push
	ELSE 		 "0000" WHEN opcode = "10011" -- Pop
	ELSE 		 "1000" WHEN opcode = "10100" -- LDD
	ELSE 		 "1000" WHEN opcode = "10101" -- STD
	ELSE 		 "1111" WHEN opcode = "10110" -- Protect
	ELSE 		 "1111" WHEN opcode = "10111" -- Free
	ELSE 		 "1000";


	-- bit1 : Push/Pop / bit0 : SP_Enable
	Push_Pop_Ctrl <= "01" WHEN opcode = "10010" -- Push
	ELSE 			 "11" WHEN opcode = "10011" -- Pop
	ELSE 			 "01" WHEN opcode = "11010" -- Call
	ELSE 			 "11" WHEN opcode = "11011" -- RET
	ELSE       		 "11" WHEN opcode = "11100" -- RTI
	ELSE "00";
   
end Arch1;
