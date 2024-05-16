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
	ALU_SEL <= "00000" WHEN OPcode = "00000"  -- F1=0		-- NOP
		  ELSE "01110" WHEN OPcode = "00001"  -- F1=not A	-- NOT
		  ELSE "00011" WHEN OPcode = "00010"  -- F1=-A		-- NEG
		  ELSE "00001" WHEN OPcode = "00011"  -- F1=A+1		-- INC
		  ELSE "00110" WHEN OPcode = "00100"  -- F1=A-1		-- DEC
		  ELSE "00111" WHEN OPcode = "00101"  -- F1=A		-- OUT
		  ELSE "00111" WHEN OPcode = "00110"  -- F1=A 		-- IN
		  ELSE "00111" WHEN OPcode = "00111"  -- F1=A		-- MOV
		  ELSE "00111" WHEN OPcode = "01000"  -- F1=A F2=B	-- SWAP
		  ELSE "00100" WHEN OPcode = "01001"  -- F1=A+B		-- ADD
		  ELSE "00100" WHEN OPcode = "01010"  -- F1=A+B		-- ADDI
		  ELSE "00010" WHEN OPcode = "01011"  -- F1=A-B		-- SUB
		  ELSE "00010" WHEN OPcode = "01100"  -- F1=A-B		-- SUBI
		  ELSE "01010" WHEN OPcode = "01101"  -- F1=A and B	-- AND
		  ELSE "01000" WHEN OPcode = "01110"  -- F1=A or  B	-- OR
		  ELSE "01100" WHEN OPcode = "01111"  -- F1=A xor B	-- XOR
		  ELSE "00010" WHEN OPcode = "10000"  -- F1=A-B		-- CMP
		  ELSE "00101" WHEN OPcode = "10001"  -- F1=B		-- LDM
		  ELSE "00111" WHEN OPcode = "10010"  -- F1=A		-- PUSH
		  ELSE "00000" WHEN OPcode = "10011"  -- F1=0		-- POP
		  ELSE "00100" WHEN OPcode = "10100"  -- F2=A+B		-- LDD
		  ELSE "00100" WHEN OPcode = "10101"  -- F2=A+B		-- STD
		  ELSE "00111" WHEN OPcode = "10110"  -- F1=A		-- PROTECT
		  ELSE "00111" WHEN OPcode = "10111"  -- F1=A		-- FREE
		  ELSE "00000";

end Arch1;
