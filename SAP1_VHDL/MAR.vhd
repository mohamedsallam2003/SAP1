library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MAR is
	port (  Lm : in STD_LOGIC;
		clk : in STD_LOGIC;
		from_bus : in STD_LOGIC_VECTOR(3 downto 0);
		to_RAM : out STD_LOGIC_VECTOR(3 downto 0)
);
end MAR ;

architecture Behavioral of MAR is

signal content : STD_LOGIC_VECTOR (3 downto 0) := "0000";

begin
process(clk)
begin

	if(clk 'event and clk='1') then 
		if(Lm = '1') then 
			content <= from_bus ;
		end if;
	end if;
end process;
to_RAM <= content ;
end Behavioral;  
