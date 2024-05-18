LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

entity Interrupt_Handler is
    Port (
        clk : in std_logic;
        reset : in std_logic;
        interrupt : in std_logic;
        PC_Val : in std_logic_vector(31 downto 0);
        CCR : in std_logic_vector(3 downto 0);
        stall_enable : out std_logic;
        Mem_Data_Input : out std_logic_vector(31 downto 0)
    );
end Interrupt_Handler;

architecture Behavioral of Interrupt_Handler is

    signal count_var: integer := 0;
    signal finish_flag : std_logic := '0';
begin

    -- Process for state transitions and counter logic
    process(reset, clk , interrupt)
    begin
        if reset = '1' then 
            count_var <= 0;
            finish_flag <= '0';

        elsif(rising_edge(clk) and finish_flag = '0') then
        if (interrupt = '1' and count_var = 0) then
            stall_enable <= '1';
            count_var <= 1;
            finish_flag <= '1';
        else 
            stall_enable <= '0';
            count_var <= 0;
        end if;
        
        end if;
    end process;

    process(count_var , interrupt)
    begin
        if(interrupt = '1' and count_var = 0) then 
            --push pc 
            Mem_Data_Input <= PC_Val;
        elsif(interrupt = '1' and count_var = 1 ) then
            --push ccr
            Mem_Data_Input <= "0000000000000000000000000000" & CCR;
        end if;
    end process;

end Behavioral;
