LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity Hazard_Detection_Unit is

	port(
        Mem_To_Reg_EX : in std_logic;
        Rdst : in std_logic_vector(2 downto 0);
        EX_Rdst1 : in std_logic_vector(2 downto 0);
        EX_Rdst2 : in std_logic_vector(2 downto 0);
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
        Zero_Flag_Reset : out std_logic;
        Enable_Pipline : out std_logic
    );

end entity;

Architecture Arch1 of Hazard_Detection_Unit is
	
begin
	unCond_or_Prediction  <= '1' when (unCond_Branch = '1' or (Prediction = '1' and Cond_Branch = '1'))
    else '0';

    
    Should_Branch <= '1' when (Prev_Prediction = '0' and Cond_Branch_From_EX = '1' and Zero_Flag = '1')
    else '0';

    Zero_Flag_Reset <= '1' when ((Prev_Prediction = '1' and Zero_Flag = '1') or Should_Branch = '1')
    else '0';

    
    Should_Not_Branch <= '1' when (Prev_Prediction = '1' and Cond_Branch_From_EX = '1' and Zero_Flag = '0')
    else '0';
    
    OUT_PC_Selector_From_Mem <= PC_Selector_From_Mem;

    --PC_Val_For_Int <= Rdst_Val when (unCond_or_Prediction or Should_Branch)
    --else Mem_Out when ()
    
    IF_ID_Flush  <= unCond_or_Prediction or Should_Branch or Should_Not_Branch or PC_Selector_From_Mem;

    Enable_Pipline <= '1' when not (Mem_To_Reg_EX = '1' and (Rdst = EX_Rdst1 or Rdst = EX_Rdst2) )
    else '0';

    
    Enable_PC  <= not (unCond_or_Prediction or Should_Branch or Should_Not_Branch or PC_Selector_From_Mem);

    ID_EX_Flush  <=  Should_Branch or Should_Not_Branch or PC_Selector_From_Mem;

    EX_MEM_Flush <=  PC_Selector_From_Mem;
end Arch1;
