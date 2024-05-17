LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity SP_Circuit is

    port(

            Reset         : in std_logic;
            CLK           : in std_logic;
            SP_Enable     : in std_logic;
            Push_Pop      : in std_logic;
            SP            : out std_logic_vector(31 downto 0)

    );

end entity;

Architecture Arch1 of SP_Circuit is

    signal Temp_SP  : std_logic_vector(31 downto 0);

begin

    process(Reset,CLK)
    begin

        if Reset = '1' then
            Temp_SP <= x"00000FFF";
        elsif falling_edge(CLK) then            --Make sure whether it's to be updated on falling or rising
            if SP_Enable = '1' then
                if Push_Pop = '1' then  --Pop
                    Temp_SP <= std_logic_vector(to_unsigned((to_integer(unsigned(Temp_SP)) + 2),32));
                else                    --Push
                    Temp_SP <= std_logic_vector(to_unsigned((to_integer(unsigned(Temp_SP)) - 2),32));
                end if;
            end if;
            
        end if;

        SP <= Temp_SP;

    end process;

end architecture;
