LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

entity PC_Circuit is
    Port (
        PC_New_Value  : in  std_logic_vector(31 downto 0);
        PC_From_EX  : in  std_logic_vector(31 downto 0);
        Rdst       : in  std_logic_vector(31 downto 0);
        Rdst_From_EX : in std_logic_vector(31 downto 0);
        Mem_Out       : in  std_logic_vector(31 downto 0);
        unCond_or_Pred : in std_logic := '0';
        Should_Branch : in std_logic :='0';
        Should_Not_Branch : in std_logic := '0';
        PC_Selector_Mem : in std_logic :='0';
        Outp     : out std_logic_vector(31 downto 0)
    );
end PC_Circuit;


architecture Behavioral of PC_Circuit is

    component MUX_2X1_Generic is 
		generic (n : Integer := 32);

		port( 
			in0,in1 		: in std_logic_vector (n-1 DOWNTO 0);
			sel 			: in  std_logic;
			out1 			: out std_logic_vector (n-1 DOWNTO 0)
		);

	end component;

    signal Mux0_Output, Mux1_Output, Mux2_Output, Mux3_Output , temp : std_logic_vector(31 downto 0);
begin

    Mux0 : MUX_2X1_Generic
    generic map(32)
    port map (
        in0 => PC_New_Value,
        in1 => Rdst,  
        sel => unCond_or_Pred,
        out1  => Mux0_Output
    );

    Mux1 : MUX_2X1_Generic
    generic map(32)
    port map (
        in0 => Mux0_Output,
        in1 => Rdst_From_EX,  
        sel => Should_Branch,
        out1  => Mux1_Output
    );

    Mux2 : MUX_2X1_Generic
    generic map(32)
    port map (
        in0 => Mux1_Output,
        in1 => PC_From_EX,  
        sel => Should_Not_Branch,
        out1  => Mux2_Output
    );

    Mux3 : MUX_2X1_Generic
    generic map(32)
    port map (
        in0 => Mux2_Output,
        in1 => Mem_Out,  
        sel => PC_Selector_Mem,
        out1  => Outp
    );




end Behavioral;
