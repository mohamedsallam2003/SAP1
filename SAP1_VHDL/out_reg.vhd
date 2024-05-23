library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity out_reg is
	port (  LO: in STD_LOGIC;
		clk : in STD_LOGIC;
		from_bus : in STD_LOGIC_VECTOR(7 downto 0);
		data_out : out STD_LOGIC_VECTOR(7 downto 0)
);
end out_reg ;

architecture Behavioral of out_reg is
signal content : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

begin
process(clk)
begin
	if(clk 'event and clk='1') then
		if(LO = '1') then
			content <= from_bus;
		end if;
	end if;
end process;
data_out <= content;
end Behavioral;  
