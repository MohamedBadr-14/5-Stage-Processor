LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity ProtectStatusRegister is

	port(
        RST,CLK	        : in std_logic;
		Write_enable	: in std_logic;
		Res1	        : in std_logic_vector(31 downto 0);
		Protect_Free	: in std_logic; -- 1: Protect, 0: Free
		isProtected		: out std_logic
	);

end entity;

Architecture ProtectStatusRegister_arch of ProtectStatusRegister is

    type data_mem is array(2048 to 4095) of std_logic;
	signal PF_array : data_mem := (others => '0');

begin

	process(CLK,RST,Write_enable)
	begin

		if RST = '1' then
			PF_array <= (others => '0');
		elsif falling_edge(CLK) then
			if to_integer(unsigned(Res1)) >= 2048 and to_integer(unsigned(Res1)) <= 4095 then
				if Write_enable = '1' then
					PF_array(to_integer(unsigned(Res1))) <= Protect_Free;
				else
					null;
				end if;
			end if;
		end if;
		
	end process;

	isProtected <= PF_array(to_integer(unsigned(Res1)));

end ProtectStatusRegister_arch;
----------------------------------------------------------------------------------------------------------------------------