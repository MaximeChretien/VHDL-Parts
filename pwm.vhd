-- PWM Generator
-- Maxime Chretien (MixLeNain)
-- v1.3


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm is 
    generic(
        constant F_clk      : integer := 5000; --input clock frequency
        constant F_PWM      : integer := 500;  --PWM frequency
        constant Precision  : integer := 4     --Duty Cycle precision (bits number)
    );
    port(
        clk    : in  std_logic; -- input clock
        duty   : in  std_logic_vector(Precision-1 downto 0); --duty cycle value
        PWMout : out std_logic -- Output signal
    );
end pwm;

architecture pwm of pwm is
    signal   DutyCount    : std_logic_vector(Precision-1 downto 0) := (others => '0');   -- Counter for duty cycle
    constant DutyCountMax : std_logic_vector(Precision-1 downto 0) := (others => '1');   -- Counter max value
    constant Div_PWM      : integer                                := F_clk / F_PWM / 2; -- frequency divider value
    signal   PWMCount     : integer range 0 to Div_PWM             := 0;   -- frequency divider counter
    signal   PWM_clk      : std_logic                              := '0'; -- PWM clock
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
        if(DutyCount = DutyCountMax) then
            DutyCount <= (others => '0');
        else
            DutyCount <= std_logic_vector(unsigned(DutyCount) + 1);
        end if;
    end process;

    -- output
    PWMout <= '1' when DutyCount < duty else '0';
end pwm;