-- Read-Only Memory
-- Maxime Chretien (MixLeNain)
-- v1.0

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    generic(
        constant addressBits : integer := 4;        -- Number of address bits
        constant dataBits    : integer := 8;        -- Number of data bits
        constant init_file   : string := "rom.hex"  -- Initialisation file
    );
    port(
        clk           : in  std_logic; -- Input clock
        address       : in  std_logic_vector(addressBits-1 downto 0); -- Address input
        dataOut       : out std_logic_vector(dataBits-1 downto 0);    -- Data output
        nOutputEnable : in  std_logic  -- Output enable signal
    );
end rom;

architecture rom of rom is
    -- Memory definition and Initialisation
    type memory is array (0 to (2**addressBits)-1) of std_logic_vector(dataBits-1 downto 0);
    signal data: memory;
    attribute ram_init_file: string;
    attribute ram_init_file of data: signal is init_file;

begin
    -- When clk rising edge, if nOutputEnable is low then output requested value
    -- else dataOut is in high impedance state
    process begin
        wait until rising_edge(clk);
        if(nOutputEnable = '0') then
            dataOut <= data(to_integer(unsigned(address)));
        else
            dataOut <= (others => 'Z');
        end if;
    end process;
end rom;
