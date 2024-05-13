LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Predictor IS
	PORT( 	clk,rst : IN std_logic;
            Should_Branch , Shoud_Not_Branch : IN std_logic;
			Decision : OUT std_logic);
END entity;

ARCHITECTURE a_my_DFF OF Predictor IS
BEGIN
	PROCESS(clk,rst , Should_Branch , Shoud_Not_Branch)
	BEGIN
		IF(rst = '1') THEN
            Decision <= '0';
		ELSIF clk'event and clk = '1' and ((Should_Branch = '1' and Decision = '0') or (Shoud_Not_Branch = '1' and Decision ='1')) THEN
            Decision <= not Decision;
		END IF;
	END PROCESS;
END a_my_DFF;
