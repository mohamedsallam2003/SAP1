library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC is
	port (  Cp : in STD_LOGIC;
		clr : in STD_LOGIC;
		clk : in STD_LOGIC;
		Ep : in STD_LOGIC;
		to_bus : out STD_LOGIC_VECTOR(3 downto 0)
);
end PC ;

architecture Behavioral of PC is

signal content : STD_LOGIC_VECTOR (3 downto 0) :="0000";

begin
process(clk,clr)
begin

	if(clr = '0') then
		content <= "0000";
	elsif(clk 'event and clk='0') then 
		if(Cp = '1') then 
			content <= content + '1' ;
		end if;
	end if;
end process;
to_bus <= content when Ep = '1' else ("ZZZZ");
end Behavioral; 