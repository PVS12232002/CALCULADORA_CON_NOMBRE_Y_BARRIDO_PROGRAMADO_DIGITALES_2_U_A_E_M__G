library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity Barrido_LED is
    Port ( clk : in STD_LOGIC;  -- Reloj de entrada (25 MHz)
           enable : in STD_LOGIC;  -- Señal enable
           direccion : in STD_LOGIC_VECTOR(1 downto 0);  -- 2 bits para determinar la dirección
           led : out STD_LOGIC_VECTOR(17 downto 0)  -- Vector de 18 LEDs
           );
end Barrido_LED;

architecture Behavioral of Barrido_LED is
    signal count : integer range -1 to 37 := 0;  -- Contador para la posición del LED
	 signal count2 : integer range -1 to 36 := 0;
    signal counter : integer range 0 to 12499999 := 0;  -- Contador para dividir la frecuencia de 25 MHz a 500 ms
begin
    -- Proceso para dividir el reloj de 25 MHz a 500 ms
    process(clk)
    begin
        if rising_edge(clk) then
            if counter = 12499999 then  -- 25 MHz / 2 = 12.5 millones, es decir, 500 ms
                --tick <= '1';
                counter <= 0;
					 if direccion = "01" then 
						count <= count +1;
						if count = 18 then 
						count <= 0;
						end if;
					 elsif direccion = "10" then
						count <= count -1;
						if count = -1 then 
						count <= 17;
						end if;
					 elsif direccion = "00" then 
						count <=0;
					 elsif direccion = "11" then --------------------
							count <= count +1;
							if count = 37 then 
							 count <= 0;
							end if;
					 end if;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    -- Proceso que maneja la lógica de barrido y controla el tiempo de actualización
    process(enable, direccion)
    begin
        if enable = '0' then
            -- Si enable está apagado, todos los LEDs permanecen apagados
            led <= (others => '0');
        else
            -- Dependiendo del valor de 'direccion' hacemos un barrido de diferentes maneras
            case direccion is
                when "00" =>
                    -- Si la dirección es "00", los LEDs se mantienen apagados
                    led <= (others => '0');
                
                when "01" =>
                    led <= (others => '0');
                    led(count) <= '1';  -- Enciende el LED correspondiente

                when "10" =>
                    led <= (others => '0');
                    led(count) <= '1';  -- Enciende el LED correspondiente

                when "11" =>
						case count is
            when 0 =>
                led <= (others => '0');
                led(0) <= '1';
            when 1 =>
                led <= (others => '0');
                led(1) <= '1';
            when 2 =>
                led <= (others => '0');
                led(2) <= '1';
            when 3 =>
                led <= (others => '0');
                led(3) <= '1';
            when 4 =>
                led <= (others => '0');
                led(4) <= '1';
            when 5 =>
                led <= (others => '0');
                led(5) <= '1';
            when 6 =>
                led <= (others => '0');
                led(6) <= '1';
            when 7 =>
                led <= (others => '0');
                led(7) <= '1';
            when 8 =>
                led <= (others => '0');
                led(8) <= '1';
            when 9 =>
                led <= (others => '0');
                led(9) <= '1';
            when 10 =>
                led <= (others => '0');
                led(10) <= '1';
            when 11 =>
                led <= (others => '0');
                led(11) <= '1';
            when 12 =>
                led <= (others => '0');
                led(12) <= '1';
            when 13 =>
                led <= (others => '0');
                led(13) <= '1';
            when 14 =>
                led <= (others => '0');
                led(14) <= '1';
            when 15 =>
                led <= (others => '0');
                led(15) <= '1';
            when 16 =>
                led <= (others => '0');
                led(16) <= '1';
            when 17 =>
                led <= (others => '0');
                led(17) <= '1';
            when 18 =>
                led <= (others => '0');
            when 19 =>
                led <= (others => '0');
                led(17) <= '1';
            when 20 =>
                led <= (others => '0');
                led(16) <= '1';
            when 21 =>
                led <= (others => '0');
                led(15) <= '1';
            when 22 =>
                led <= (others => '0');
                led(14) <= '1';
            when 23 =>
                led <= (others => '0');
                led(13) <= '1';
            when 24 =>
                led <= (others => '0');
                led(12) <= '1';
            when 25 =>
                led <= (others => '0');
                led(11) <= '1';
            when 26 =>
                led <= (others => '0');
                led(10) <= '1';
            when 27 =>
                led <= (others => '0');
                led(9) <= '1';
            when 28 =>
                led <= (others => '0');
                led(8) <= '1';
            when 29 =>
                led <= (others => '0');
                led(7) <= '1';
            when 30 =>
                led <= (others => '0');
                led(6) <= '1';
            when 31 =>
                led <= (others => '0');
                led(5) <= '1';
            when 32 =>
                led <= (others => '0');
                led(4) <= '1';
            when 33 =>
                led <= (others => '0');
                led(3) <= '1';
            when 34 =>
                led <= (others => '0');
                led(2) <= '1';
            when 35 =>
                led <= (others => '0');
                led(1) <= '1';
            when 36 =>
                led <= (others => '0');
                led(0) <= '1';

            when others =>
                led <= (others => '0');
        end case;
                when others =>
                    -- En caso de que la dirección no sea válida, todos los LEDs se apagan
                    led <= (others => '0');
            end case;
        end if;
    end process;

end Behavioral;
