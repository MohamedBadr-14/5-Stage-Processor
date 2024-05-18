LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity Program_Counter is

	port(
		PC_Prev_Val : in std_logic_vector(31 downto 0);
		enable		: in std_logic;
		reset		: in std_logic;
		clk		: in std_logic;
		MEM_OF_0 : in std_logic_vector(15 downto 0) ;
	    MEM_OF_1 : in std_logic_vector(15 downto 0) ;
		PC		: out std_logic_vector(31 downto 0);
		PC_Plus_One : out std_logic_vector(31 downto 0)
	);

end entity;

Architecture PC_Arch of Program_Counter is

begin

	process(clk , reset , PC_Prev_Val)
		variable count_var : integer := 0;
		variable All_Ones  : std_logic_vector(31 downto 0) := (others => '1');
	
	begin
		if reset = '1' then
			count_var := to_integer(unsigned((MEM_OF_1 & MEM_OF_0)));
		elsif rising_edge(clk) then
			if enable = '1' then
				count_var := to_integer(unsigned(PC_Prev_Val)) + 1;
			else
				count_var := to_integer(unsigned(PC_Prev_Val));
			end if;
		end if;


-- The case of 111111 then incrementing it will generate 1(000000) but it will be casted to 6 bits thus it does not need to be handled explicitly.

		PC <= std_logic_vector(to_unsigned(count_var,PC'length));
		PC_Plus_One <= std_logic_vector(to_unsigned(count_var + 1,PC'length));
	end process;

end PC_Arch;
 