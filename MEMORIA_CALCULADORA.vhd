library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MEMORIA_CALCULADORA is
    port (
			clk      : in std_logic;																				-- Reloj de entrada
			DIN      : in std_logic_vector(3 downto 0);														-- Dato de entrada
			reset    : in std_logic;
			bcd_1    : in  std_logic_vector(3 downto 0);
			bcd_2    : in  std_logic_vector(3 downto 0);
			bcd_3    : in  std_logic_vector(3 downto 0);
			SIM      : in std_logic;
			LED      : out std_logic_vector(3 DOWNTO 0) := "0000"; 										-- indicador del proceso
			A1,A2,A3,B1,B2,B3,OP1,OP2,OP3,S1,S2,S3 : out std_logic_vector(3 downto 0) := "0000";-- Dato de salida
			A4,B4,S4       : out std_logic;
			LEDWR   : OUT STD_logic := '1';
			RESUL  : OUT STD_logic := '0'
		);
end entity MEMORIA_CALCULADORA;

architecture CALCULADORA of MEMORIA_CALCULADORA is
		type MEMORY is array(0 to 15) of std_logic_vector(3 downto 0);  -- Memoria de 16 palabras de 4 bits
		signal RAM1,RAM2,RAM3,RAM4 : MEMORY;  -- Señal para manejo de la RAM
		signal CE,D,U,SIG : STD_logic_vector(3 downto 0);
		signal X : STD_logic_vector (3 DOWNTO 0) := "0000";
		signal contador,ORDEN : integer range 0 to 8 := 0;
		signal resultado :  std_logic := '0';
		signal addrees : integer range 0 to 15 := 0; -- Dirección de escritura
begin
		process(clk, reset)  -- Agregamos reset al proceso
		begin
			if reset = '1' then
					-- Resetear toda la memoria a "0000"
					for i in 0 to 15 loop
						RAM1(i) <= "0000";
						RAM2(i) <= "0000";
						RAM3(i) <= "0000";
					end loop;
					LED <= "0000";  -- Indicar reset en el LED
					contador <= 0;  -- Resetear contador
			elsif clk'event and clk = '1' then
					if resultado = '1' then
							RAM1(15) <= bcd_1;  -- Leemos el valor de la memoria
							RAM2(15) <= bcd_2;  -- Leemos el valor de la memoria
							RAM3(15) <= bcd_3;  -- Leemos el valor de la memoria
							if SIM = '1' THEN
							RAM4(15) <= "0001";
							ELSE
							RAM4(15) <= "0000";
							END IF;
				end if;
					case contador is
						when 0 =>
							LED <= "0000";  -- Indicar reset en el LED
							if DIN = "1110" then  -- Escritura
									S1 <= "0000";
									S2 <= "0000";
									S3 <= "0000";
									S4 <= '0';
									resultado <= '0';
									contador <= 1;
									LEDWR <= '1';
									LED <= "1000";  -- Indicar reset en el LED
							elsif DIN = "1010" then  -- Lectura A
									contador <= 6;
									LEDWR <= '0';
									resultado <= '0';
									LED <= "0001";  -- Indicar reset en el LED
							elsif DIN = "1011" then  -- Lectura B
									contador <= 7;
									LEDWR <= '0';
									resultado <= '0';
									LED <= "0001";  -- Indicar reset en el LED
							elsif DIN = "1100" then  -- Lectura OP
									resultado <= '0';
									contador <= 8;
									LEDWR <= '0';
									LED <= "0001";  -- Indicar reset en el LED
							end if;
						when 1 =>
							LED <= "0100";  -- Indicar reset en el LED
							addrees <= to_integer(unsigned(DIN));  -- Convertimos ADDR a dirección
							contador <= 2;
						when 2 =>
						LED <= "1100";  -- Indicar reset en el LED
						IF DIN < "1010" THEN
								CE <= DIN;  -- Escribimos en la memoria numero centena
								S3 <= DIN;
								contador <= 3;
							END IF;
						when 3 =>
							IF DIN < "1010" THEN
							D <= DIN;  -- Escribimos en la memoria numero decena
							S2<= CE;
							S3<= DIN;
							contador <= 4;
							ELSIF DIN > "1001" THEN
								ORDEN <= 1;
								contador <= 5;
							END IF;
						when 4 =>
							IF DIN < "1010" THEN
							U <= DIN;  -- Escribimos en la memoria numero unidad
							S1 <= CE;
							S2 <= D;
							S3 <= DIN;
							contador <= 5;
						ELSIF DIN > "1001" THEN
							ORDEN <= 2;
							contador <= 5;
						END IF;
					 when 5 =>
							LED <= "1111";  -- Indicar reset en el LED
							IF ORDEN = 0 THEN
							RAM1(addrees) <= CE;
							RAM2(addrees) <= D;
							RAM3(addrees) <= U;
							ELSIF ORDEN =1 THEN
							S1 <= "0000";
							S2 <= "0000";
							S3 <= CE;
							RAM1(addrees) <= X;
							RAM2(addrees) <= X;
							RAM3(addrees) <= CE;
							ELSIF ORDEN =2 THEN
							S1 <= "0000";
							S2 <= CE;
							S3 <= D;
							RAM1(addrees) <= X;
							RAM2(addrees) <= CE;
							RAM3(addrees) <= D;
							END IF;
							IF DIN < "0010" then
							CE <= "0000";
							D <= "0000";
							U <= "0000";
							ORDEN <= 0;
							RAM4(addrees) <= DIN;  -- Escribimos en la memoria numero para el signo 
							if DIN = "0000" then
							S4 <= '0';
							elsif DIN = "0001" then
							S4 <= '1';
							end if;
							contador <= 0;
							end if;
						when 6 =>
							LED <= "0011";  -- Indicar reset en el LED
							A1 <= RAM1(to_integer(unsigned(DIN)));  -- Leemos el valor de la memoria
							A2 <= RAM2(to_integer(unsigned(DIN)));  -- Leemos el valor de la memoria
							A3 <= RAM3(to_integer(unsigned(DIN)));  -- Leemos el valor de la memoria
							if RAM4(to_integer(unsigned(DIN))) = "0000" then
							A4 <= '0';
							elsif RAM4(to_integer(unsigned(DIN))) = "0001" then
							A4 <= '1';
							end if;
							contador <= 0;
					when 7 =>
							LED <= "0011";  -- Indicar reset en el LED
							B1 <= RAM1(to_integer(unsigned(DIN)));  -- Leemos el valor de la memoria
							B2 <= RAM2(to_integer(unsigned(DIN)));  -- Leemos el valor de la memoria
							B3 <= RAM3(to_integer(unsigned(DIN)));  -- Leemos el valor de la memoria
							if RAM4(to_integer(unsigned(DIN))) = "0000" then
							B4 <= '0';
							elsif RAM4(to_integer(unsigned(DIN))) = "0001" then
							B4 <= '1';
							end if;
							contador <= 0;
					when 8 =>
							LED <= "0011";  -- Indicar reset en el LED
							OP1 <= RAM1(to_integer(unsigned(DIN)));  -- Leemos el valor de la memoria
							OP2 <= RAM2(to_integer(unsigned(DIN)));  -- Leemos el valor de la memoria
							OP3 <= RAM3(to_integer(unsigned(DIN)));  -- Leemos el valor de la memoria
							resultado <= '1';
							contador <= 0;
					when others =>
							contador <= 0;  -- Por defecto, reinicia a 0
					end case;
			end if;
			RESUL <= resultado;
		end process;
end architecture CALCULADORA;