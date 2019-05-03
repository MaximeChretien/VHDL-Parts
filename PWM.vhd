
library ieee;
use ieee.std_logic_1164.all;

entity PWM is 
	port(
		clk_50MHz 	:	in std_logic;
		duty			:	in	integer range 0 to 255;
		output	 	:	out std_logic
	);
end PWM;

architecture PWM of PWM is
	signal	DutyCount		:	integer range 0 to 255 		:= 0;
	
	constant F_50MHz			:	integer							:=	50000000; --use 5000 for sim
	constant F_PWM				:	integer							:=	500;
	constant	Div_PWM			:	integer 							:= F_50MHz / F_PWM / 2;
	signal	CountPWM_clk	:	integer range 0 to Div_PWM := 0;
	signal	PWM_clk			:	std_logic 						:= '0';
begin
	process begin
		wait until rising_edge(clk_50MHz);
		if(CountPWM_clk = 0) then
			CountPWM_clk <= Div_PWM - 1;
			PWM_clk <= not PWM_clk;
		else
			CountPWM_clk <= CountPWM_clk - 1;
		end if;
	end process;
	
	process begin
		wait until rising_edge(PWM_clk);
		if(DutyCount = 255) then
			DutyCount <= 0;
		else
			DutyCount <= DutyCount + 1;
		end if;
	end process;
	
	output <= '1' when DutyCount < duty else '0';
end PWM;