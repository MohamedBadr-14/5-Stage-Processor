LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity Data_Memory is

	port(
		Rst,Clk         : in std_logic;
		Mem_Write   	: in std_logic;
        Address         : in std_logic_vector(31 downto 0);
		Data            : in std_logic_vector(31 downto 0);
		Mem_Read        : in std_logic;
		Mem_Out         : out std_logic_vector(31 downto 0);
        Mem_outRange    : out std_logic
	);

end entity;

Architecture Data_Memory_Arch of Data_Memory is

	type data_mem is array(2048 to 4095) of std_logic_vector(15 downto 0);
	signal data_array	: data_mem;

begin

	process(Clk,Rst)
	begin

		if Rst = '1' then
			data_array <= (others => (others => '0'));
            Mem_Out <= (others => '0');
		end if;

        if falling_edge(Clk) then
            if Mem_Write = '1' then
                if to_integer(unsigned(Address)) < 2048 or to_integer(unsigned(Address)) > 4095 then
                    Mem_outRange <= '1';
                else
                    Mem_outRange <= '0';
                    data_array(to_integer(unsigned(Address))) <= Data(31 downto 16);
                    data_array((to_integer(unsigned(Address)) + 1) <= Data(15 downto 0);
                end if;
            end if;
        end if;

	end process;

    process(Mem_Read)
    begin
        if Mem_Read = '1' then
            if to_integer(unsigned(Address)) < 2048 or to_integer(unsigned(Address)) > 4095 then
                Mem_outRange <= '1';
            else
                Mem_outRange <= '0';
                Mem_Out(31 downto 16) <= data_array(to_integer(unsigned(Address)));
                Mem_Out(15 downto 0) <= data_array((to_integer(unsigned(Address)) + 1);
            end if;
        end if;
    end process;

end Data_Memory_Arch;
