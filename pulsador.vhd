library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pulsador is
    Port ( enable : in  STD_LOGIC;
           button : in  STD_LOGIC;
           output : out STD_LOGIC);
end pulsador;

architecture Behavioral of pulsador is
begin
    process(enable, button)
    begin
        if (enable = '0') then
            output <= '0';  -- Si enable no está habilitado, la salida es 0
        else
            output <= button;  -- Si enable está habilitado, la salida sigue el pulso del botón
        end if;
    end process;
end Behavioral;
