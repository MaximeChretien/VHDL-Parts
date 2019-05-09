-- VHDL_parts  
-- A package that create components of all functions
-- designed in the other files of this folder
-- Maxime Chretien (MixLeNain)
-- v1.0

library ieee;
use ieee.std_logic_1164.all;

package vhdl_parts is

    -- PWM Generator
    component PWM is
        generic(
            constant F_clk     : integer := 5000; --input clock frequency
            constant F_PWM     : integer := 500;  --PWM frequency
            constant Precision : integer := 4     --Duty Cycle precision (bits number)
        );
        port(
            clk    : in  std_logic;	-- input clock
            duty   : in  std_logic_vector(Precision-1 downto 0); --duty cycle value
            PWMout : out std_logic -- Output signal
        );
    end component;


end vhdl_parts;