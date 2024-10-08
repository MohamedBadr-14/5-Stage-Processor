--Library declaration
Library IEEE;
Use IEEE.STD_LOGIC_1164.ALL;

--Entity declaration
Entity ALU is
GENERIC (n : integer := 32);
PORT(
		Cin		:IN  STD_LOGIC;
		S		:IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		A,B		:IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		F1,F2	:OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		Cout	:OUT STD_LOGIC;
		Flags	:OUT STD_LOGIC_VECTOR(3 DOWNTO 0)	--bit 3: Ovf, bit 2: Carryf, bit 1: Negf, bit 0: Zerof
);

end entity;

--Architecture declaration
Architecture ALU_arch of ALU is

SIGNAL Fa,Fb:STD_LOGIC_VECTOR(n-1 DOWNTO 0);
SIGNAL Couta,Coutb:STD_LOGIC;

Component ALUparta is
GENERIC (n : integer := 16);
PORT(
		Cin		:IN  STD_LOGIC;
		S		:IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		A,B		:IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		F		:OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		Cout	:OUT STD_LOGIC;
		ovf		:OUT STD_LOGIC
);

end Component;
Component ALUpartb is
GENERIC (n : integer := 16);
PORT(
		Cin		:IN  STD_LOGIC;
		S		:IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		A,B		:IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		F		:OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		Cout	:OUT STD_LOGIC
);

end Component;

Signal Sel_AUX			: std_logic_vector(4 downto 0);
SIGNAL F_AUX			: std_logic_vector(n-1 downto 0);
SIGNAL Cout_AUX			: std_logic;
SIGNAL tempOVF			: std_logic;

begin

parta:ALUparta
GENERIC MAP (n) PORT MAP (A=>A,B=>B,S=>S,Cin=>Cin,F=>Fa,Cout=>Couta,ovf=>tempOVF);

partb:ALUpartb
GENERIC MAP (n) PORT MAP (A=>A,B=>B,S=>S,Cin=>Cin,F=>Fb,Cout=>Coutb);

Sel_AUX <= (S & Cin);

	with S(2) select
	F_AUX <= Fa    when    '0' ,
	     Fb        when    '1' ,
(others => '0')    when	 others;
	
	with S(2) select
 Cout_AUX <= Couta when    '0'	,
		 '0'       when   others;

 --Overflow Flag
Flags(3) <= 
			'1' WHEN (((F_AUX(31) = '0' and A(31) = '1' and B(31) = '1') or (F_AUX(31) = '1' and A(31) = '0' and B(31) = '0')) and ((Sel_AUX = "00001") or (Sel_AUX = "00100"))) or (((F_AUX(31) = '1' and A(31) = '0' and B(31) = '1') or (F_AUX(31) = '0' and A(31) = '1' and B(31) = '0')) and ((Sel_AUX = "00010") or (Sel_AUX = "00110")))
			else '0';
		
 --Carry Flag
	Flags(2) <= not(Cout_AUX)	WHEN	(Sel_AUX = "00010" or Sel_AUX = "00110")
				else Cout_AUX;
		
--Negative Flag
with F_AUX(31) select
Flags(1) <= 
		'1'				when    '1' ,
		'0'				when    others;
		
 --Zero Flag
Flags(0) <= '1' WHEN F_AUX = "00000000000000000000000000000000"
			else '0';

F1 <= F_AUX;
F2 <= 		B   WHEN  Sel_Aux = "00111"
	ELSE  F_AUX WHEN  Sel_Aux = "00100"
	ELSE	(others => '0');
Cout <= Cout_AUX;

end ALU_arch;
