LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity Forwarding_Unit is

	port(
		
		IN_ID_EX_Src1		: in std_logic_vector(2 downto 0);
		IN_ID_EX_Src2		: in std_logic_vector(2 downto 0);	

		IN_EX_MEM_RegWrite1	: in std_logic;
		IN_EX_MEM_RegWrite2	: in std_logic;
		IN_EX_MEM_RegDst	: in std_logic_vector(2 downto 0);
		IN_EX_MEM_Src_10_8	: in std_logic_vector(2 downto 0);
		IN_EX_MEM_MemToReg	: in std_logic;
	
		IN_MEM_WB_RegWrite1	: in std_logic;
		IN_MEM_WB_RegWrite2	: in std_logic;
		IN_MEM_WB_RegDst	: in std_logic_vector(2 downto 0);
		IN_MEM_WB_Src_10_8	: in std_logic_vector(2 downto 0);
		IN_MEM_WB_MemToReg	: in std_logic;

		ForwardSrc1		: out std_logic_vector(2 downto 0);
		ForwardSrc2		: out std_logic_vector(2 downto 0)
		
			
	);

end entity;

Architecture Arch1 of Forwarding_Unit is

begin

	process (all)

	begin

		if (IN_EX_MEM_RegWrite1 = '1' and IN_ID_EX_Src1 = IN_EX_MEM_RegDst and IN_EX_MEM_MemToReg = '0') then
			ForwardSrc1 <= "001";
		elsif (IN_MEM_WB_RegWrite1 = '1' and IN_ID_EX_Src1 = IN_MEM_WB_RegDst and IN_MEM_WB_MemToReg = '0') then
			ForwardSrc1 <= "011";
		elsif (IN_MEM_WB_RegWrite1 = '1' and IN_ID_EX_Src1 = IN_MEM_WB_RegDst and IN_MEM_WB_MemToReg = '1') then
			ForwardSrc1 <= "101"; -- it was 101
		elsif (IN_EX_MEM_RegWrite2 = '1' and IN_ID_EX_Src1 = IN_EX_MEM_Src_10_8) then
			ForwardSrc1 <= "010"; 
		elsif (IN_MEM_WB_RegWrite2 = '1' and IN_ID_EX_Src1 = IN_MEM_WB_Src_10_8) then
			ForwardSrc1 <= "100"; 
		elsif (IN_EX_MEM_RegWrite1 = '1' and IN_ID_EX_Src1 = IN_EX_MEM_RegDst and IN_EX_MEM_MemToReg = '1') then
			ForwardSrc1 <= "110";
		else 
			ForwardSrc1 <= "000";
		end if;
		

	end process;

	process (all)

	begin

		if (IN_EX_MEM_RegWrite1 = '1' and IN_ID_EX_Src2 = IN_EX_MEM_RegDst and IN_EX_MEM_MemToReg = '0') then
			ForwardSrc2 <= "001";
		elsif (IN_MEM_WB_RegWrite1 = '1' and IN_ID_EX_Src2 = IN_MEM_WB_RegDst and IN_MEM_WB_MemToReg = '0') then
			ForwardSrc2 <= "011";
		elsif (IN_MEM_WB_RegWrite1 = '1' and IN_ID_EX_Src2 = IN_MEM_WB_RegDst and IN_MEM_WB_MemToReg = '1') then
			ForwardSrc2 <= "101"; -- it was 101
		elsif (IN_EX_MEM_RegWrite2 = '1' and IN_ID_EX_Src2 = IN_EX_MEM_Src_10_8) then
			ForwardSrc2 <= "010"; 
		elsif (IN_MEM_WB_RegWrite2 = '1' and IN_ID_EX_Src2 = IN_MEM_WB_Src_10_8) then
			ForwardSrc2 <= "100"; 
		elsif (IN_EX_MEM_RegWrite1 = '1' and IN_ID_EX_Src2 = IN_EX_MEM_RegDst and IN_EX_MEM_MemToReg = '1') then
			ForwardSrc2 <= "110";
		else 
			ForwardSrc2 <= "000";
		end if;
		

	end process;

end Arch1;





