LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity MUX_8X1_Generic is 
	generic (n : Integer := 32);

	port( 
		in0,in1,in2,in3,in4,in5,in6,in7 	: in std_logic_vector (n-1 DOWNTO 0);
		sel 					: in std_logic_vector (2 downto 0);
		out1 					: out std_logic_vector (n-1 DOWNTO 0)
	);

end entity;


Architecture Arch1 of MUX_8X1_Generic is

begin
		
	with sel select
	out1 <= in0 when "000",
		in1 when "001",
		in2 when "010",
		in3 when "011",
		in4 when "100",
		in5 when "101",
		in6 when "110",
		in7 when others;

end Arch1;
