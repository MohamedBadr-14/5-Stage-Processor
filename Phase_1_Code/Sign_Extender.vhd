LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity Sign_Extender is

	port(

		input_bits	: in std_logic_vector(15 downto 0);
		output_bits	: out std_logic_vector(31 downto 0)

	);

end entity;

Architecture Arch1 of Sign_Extender is

begin

	output_bits(15 downto 0) <= input_bits(15 downto 0);
	output_bits(31 downto 16) <= (others => '0');

end Arch1;
