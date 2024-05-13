LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity MUX_2X1 is 

	port( 
		in0,in1 	: in std_logic;
		sel 		: in  std_logic;
		out1 		: out std_logic
	);

end entity;


Architecture Arch1 of MUX_2X1 is

begin
		
	with sel select
	out1 <= in0 when '0',
		in1 when others;

end Arch1;

