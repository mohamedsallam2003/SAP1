library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity B_reg is
	port (  LB: in STD_LOGIC;
		clk : in STD_LOGIC;
		from_bus : in STD_LOGIC_VECTOR(7 downto 0);
		to_ALU : out STD_LOGIC_VECTOR(7 downto 0)
);
end B_reg ;

architecture Behavioral of B_reg is
signal content : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

begin
process(clk)
begin
	if(clk 'event and clk='1') then
		if(LB = '1') then
			content <= from_bus;
		end if;
	end if;
end process;
to_ALU <= content;
end Behavioral;  
