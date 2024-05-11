LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY SixteenBitAdder IS
    generic (n: integer := 8);
	PORT (a,b : IN  std_logic_vector(n-1 downto 0);
          cin : in std_logic;
		  s : out std_logic_vector(n-1 downto 0);
           cout : OUT std_logic 
	  
);
		
	
END SixteenBitAdder;

ARCHITECTURE SixteenBitAdder_arch OF SixteenBitAdder IS

component my_nadder IS
    generic (n: integer := 4);
	PORT (a,b : IN  std_logic_vector(n-1 downto 0);
          cin : in std_logic;
		  s : out std_logic_vector(n-1 downto 0);
           cout : OUT std_logic );
END component;
component select_adder IS
    generic (n: integer := 4);
	PORT (a,b : IN  std_logic_vector(n-1 downto 0);
          cin : in std_logic;
		  s : out std_logic_vector(n-1 downto 0);
           cout : OUT std_logic );
END component;
	constant SELECT_ADDER_Numbers : integer := n / 4;
        SIGNAL temp : std_logic_vector(SELECT_ADDER_Numbers DOWNTO 0);



Begin	
   

   temp(0) <= cin;
   u1: my_nadder port map (a(3 downto 0),b(3 downto 0),temp(0),s(3 downto 0) ,temp(1));
   loop1: FOR i IN 1 TO SELECT_ADDER_Numbers-1 GENERATE
        fx: select_adder GENERIC MAP (4) PORT MAP(a((4 * i + 3) downto (4 * i)), b((4 * i + 3) downto (4 * i)), temp(i),s((4 * i + 3) downto (4 * i)),temp(i+1));
END GENERATE;
	
    
   cout<=temp(SELECT_ADDER_Numbers);

END SixteenBitAdder_arch;
