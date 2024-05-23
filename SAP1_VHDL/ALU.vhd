library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
	port (  SU: in STD_LOGIC;
		Lu: in STD_LOGIC;
		EU : in STD_LOGIC;
		from_B : in STD_LOGIC_VECTOR(7 downto 0);
		from_AC : in STD_LOGIC_VECTOR(7 downto 0);
		to_bus : out STD_LOGIC_VECTOR(7 downto 0) 
);
end ALU ;

architecture Behavioral of ALU is
signal content : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

begin
process
begin
	wait for 1 ns;
   if(Lu = '0') then
	if(SU='0') then
		content <= from_AC + from_B ;
	elsif(SU = '1') then
		content <= from_AC - from_B ;
	end if;
   elsif(Lu = '1') then
	if(SU='0') then
		content <= from_AC and from_B ;
	elsif(SU='1') then
		content <= from_AC or from_B ;
	end if;
end if;
end process;
to_bus <= content when (EU = '1') else (others => 'Z');
end Behavioral;  
