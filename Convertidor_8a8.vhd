library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Paquete necesario para resize

entity Convertidor_8a8 is
    Port ( 
        -- Entrada de 8 bits
        entrada_8 : in  STD_LOGIC_VECTOR(7 downto 0); 
        SIGNO     : in  STD_LOGIC;  -- Señal de control
        -- Salida de 8 bits
        salida_8  : out STD_LOGIC_VECTOR(7 downto 0) 
    );
end Convertidor_8a8;

-- Arquitectura del Convertidor
architecture Behavioral of Convertidor_8a8 is
    SIGNAL salida : STD_LOGIC_VECTOR(7 downto 0);
begin
    -- Proceso de conversión utilizando resize
    proceso_conversion: process(entrada_8)
    begin
        IF SIGNO = '1' THEN
            -- Si SIGNO es '1', realizamos una conversión similar a un cambio de signo
            salida <= std_logic_vector(resize(unsigned(entrada_8) - 1, 8));  -- Restamos 1 y redimensionamos
            salida_8 <= NOT salida;  -- Invertimos el valor en la salida
        ELSE
            -- Si SIGNO es '0', simplemente redimensionamos el valor de la entrada de 8 bits
            salida <= std_logic_vector(resize(unsigned(entrada_8), 8));
            salida_8 <= salida;  -- La salida se iguala a la señal de salida temporal
        END IF;
    end process;
end Behavioral;
