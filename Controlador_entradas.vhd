library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Controlador_entradas is
    Port (
        enable : in STD_LOGIC;               -- Entrada de habilitación
        A      : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada A de 4 bits
        B      : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada B de 4 bits
        CIN    : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada CIN de 4 bits
        S0     : out STD_LOGIC_VECTOR(7 downto 0); -- Salida S0 de 4 bits
        S1     : out STD_LOGIC_VECTOR(7 downto 0)  -- Salida S1 de 4 bits
    );
end Controlador_entradas;

architecture Behavioral of Controlador_entradas is
begin
    -- Proceso de control de las salidas
    proceso_control: process(enable, A, B, CIN)
    begin
        if (enable = '1') then
            -- Si enable es 1, S0 toma el valor de CIN y S1 es 0000
            S0 <= CIN;
            S1 <= "00000000";
        else
            -- Si enable es 0, S0 toma el valor de A y S1 toma el valor de B
            S0 <= A;
            S1 <= B;
        end if;
    end process;
end Behavioral;
