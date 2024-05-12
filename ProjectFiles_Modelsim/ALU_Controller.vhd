LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity ALU_Controller is 

	port(
		OPcode 		: in STD_LOGIC_VECTOR (4 DOWNTO 0);
		IN_EX_ALUOp 	: in std_logic;
		ALU_SEL 	: out std_logic_vector(4 downto 0)
	);

end entity;

Architecture Arch1 of ALU_Controller is
 
begin

	--ALUOp is not used????????
	ALU_SEL <= "00000" WHEN OPcode = "00000" --F=0 NOP
	ELSE "01110" WHEN OPcode = "00001"  -- F=not A
	ELSE "00011" WHEN OPcode = "00010"  -- F=-A
	ELSE "00001" WHEN OPcode = "00011"  -- F=A+1
	ELSE "00110" WHEN OPcode = "00100"  -- F=A-1
	ELSE "00111" WHEN OPcode = "00101"  -- F=A(OUT A)
	ELSE "00111" WHEN OPcode = "00110"  -- F=A(IN A)
	ELSE "00111" WHEN OPcode = "00111"  -- F=A(MOV )
	ELSE "01000" WHEN OPcode = "01000"  -- F=A(SWAP) not handled yet
	ELSE "00100" WHEN OPcode = "01001"  -- F=A+B
	ELSE "00100" WHEN OPcode = "01010"  -- F=A+B
	ELSE "00010" WHEN OPcode = "01011"  -- F=A-B
	ELSE "00010" WHEN OPcode = "01100"  -- F=A-B
	ELSE "01010" WHEN OPcode = "01101"  -- F=A and B
	ELSE "01000" WHEN OPcode = "01110"  -- F=A or B
	ELSE "01100" WHEN OPcode = "01111"  -- F=A xor B --compare?
	ELSE "00010" WHEN OPcode = "10000"  -- CMP
	ELSE "00111" WHEN OPcode = "10001";  -- LDM

end Arch1;
