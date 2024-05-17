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
        Push_Pop        : in std_logic;
        SP_Enable       : in std_logic;
		Mem_Out       : out std_logic_vector(31 downto 0) := x"00000000";
        Mem_outRange    : out std_logic := '0'
	);

end entity;

Architecture Data_Memory_Arch of Data_Memory is

	type data_mem is array(2048 to 4095) of std_logic_vector(15 downto 0);
	signal data_array	: data_mem;

    signal kofta    : std_logic_vector(31 downto 0);

begin

	process(Rst,Clk)
	begin

		if Rst = '1' then
            --Mem_Out <= (others => '0'); XXXX are produced when uncommented, moshkela law el reset etrafa3 fel nos
            Mem_outRange <= '0';
			data_array <= (others => (others => '0'));
		elsif falling_edge(Clk) then
            if Mem_Write = '1' then
                if to_integer(unsigned(Address)) < 2048 or to_integer(unsigned(Address)) > 4095 then
                    Mem_outRange <= '1';
                else
                    Mem_outRange <= '0';
                    if SP_Enable = '0' then
                        data_array(to_integer(unsigned(Address))) <= Data(15 downto 0);
                        data_array(to_integer(unsigned(Address)) + 1) <= Data(31 downto 16);
                    elsif SP_Enable = '1' and Push_Pop = '0' then -- Push
                        data_array(to_integer(unsigned(Address))) <= Data(31 downto 16);
                        data_array(to_integer(unsigned(Address)) - 1) <= Data(15 downto 0);
                    end if;                     
                end if;
            end if;
        end if;

	end process;

    process(ALL)
    begin
        if Mem_Read = '1' then
            if to_integer(unsigned(Address)) < 2048 or to_integer(unsigned(Address)) > 4095 then
                Mem_outRange <= '1';
            else
                Mem_outRange <= '0';
                if SP_Enable = '0' then
                    Mem_Out <= data_array(to_integer(unsigned(Address)) + 1) & data_array(to_integer(unsigned(Address)));
                else
                    if Push_Pop = '1' then -- Pop
                    Mem_Out <= data_array(to_integer(unsigned(Address))) & data_array(to_integer(unsigned(Address)) + 1);
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- Mem_outRange <= 
    --                 '1' when to_integer(unsigned(Address)) < 2048 or to_integer(unsigned(Address)) > 4095
    --                 else '0';


    -- -- OutputMeM(15 downto 0) <= 
    -- --                         data_array(to_integer(unsigned(Address))) when (Mem_Read = '1' and SP_Enable = '0')
    -- --                         else data_array(to_integer(unsigned(Address)) + 1) when (Mem_Read = '1' and SP_Enable = '1' and Push_Pop = '1')
    -- --                         else (others => '0');

    -- -- OutputMeM(31 downto 16) <= 
    -- --                         data_array(to_integer(unsigned(Address)) + 1) when (Mem_Read = '1' and SP_Enable = '0')
    -- --                         else data_array(to_integer(unsigned(Address))) when (Mem_Read = '1' and SP_Enable = '1' and Push_Pop = '1')
    -- --                         else (others => '0');
    -- kofta <= data_array(2049) & data_array(2048);
    -- OutputMeM <= kofta;
    -- --OutputMeM(15 downto 0) <= data_array(2049);
    -- --OutputMeM(31 downto 16) <= data_array(2048);

end Data_Memory_Arch;
