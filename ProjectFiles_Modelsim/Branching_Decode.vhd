LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Branching_Decode IS
	PORT( 
    Rdst, IN_Rdst_EX_MEM_1 , IN_Rdst_EX_MEM_2 , Rdst_EX_MEM_OUT_1, Rdst_EX_MEM_OUT_2 : in std_logic_vector(2 downto 0);
    RData , Res1 , Res2 , Res1_OUT_EX_MEM , Res2_OUT_EX_MEM : in std_logic_vector(31 downto 0);
    RegWrite_1 , RegWrite_2 , OUT_EX_MEM_RegWrite_1 , OUT_EX_MEM_RegWrite_2 : in std_logic;
    Rdst_Val : out std_logic_vector(31 downto 0) 
    );
END entity;

ARCHITECTURE behavior OF Branching_Decode IS
BEGIN
	Rdst_Val <= Res1 when (RegWrite_1 = '1' and Rdst = IN_Rdst_EX_MEM_1)
    else Res2 when (RegWrite_2 = '1' and Rdst = IN_Rdst_EX_MEM_2)
    Else Res1_OUT_EX_MEM When (OUT_EX_MEM_RegWrite_1 = '1' and Rdst = Rdst_EX_MEM_OUT_1)
    Else Res2_OUT_EX_MEM When (OUT_EX_MEM_RegWrite_2 = '1' and Rdst = Rdst_EX_MEM_OUT_2)
    Else RData;
END behavior;
