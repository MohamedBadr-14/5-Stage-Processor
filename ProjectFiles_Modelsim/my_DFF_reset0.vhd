LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY my_DFF_reset0 IS
	PORT( 	d,clk,rst : IN std_logic;
			enable	  : IN std_logic;
			q : OUT std_logic);
END entity;

ARCHITECTURE a_my_DFF OF my_DFF_reset0 IS
BEGIN
	PROCESS(clk,rst,enable)
	BEGIN
		IF(rst = '1') THEN
			q <= '0';
		ELSIF clk'event and clk = '1' and enable = '1' THEN
			q <= d;
		END IF;
	END PROCESS;
END a_my_DFF;
