library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MEMORIA_GENERAL is port(
        clk      : in std_logic; -- Reloj de entrada
		  pulso    : in std_logic; -- Pulso del teclado
        DATOIN   : in std_logic_vector(3 downto 0); -- Dato de entrada
		  NOMBRE,PRUEBA, BARRIDO, CALCULADORA, M0, M1, M2, M3, M4, M5 : out STD_logic := '0' -- señales de control para el lcd
    );
end entity MEMORIA_GENERAL;

architecture RAM of MEMORIA_GENERAL is
	signal contador,contador3,ORDEN: integer range 0 to 8 := 0;
	signal contador2 : integer range 0 to 900000 := 0;
begin
process(clk)
begin
	
	if pulso = '1' and contador = 0 then 
		M2 <= '1';
	else
		M2 <= '0';
	end if;
	--if pulso = '0' then
		--NOMBRE <= '0'; PRUEBA <= '0'; BARRIDO <= '0'; CALCULADORA <= '0'; contador <= 0;
	--elsif rising_edge(clk) then
	if rising_edge(clk) then
		if pulso = '1' then
			case contador is 
				when 0 =>
					case DATOIN is
						when "0001" => NULL;
							NOMBRE <= '1'; PRUEBA <= '0'; BARRIDO <= '0'; CALCULADORA <= '0'; contador <= 1;
						when "0010" => NULL;
							NOMBRE <= '0'; PRUEBA <= '1'; BARRIDO <= '0'; CALCULADORA <= '0'; contador <= 2;
						when "0011" => NULL;
							NOMBRE <= '0'; PRUEBA <= '0'; BARRIDO <= '1'; CALCULADORA <= '0'; contador <= 3;
						when "0100" => NULL;
							NOMBRE <= '0'; PRUEBA <= '0'; BARRIDO <= '0'; CALCULADORA <= '1'; contador <= 4;
						when others => NULL;
					end case;
				when 1 =>
					NULL;
				when 2 =>
					NULL;
				when 3 =>
					NULL;
				when 4 =>
					NULL;
				when others => NULL;
				end case;
		else
			NOMBRE <= '0'; PRUEBA <= '0'; BARRIDO <= '0'; CALCULADORA <= '0'; contador <= 0;
		end if;
	end if;
end process;
end architecture RAM;
