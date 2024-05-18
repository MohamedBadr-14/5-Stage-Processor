LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity Instruction_Memory is

	port(	
		ReadAddress	: in std_logic_vector(31 downto 0); --PC applied as an input.
		reset		: in std_logic;
		Read_Port	: out std_logic_vector(15 downto 0);
		M_0,M_1,M_2,M_3		: out std_logic_vector(15 downto 0);
		outRange	: out std_logic
	);

end entity;

Architecture IC_Arch of Instruction_Memory is

	type instuctions is array(0 to 4095) of std_logic_vector(15 downto 0);
	signal inst_array	: instuctions;

begin

	M_0 <= inst_array(0);
	M_1 <= inst_array(1);
	M_2 <= inst_array(2);
	M_3 <= inst_array(3);


	process(ReadAddress)
	begin
		if to_integer(unsigned(ReadAddress)) < 0 or to_integer(unsigned(ReadAddress)) > 4095 then
			outRange <= '1';
		else
			outRange <= '0';
			Read_Port <= inst_array(to_integer(unsigned(ReadAddress)));
		end if;
	end process;

end IC_Arch;
