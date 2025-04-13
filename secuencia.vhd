library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity secuencia is
    Port ( clk : in STD_LOGIC;       -- Reloj de 25 MHz
           rst : in STD_LOGIC;       -- Reset
           M0 : out STD_LOGIC;       -- Salida M0
           M1 : out STD_LOGIC;       -- Salida M1
           M2 : out STD_LOGIC;       -- Salida M2
           M3 : out STD_LOGIC;       -- Salida M3
           M4 : out STD_LOGIC;       -- Salida M4
           M5 : out STD_LOGIC;       -- Salida M5
           M6 : out STD_LOGIC        -- Salida M6
         );
end secuencia;

architecture Behavioral of secuencia is
    signal contador : integer range 0 to 90000000 := 0; -- Contador para medio segundo (25 MHz * 0.5s)
    signal estado : integer  := 0;           -- Estado de la secuencia
begin

    -- Proceso para contar el tiempo de medio segundo
    process(clk, rst)
    begin
        if rst = '1' then
            contador <= 0;  -- Resetear el contador
            estado <= 0;     -- Resetear el estado
        elsif rising_edge(clk) then
            if contador = 90000000 then
                contador <= 0;  -- Resetear el contador
                estado <= estado + 1; -- Cambiar al siguiente estado
            else
                contador <= contador + 1; -- Incrementar el contador
            end if;
        end if;
    end process;

    -- Asignación de salidas según el estado
    process(estado)
    begin
        -- Apagar todas las salidas
        M0 <= '0';
        M1 <= '0';
        M2 <= '0';
        M3 <= '0';
        M4 <= '0';
        M5 <= '0';
        M6 <= '0';

        -- Enciende la salida correspondiente según el estado
        case estado is
            when 0 =>
                M0 <= '1';  -- Enciende M0
            when 1 =>
                M0 <= '0';  -- Apaga M0
                M1 <= '1';  -- Enciende M1
            when 2 =>
                M1 <= '0';  -- Apaga M1
                M2 <= '1';  -- Enciende M2
            when 3 =>
                M2 <= '0';  -- Apaga M2
                M3 <= '1';  -- Enciende M3
            when 4 =>
                M3 <= '0';  -- Apaga M3
                M4 <= '1';  -- Enciende M4
            when 5 =>
                M4 <= '0';  -- Apaga M4
                M5 <= '1';  -- Enciende M5
            when 6 =>
                M5 <= '0';  -- Apaga M5
                M6 <= '1';  -- Enciende M6
            when others =>
                -- Si el estado es mayor que 6, mantener M6 encendido
                M6 <= '1';  -- Mantener M6 encendido
        end case;
    end process;

end Behavioral;
