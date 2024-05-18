LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity PC_Buffer is
    Port (
        interrupt , enable_HDU : in std_logic;
        PC_Val_From_Mem  : in  std_logic_vector(31 downto 0);
        PC_Val_From_Fetch  : in  std_logic_vector(31 downto 0);
        Used_PC     : out std_logic_vector(31 downto 0)
    );
end PC_Buffer;


architecture Behavioral of Handle_int is

begin

    process(enable_HDU , interrupt)
        
        begin 
        if(enable_HDU = '1') then
            Used_PC <=  PC_Val_From_Fetch;
        elsif(interrupt = '1') then
            Used_PC <= PC_Val_From_Mem;
        else 
            Final_PC <= PC_Val;
        end if;


    end process

end Behavioral;
