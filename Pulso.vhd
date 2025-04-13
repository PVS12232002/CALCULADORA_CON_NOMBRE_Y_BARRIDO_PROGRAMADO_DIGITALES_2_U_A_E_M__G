library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Pulso is
    Port (
        clk        : in  STD_LOGIC; -- Reloj de 50 MHz
        rst        : in  STD_LOGIC; -- Señal de reinicio
        pulso_in   : in  STD_LOGIC; -- Pulso de entrada
        salida     : out STD_LOGIC  -- Salida que se mantiene en '1' por 0.5 segundos
    );
end Pulso;

architecture ptecla of Pulso is
    signal contador : INTEGER := 0;
    signal salida_temporal : STD_LOGIC := '0';
    constant CUENTA_MAXIMA : INTEGER := 25000000; -- 50 MHz * 0.5 segundos
begin
    process (clk, rst)
    begin
        if rst = '1' then
            -- Reiniciar los valores al recibir el reinicio
            contador <= 0;
            salida_temporal <= '0';
            salida <= '0';
        elsif rising_edge(clk) then
            if pulso_in = '1' then
                -- Reiniciar el contador y activar la salida temporal
                salida_temporal <= '1';
                contador <= 0;
            end if;

            -- Gestionar el contador y desactivar la salida temporal cuando sea necesario
            if salida_temporal = '1' then
                if contador < CUENTA_MAXIMA then
                    contador <= contador + 1;
                else
                    salida_temporal <= '0';
                end if;
            end if;
        end if;

        -- Asignar la salida final fuera del proceso
        salida <= salida_temporal;
    end process;
end ptecla;
