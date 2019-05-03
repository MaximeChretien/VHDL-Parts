-- PWM Generator
-- Maxime Chretien (MixLeNain)
-- v1.1


library ieee;
use ieee.std_logic_1164.all;

entity PWM is 
	generic(
		constant F_clk	:	integer		:=	50000000; --input clock frequency --use ~5000 for sim
		constant F_PWM	:	integer		:=	500		  --PWM frequency
	);
	port(
		clk 		:	in std_logic;	-- input clock
		duty		:	in	integer range 0 to 255;	--duty cycle value
		PWMout	 	:	out std_logic  -- Output signal
	);
end PWM;

architecture PWM of PWM is
	signal	 DutyCount	:	integer range 0 to 255 		:= 0;	-- Counter for duty cycle
	constant Div_PWM	:	integer 					:= F_clk / F_PWM / 2; -- frequency divider value
	signal	 PWMCount	:	integer range 0 to Div_PWM 	:= 0;		-- frequency divider counter
	signal	 PWM_clk	:	std_logic 					:= '0';		-- PWM clock
begin
	-- frequency divider
	process begin
		wait until rising_edge(clk);
		if(PWMCount = 0) then
			PWMCount <= Div_PWM - 1;
			PWM_clk <= not PWM_clk;
		else
			PWMCount <= PWMCount - 1;
		end if;
	end process;
	
	-- Duty cycle
	process begin
		wait until rising_edge(PWM_clk);
		if(DutyCount = 255) then
			DutyCount <= 0;
		else
			DutyCount <= DutyCount + 1;
		end if;
	end process;
	
	-- output
	PWMout <= '1' when DutyCount < duty else '0';
end PWM;