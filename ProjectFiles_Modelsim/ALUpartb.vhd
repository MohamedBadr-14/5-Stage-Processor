--Library declaration
Library IEEE;
Use IEEE.STD_LOGIC_1164.ALL;

--Entity declaration
Entity ALUpartb is
GENERIC (n : integer := 16);
PORT(
		Cin		:IN  STD_LOGIC;
		S		:IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		A,B		:IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		F		:OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		Cout	:OUT STD_LOGIC
);

end entity;

--Architecture declaration
Architecture ALUpartb_arch of ALUpartb is

--Signal Sel_AUX			: std_logic_vector(4 downto 0);

begin

--Sel_AUX <= (S & Cin);
	
	with S select
	F <= (A or B)		 when "0100" ,
	     (A and B)  	 when "0101" ,
	     (A xor B)		 when "0110" ,
	     (not A)		 when "0111" ,
		 (others => '0') when others;

end ALUpartb_arch;