library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CONTROL_LCD is
    Port ( input_signal : in STD_LOGIC_VECTOR(1 downto 0);  -- Entrada de 2 bits
           led : out STD_LOGIC);  -- Salida para el LED
end CONTROL_LCD;

architecture Behavioral of CONTROL_LCD is
begin
    process(input_signal)
    begin
        if input_signal = "11" then
            led <= '1';  -- Enciende el LED si la entrada es 11
        else
            led <= '0';  -- Apaga el LED para cualquier otro valor
        end if;
    end process;
end Behavioral;
