LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity Controller is

	port(
        opcode 		: IN std_logic_vector(4 DOWNTO 0);
		IsInstIn	: IN std_logic;
		CCR_Write	: OUT std_logic_vector(3 DOWNTO 0); -- bit3 : OVF / bit2: CF / bit1 : NF / bit0 : ZF
		EX 			: OUT std_logic_vector(3 DOWNTO 0); -- bit3 : ALUOp / bit2 : RegDst / bit1 : ALUSrc1 / bit0 : ALUSrc2
		WB 			: OUT std_logic_vector(2 DOWNTO 0); -- bit2 : RegWrite1 / bit1 : RegWrite2/ bit0 : MemToReg
		M 			: OUT std_logic_vector(1 DOWNTO 0); -- bit1 : Protect/Free / bit0 : PS_W_EN   
		IsInstOut	: OUT std_logic
    	);

end entity;

Architecture Arch1 of Controller is
	
begin
	-- IsInstOut is an indicator that the next fetched Instruction is an immediate value
	-- it takes a 1 clk cycle delay to be an input to the next decode stage where 0 CTRL signals is produced 
	IsInstOut<= '0' WHEN opcode = "10001" --LDM
	ELSE '1';

	EX <= "0000" WHEN IsInstIn = '0'
	ELSE  "0000" WHEN opcode = "00000"
	ELSE  "1000" WHEN opcode = "00001"
	ELSE  "1000" WHEN opcode = "00010"
	ELSE  "1000" WHEN opcode = "00011"
	ELSE  "1000" WHEN opcode = "00100"
	ELSE  "1000" WHEN opcode = "00101"
	ELSE  "1010" WHEN opcode = "00110"
	ELSE  "1100" WHEN opcode = "00111"
	ELSE  "1000" WHEN opcode = "01000"
	ELSE  "1100" WHEN opcode = "01001"
	ELSE  "1000" WHEN opcode = "01010" -- ADDI not handled yet
	ELSE  "1100" WHEN opcode = "01011"
	ELSE  "1000" WHEN opcode = "01100" -- SUBI not handled yet
	ELSE  "1100" WHEN opcode = "01101"
	ELSE  "1100" WHEN opcode = "01110"
	ELSE  "1100" WHEN opcode = "01111"
	ELSE  "1000" WHEN opcode = "10000"
	ELSE  "0000";

	WB <= "000" WHEN IsInstIN = '0'
	ELSE  "000" WHEN opcode = "00000"
	ELSE  "100" WHEN opcode = "00001"
	ELSE  "100" WHEN opcode = "00010"
	ELSE  "100" WHEN opcode = "00011"
	ELSE  "100" WHEN opcode = "00100"
	ELSE  "000" WHEN opcode = "00101"
	ELSE  "000" WHEN opcode = "00110"
	ELSE  "100" WHEN opcode = "00111"
	ELSE  "110" WHEN opcode = "01000"
	ELSE  "100" WHEN opcode = "01001"
	ELSE  "100" WHEN opcode = "01010" -- ADDI not handled yet
	ELSE  "100" WHEN opcode = "01011"
	ELSE  "100" WHEN opcode = "01100" -- SUBI not handled yet
	ELSE  "100" WHEN opcode = "01101"
	ELSE  "100" WHEN opcode = "01110"
	ELSE  "100" WHEN opcode = "01111"
	ELSE  "000";

	--OVF CF NF ZF
	CCR_Write <= "0000" WHEN opcode = "00000"
	ELSE         "0011" WHEN opcode = "00001"
	ELSE         "0011" WHEN opcode = "00010"
	ELSE         "0011" WHEN opcode = "00011"
	ELSE         "0011" WHEN opcode = "00100"
	ELSE         "0000" WHEN opcode = "00101"
	ELSE         "0000" WHEN opcode = "00110"
	ELSE         "0000" WHEN opcode = "00111"
	ELSE         "0000" WHEN opcode = "01000"
	ELSE         "1111" WHEN opcode = "01001"
	ELSE         "1111" WHEN opcode = "01010"
	ELSE         "1111" WHEN opcode = "01011"
	ELSE         "1111" WHEN opcode = "01100"
	ELSE         "0011" WHEN opcode = "01101"
	ELSE         "0011" WHEN opcode = "01110"
	ELSE         "0011" WHEN opcode = "01111"
	ELSE         "0011" WHEN opcode = "10000"
	ELSE	     "0000";


	M <= "11" WHEN opcode = "10110"
	ELSE "01" WHEN opcode = "10111"
	ELSE "00";
   
end Arch1;
