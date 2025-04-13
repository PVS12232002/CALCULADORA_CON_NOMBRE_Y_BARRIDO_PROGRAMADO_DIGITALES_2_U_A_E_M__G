library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Controlador_enable is
    Port (
        ENABLE : in STD_LOGIC;          -- Entrada de habilitación (1 bit)
        OP0    : in STD_LOGIC_VECTOR(1 downto 0);  -- Entrada OP0 de 2 bits
        SALIDA : out STD_LOGIC_VECTOR(1 downto 0)  -- Salida de 2 bits
    );
end Controlador_enable;

architecture Behavioral of Controlador_enable is
begin
    -- Proceso para controlar la salida según el valor de ENABLE
    proceso_control: process(ENABLE, OP0)
    begin
        if ENABLE = '1' then
            -- Si ENABLE es 1, la salida es 00
            SALIDA <= "00";
        else
            -- Si ENABLE es 0, la salida toma el valor de OP0
            SALIDA <= OP0;
        end if;
    end process;
end Behavioral;
