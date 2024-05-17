--Library declaration
Library IEEE;
Use IEEE.STD_LOGIC_1164.ALL;

--Entity declaration
Entity ALUparta is
GENERIC (n : integer := 16);
PORT(
		Cin		:IN  STD_LOGIC;
		S		:IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		A,B		:IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		F		:OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		Cout	:OUT STD_LOGIC;
		ovf		:OUT STD_LOGIC
);

end entity;

Architecture ALUparta_arch of ALUparta is

	SIGNAL A_sel			: std_logic_vector(n-1 downto 0);
	SIGNAL B_sel			: std_logic_vector(n-1 downto 0);
	SIGNAL Cin_sel			: std_logic;
	Signal Sel_AUX			: std_logic_vector(4 downto 0);
	SIGNAL F_AUX			: std_logic_vector(n-1 downto 0);
	SIGNAL Cout_AUX			: std_logic;

	Component SixteenBitAdder IS
    	generic (n: integer := 16);
	PORT (a,b : IN  std_logic_vector(n-1 downto 0);
          cin : in std_logic;
			s : out std_logic_vector(n-1 downto 0);
         cout : OUT std_logic 
		  ovf : OUT std_logic);
	END Component;
	
begin

Sel_AUX <= (S & Cin);

with Sel_AUX select 
A_sel <= 
		not(A)			when    "00011" ,
		A				when 	 others;

with Sel_AUX select 
B_sel <= 
		not(B)			when    "00010" ,
		B				when    "00100" ,
		(others => '1')	when    "00110" ,
		(others => '0')	when 	 others;
	
	
with Sel_AUX select 
Cin_sel <=
		'1'				when "00001" ,
		'1'				when "00010" ,
		'1'				when "00011" ,
		'0' 			when  others;

out1:	SixteenBitAdder generic map(n) PORT MAP(a=>A_sel,b=>B_sel,cin=>Cin_sel,s=>F_AUX,cout=>Cout_AUX,ovf=>ovf);

with Sel_AUX select 
F <= 
		(others => '0')	when    "00000" ,
		B				when    "00101" ,
		A				when    "00111" ,
		F_AUX			when 	 others;

with Sel_AUX select 
Cout <= 
		'0'				when    "00000" ,
		'0'				when    "00101" ,
		'0'				when    "00111" ,
		Cout_AUX		when 	 others;

end ALUparta_arch;
