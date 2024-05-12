LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity MUX_2X1_Generic is 
	generic (n : Integer := 32);

	port( 
		in0,in1 		: in std_logic_vector (n-1 DOWNTO 0);
		sel 			: in  std_logic;
		out1 			: out std_logic_vector (n-1 DOWNTO 0)
	);

end entity;


Architecture Arch1 of MUX_2X1_Generic is

begin
		
	with sel select
	out1 <= in0 when '0',
		in1 when others;

end Arch1;

