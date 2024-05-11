LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity MUX_4X1 is 
	generic (n : Integer:=16);

	port( 
		in0,in1,in2,in3 	: in std_logic;
		sel 			: in std_logic_vector (1 downto 0);
		out1 			: out std_logic
	);

end entity;


Architecture Arch1 of MUX_4X1 is

begin
		
	with sel select
	out1 <= in0 when "00",
		in1 when "01",
		in2 when "10",
		in3 when others;

end Arch1;

