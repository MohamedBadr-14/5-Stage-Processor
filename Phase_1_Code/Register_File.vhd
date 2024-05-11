LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity Register_File is

	port(	
		ReadAddress_1, ReadAddress_2	: in std_logic_vector(2 downto 0);
		WriteAddress_1, WriteAddress_2	: in std_logic_vector(2 downto 0);
		Write_Port1,Write_Port2		: in std_logic_vector(31 downto 0);	-- value to be written in the register
		W_enable_1,W_enable_2		: in std_logic;
		reset,clk_signal		: in std_logic;
		Read_Port1,Read_Port2		: out std_logic_vector(31 downto 0)
	);

end entity;

Architecture Arch1 of Register_File is

	type Reg is array(0 to 7) of std_logic_vector(31 downto 0);	-- 2-D array of 12 bit vectors
	signal Registers	: Reg := (others => (others => '0'));

begin

	process(clk_signal,reset,W_enable_1,W_enable_2)
	begin

		if reset = '1' then
			Registers <= (others => (others => '0'));
		elsif falling_edge(clk_signal) then
			if W_enable_1 = '1' then
				Registers(to_integer(unsigned(WriteAddress_1))) <= Write_Port1;
			else
				null;
			end if;

			if W_enable_2 = '1' then
				Registers(to_integer(unsigned(WriteAddress_2))) <= Write_Port2;
			else
				null;
			end if;
		end if;
		
	end process;

			Read_Port1 <= Registers(to_integer(unsigned(ReadAddress_1)));
			Read_Port2 <= Registers(to_integer(unsigned(ReadAddress_2)));


end arch1;

