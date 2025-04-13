library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Paquete necesario para manipular señales numéricas

entity Convertidor_4a2 is
    Port ( 
        entrada_4 : in  STD_LOGIC_VECTOR(3 downto 0);  -- Entrada de 4 bits
        salida_2 : out STD_LOGIC_VECTOR(1 downto 0)   -- Salida de 2 bits
    );
end Convertidor_4a2;

architecture Behavioral of Convertidor_4a2 is
begin
    -- Proceso que realiza la conversión
    proceso_conversion: process(entrada_4)
    begin
        -- Truncamiento: tomamos los 2 bits más significativos de la entrada de 4 bits
        salida_2 <= entrada_4(1 downto 0);  -- Esto selecciona los 2 bits más significativos
    end process;
end Behavioral;
