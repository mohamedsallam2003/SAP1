library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM is
	port (  CE : in STD_LOGIC;
		from_MAR : in STD_LOGIC_VECTOR(3 downto 0);
		to_bus : out STD_LOGIC_VECTOR(7 downto 0)
);
end RAM ;

architecture Behavioral of RAM is

type matrix is array(0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
signal memory : matrix := (
0  => "00001001" , --LDA @9h
1  => "00011010" , --ADD @Ah
2  => "00101011" , --sub @Bh
3  => "00111100" , --and @Ch
4  => "01001101" , --or @Dh
5  => "11101111" , --OUT
6  => "11111111" , --HLT
7  => "00000000" ,
8  => "00000000" ,
9  => "00000001" , --1
10 => "00000010" , --2
11 => "00000011" , --3    
12 => "00000100" , --4
13 => "00000101" , --5
14 => "11111111" , 
15 => "11111111" );
begin
to_bus <= memory(conv_integer(unsigned(from_MAR))) when CE = '1' else (others => 'Z');
end Behavioral;  