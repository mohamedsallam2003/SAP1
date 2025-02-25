library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SAP1 is
	port ( 	clk : in STD_LOGIC;
		clr : in STD_LOGIC;
		data_out : out STD_LOGIC_VECTOR(7 downto 0)
);
end SAP1;
architecture Behavioral of SAP1 is

component PC is
	port (  Cp : in STD_LOGIC;
		clr : in STD_LOGIC;
		clk : in STD_LOGIC;
		Ep : in STD_LOGIC;
		to_bus : out STD_LOGIC_VECTOR(3 downto 0)
); 
end component;

component MAR is
	port (  Lm : in STD_LOGIC;
		clk : in STD_LOGIC;
		from_bus : in STD_LOGIC_VECTOR(3 downto 0);
		to_RAM : out STD_LOGIC_VECTOR(3 downto 0)
);
end component;

component RAM is
	port (  CE : in STD_LOGIC;
		from_MAR : in STD_LOGIC_VECTOR(3 downto 0);
		to_bus : out STD_LOGIC_VECTOR(7 downto 0)
);
end component;

component IR is
	port (  Li : in STD_LOGIC;
		Ei : in STD_LOGIC;
		clk : in STD_LOGIC;
		clr : in STD_LOGIC;
		from_bus : in STD_LOGIC_VECTOR(7 downto 0);
		to_controller : out STD_LOGIC_VECTOR(3 downto 0);
		to_bus : out STD_LOGIC_VECTOR(3 downto 0)
);
end component;

component controller is
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
end component;

component AC is
	port (  LA : in STD_LOGIC;
		EA : in STD_LOGIC;
		clk : in STD_LOGIC;
		from_bus : in STD_LOGIC_VECTOR(7 downto 0);
		to_ALU : out STD_LOGIC_VECTOR(7 downto 0);
		to_bus : out STD_LOGIC_VECTOR(7 downto 0)
);
end component;

component ALU is
	port (  SU: in STD_LOGIC;
		Lu: in STD_LOGIC;
		EU : in STD_LOGIC;
		from_B : in STD_LOGIC_VECTOR(7 downto 0);
		from_AC : in STD_LOGIC_VECTOR(7 downto 0);
		to_bus : out STD_LOGIC_VECTOR(7 downto 0)
);
end component;

component B_reg is
	port (  LB: in STD_LOGIC;
		clk : in STD_LOGIC;
		from_bus : in STD_LOGIC_VECTOR(7 downto 0);
		to_ALU : out STD_LOGIC_VECTOR(7 downto 0)
);
end component;

component out_reg is
	port (  LO: in STD_LOGIC;
		clk : in STD_LOGIC;
		from_bus : in STD_LOGIC_VECTOR(7 downto 0);
		data_out : out STD_LOGIC_VECTOR(7 downto 0)
);
end component;

    signal A, B, bus_signal : STD_LOGIC_VECTOR (7 downto 0);
    signal Cp, Ep, Lm, CE, Li, Ei, La, Ea, Lu, Su, Eu, Lb, Lo : STD_LOGIC := '0';
    signal HLT : STD_LOGIC := '0';
    signal MAR_out, IR_out : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal active_clk : STD_LOGIC :=  clk;

begin
active_clk <= not (HLT) and clk;

    PC_cmp : PC port map (Cp, clr, active_clk, Ep, bus_signal(3 downto 0));
    MAR_cmp : MAR port map (Lm, active_clk, bus_signal(3 downto 0), MAR_out);
    RAM_cmp : RAM port map (CE, MAR_out, bus_signal);
    IR_cmp : IR port map (Li, Ei, active_clk, clr, bus_signal, IR_out, bus_signal(3 downto 0));
    Control: controller port map (clk, clr, IR_out, Cp, Ep, Lm, CE, Li, Ei, La, Ea, Lu, Su, Eu, Lb, Lo, HLT);
    AC_cmp : AC port map (La, Ea, active_clk, bus_signal, A, bus_signal);
    ALU_cmp : ALU port map (Su, Lu, Eu	, B, A, bus_signal);
    RegB_cmp : B_reg port map (Lb, active_clk, bus_signal, B);
    OutReg_cmp : out_reg port map (Lo, active_clk, bus_signal, data_out);

end Behavioral;
	



