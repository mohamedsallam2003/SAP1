library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IR is
	port (  Li : in STD_LOGIC;
		Ei : in STD_LOGIC;
		clk : in STD_LOGIC;
		clr : in STD_LOGIC;
		from_bus : in STD_LOGIC_VECTOR(7 downto 0);
		to_controller : out STD_LOGIC_VECTOR(3 downto 0);
		to_bus : out STD_LOGIC_VECTOR(3 downto 0)
);
end IR ;

architecture Behavioral of IR is
signal content : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

begin
process(clk,clr)
begin

	if(clr = '0') then
		content <= (others => '0');
	elsif(clk 'event and clk='0') then
		if(Li = '1') then
			content <= from_bus;
		end if;
	end if;
end process;
to_controller <= content(7 downto 4);
to_bus <= content(3 downto 0) when (Ei = '1') else (others => 'Z');
end Behavioral;  
