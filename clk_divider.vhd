-- Clock Divider
-- Maxime Chretien (MixLeNain)
-- v1.0


library ieee;
use ieee.std_logic_1164.all;

entity clk_divider is 
    generic(
        constant F_in  : integer := 5000; --input clock frequency
        constant F_out : integer := 500   --output clock frequency
    );
    port(
        clk_in  : in  std_logic; -- input clock
        clk_out : out std_logic  -- Output clock
    );
end clk_divider;

architecture clk_divider of clk_divider is
    constant Div_clk   : integer                    := F_in / F_out / 2; -- frequency divider value
    signal   Clk_count : integer range 0 to Div_clk := 0;                -- frequency divider counter
    signal   new_clk   : std_logic                  := '0';              -- generated clock
begin
    -- frequency divider
    process begin
        wait until rising_edge(clk_in);
        if(Clk_count = 0) then
            Clk_count <= Div_clk - 1;
            new_clk <= not new_clk;
        else
            Clk_count <= Clk_count - 1;
        end if;
    end process;

    clk_out <= new_clk;
end clk_divider;