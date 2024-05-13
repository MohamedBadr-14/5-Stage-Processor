LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity Instruction_Memory is

	port(	
		ReadAddress	: in std_logic_vector(31 downto 0); --PC applied as an input.
		reset		: in std_logic;
		Read_Port	: out std_logic_vector(15 downto 0)
	);

end entity;

Architecture IC_Arch of Instruction_Memory is

	type instuctions is array(0 to 4095) of std_logic_vector(15 downto 0);	--2^12 instruction 
	signal inst_array	: instuctions;

begin

	process(reset)
	begin

		if reset = '1' then
			inst_array <= (others => (others => '0'));
		end if;
			
	end process;

	Read_Port <= inst_array(to_integer(unsigned(ReadAddress)));

end IC_Arch;
