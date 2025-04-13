library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity multiplicador_bcd is
    Port ( 
        unidades  : in  STD_LOGIC_VECTOR(3 downto 0); -- BCD para unidades
        decenas   : in  STD_LOGIC_VECTOR(3 downto 0); -- BCD para decenas
        centenas  : in  STD_LOGIC_VECTOR(3 downto 0); -- BCD para centenas
        resultado : out STD_LOGIC_VECTOR(7 downto 0)  -- Resultado limitado a 8 bits (0-128)
    );
end multiplicador_bcd;
architecture Behavioral of multiplicador_bcd is
    signal num_unidades  : integer range 0 to 9;
    signal num_decenas   : integer range 0 to 9;
    signal num_centenas  : integer range 0 to 9;
    signal numero_decimal : integer range 0 to 999;
    signal resultado_temp : integer range 0 to 128; -- Almacenará el resultado temporal
begin
    -- Conversión de BCD a decimal
    process(unidades, decenas, centenas)
    begin
        num_unidades  <= to_integer(unsigned(unidades));
        num_decenas   <= to_integer(unsigned(decenas));
        num_centenas  <= to_integer(unsigned(centenas));

        -- Calculamos el número decimal
        numero_decimal <= (num_centenas * 100) + (num_decenas * 10) + num_unidades;
    end process;

    -- Multiplicación y limitación del resultado
    process(numero_decimal)
    begin
        -- Multiplicamos el número decimal por 1 (esto se puede cambiar por otro valor)
        resultado_temp <= numero_decimal * 1;

        -- Si el resultado excede 128, lo limitamos a 128
        if resultado_temp > 128 then
            resultado_temp <= 128;
        end if;

        -- Convertimos el resultado a 8 bits
        resultado <= std_logic_vector(to_unsigned(resultado_temp, 8));
    end process;

end Behavioral;
