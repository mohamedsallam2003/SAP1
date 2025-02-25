library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity controller is
	port ( 	clk : in STD_LOGIC;
		clr : in  STD_LOGIC;
		op_code : in STD_LOGIC_VECTOR(3 downto 0);
		Cp : out STD_LOGIC;
		Ep : out STD_LOGIC;
		Lm : out STD_LOGIC;
		CE : out STD_LOGIC;
		Li : out STD_LOGIC;
		Ei : out STD_LOGIC;
		La : out STD_LOGIC;
		Ea : out STD_LOGIC;
		Lu : out STD_LOGIC;
		Su : out STD_LOGIC;
		Eu : out STD_LOGIC;
		Lb : out STD_LOGIC;
		Lo : out STD_LOGIC;
		HLT : out STD_LOGIC
		
);
end controller ;

architecture Behavioral of controller is
type state is (idle, T0, T1, T2, T3, T4, T5);
signal pr_state, nx_state : state := T0;
signal control_sig : STD_LOGIC_VECTOR (12 downto 0) := (others => '0');
signal HLT_sig : STD_LOGIC := '0';

begin

process(clk,clr)
begin
	if(clr = '0') then
		pr_state <= idle;
	elsif(clk 'event and clk = '1') then
		pr_state <= nx_state;
	end if;
end process;

process(pr_state)
begin

	case pr_state is

		when idle =>
				control_sig <= (others => '0');
				HLT_sig <= '0';
				nx_state <= T0;
		
		when T0 =>
				control_sig <= "0110000000000";
				nx_state <= T1;
				
		when T1 =>
				control_sig <= "1000000000000";
				nx_state <= T2;
		
		when T2 =>
				control_sig <= "0001100000000";
				nx_state <= T3;

		when T3 =>
				if(op_code = "0000") then		--LDA
					control_sig <= "0010010000000";

				elsif(op_code = "0001") then		--ADD
					control_sig <= "0010010000000";

				elsif(op_code = "0010") then		--SUB
					control_sig <= "0010010000000";

				elsif(op_code = "0011") then		--AND
					control_sig <= "0010010000000";
		
				elsif(op_code = "0100") then		--or
					control_sig <= "0010010000000";

				elsif(op_code = "1110") then		--OUT
					control_sig <= "0000000100001";

				elsif(op_code = "1111") then		--HLT
					control_sig <= "0000000000000";
					HLT_sig <= '1';
				end if;
				nx_state <= T4;

		when T4 =>
				if(op_code = "0000") then
					control_sig <= "0001001000000";

				elsif(op_code = "0001") then
					control_sig <= "0001000000010";

				elsif(op_code = "0010") then
					control_sig <= "0001000000010";

				elsif(op_code = "0011") then
					control_sig <= "0001000000010";

				elsif(op_code = "0100") then
					control_sig <= "0001000000010";

				else 
					control_sig <= "0000000000000";
				end if;
				nx_state <= T5;
			
		when T5 =>
				if(op_code = "0000") then
					control_sig <= "0000000000000";

				elsif(op_code = "0001") then
					control_sig <= "0000001000100";

				elsif(op_code = "0010") then
					control_sig <= "0000001001100";

				elsif(op_code = "0011") then
					control_sig <= "0000001010100";

				elsif(op_code = "0100") then
					control_sig <= "0000001011100";

				else
					control_sig <= "0000000000000";
				end if;
				nx_state <= T0;
		
		end case;
end process;
Cp <= control_sig(12);
Ep <= control_sig(11);
Lm <= control_sig(10);
CE <= control_sig(9);
Li <= control_sig(8);
Ei <= control_sig(7);
La <= control_sig(6);
Ea <= control_sig(5);
Lu <= control_sig(4);
Su <= control_sig(3);
Eu <= control_sig(2);
Lb <= control_sig(1);
Lo <= control_sig(0);
HLT <= HLT_sig;

end Behavioral;  
