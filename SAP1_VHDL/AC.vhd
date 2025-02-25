library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity AC is
	port (  La : in STD_LOGIC;
		Ea : in STD_LOGIC;
		clk : in STD_LOGIC;
		from_bus : in STD_LOGIC_VECTOR(7 downto 0);
		to_ALU : out STD_LOGIC_VECTOR(7 downto 0);
		to_bus : out STD_LOGIC_VECTOR(7 downto 0)
);
end AC ;

architecture Behavioral of AC is
signal content : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

begin
process(clk)
begin
	if(clk 'event and clk='1') then
		if(La = '1') then
			content <= from_bus;
		end if;
	end if;
end process;
to_ALU <= content;
to_bus <= content when (Ea = '1') else (others => 'Z');
end Behavioral;  
