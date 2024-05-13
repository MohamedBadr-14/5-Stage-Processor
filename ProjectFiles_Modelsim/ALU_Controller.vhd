LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity ALU_Controller is 

	port(
		OPcode 		: in STD_LOGIC_VECTOR (4 DOWNTO 0);
		IN_EX_ALUOp : in std_logic;
		ALU_SEL 	: out std_logic_vector(4 downto 0)
	);

end entity;

Architecture Arch1 of ALU_Controller is
 
begin

	--ALUOp is not used
	ALU_SEL <= "00000" WHEN OPcode = "00000"  -- F=0		-- NOP
		  ELSE "01110" WHEN OPcode = "00001"  -- F=not A	-- NOT
		  ELSE "00011" WHEN OPcode = "00010"  -- F=-A		-- NEG
		  ELSE "00001" WHEN OPcode = "00011"  -- F=A+1		-- INC
		  ELSE "00110" WHEN OPcode = "00100"  -- F=A-1		-- DEC
		  ELSE "00111" WHEN OPcode = "00101"  -- F=A		-- OUT
		  ELSE "00111" WHEN OPcode = "00110"  -- F=A 		-- IN
		  ELSE "00111" WHEN OPcode = "00111"  -- F=A		-- MOV
		  ELSE "00111" WHEN OPcode = "01000"  -- F=A		-- SWAP (NOT CORRECTED)
		  ELSE "00100" WHEN OPcode = "01001"  -- F=A+B		-- ADD
		  ELSE "00100" WHEN OPcode = "01010"  -- F=A+B		-- ADDI
		  ELSE "00010" WHEN OPcode = "01011"  -- F=A-B		-- SUB
		  ELSE "00010" WHEN OPcode = "01100"  -- F=A-B		-- SUBI
		  ELSE "01010" WHEN OPcode = "01101"  -- F=A and B	-- AND
		  ELSE "01000" WHEN OPcode = "01110"  -- F=A or B	-- OR
		  ELSE "01100" WHEN OPcode = "01111"  -- F=A xor B 	-- XOR
		  ELSE "00010" WHEN OPcode = "10000"  -- F=A-B		-- CMP
		  ELSE "00101" WHEN OPcode = "10001"  -- F=B		-- LDM
		  ELSE "00000";

end Arch1;
