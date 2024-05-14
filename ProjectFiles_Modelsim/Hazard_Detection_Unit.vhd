LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity Hazard_Detection_Unit is

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
    );

end entity;

Architecture Arch1 of Hazard_Detection_Unit is
	
begin
	unCond_or_Prediction <= '1' when (unCond_Branch = '1' or (Prediction = '1' and Cond_Branch = '1'))
    else '0';

    Should_Branch <= '1' when (Prev_Prediction = '0' and Cond_Branch_From_EX = '1' and Zero_Flag = '1')
    else '0';

    Should_Not_Branch <= '1' when (Prev_Prediction = '1' and Cond_Branch_From_EX = '1' and Zero_Flag = '0')
    else '0';

    OUT_PC_Selector_From_Mem <= PC_Selector_From_Mem;
    
   
end Arch1;
