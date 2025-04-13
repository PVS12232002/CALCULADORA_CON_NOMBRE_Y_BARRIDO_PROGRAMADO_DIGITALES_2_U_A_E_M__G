--BCD_Sign_Mod10_Sequential
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BCD_Sign_Mod10_Sequential is
    Port ( input_vector : in STD_LOGIC_VECTOR (23 downto 0); -- Entrada de 24 bits
				signo       : out STD_LOGIC;
				BCD_digit_1 : out STD_LOGIC_VECTOR(3 downto 0); -- Primer dígito BCD
				BCD_digit_2 : out STD_LOGIC_VECTOR(3 downto 0); -- Segundo dígito BCD
				BCD_digit_3 : out STD_LOGIC_VECTOR(3 downto 0); -- Tercer dígito BCD
				BCD_digit_4 : out STD_LOGIC_VECTOR(3 downto 0); -- Cuarto dígito BCD
				BCD_digit_5 : out STD_LOGIC_VECTOR(3 downto 0); -- Quinto dígito BCD
				BCD_digit_6 : out STD_LOGIC_VECTOR(3 downto 0); -- Sexto dígito BCD
				BCD_digit_7 : out STD_LOGIC_VECTOR(3 downto 0)); -- Séptimo dígito BCD
end BCD_Sign_Mod10_Sequential;

architecture Behavioral of BCD_Sign_Mod10_Sequential is
    signal i        : integer := 0; -- Contador del ciclo
begin
    process(input_vector)
		variable temp : unsigned(23 downto 0);
        variable bcd_temp : unsigned(27 downto 0);
    begin
        -- Determinar el signo y ajustar el número a positivo si es necesario
        if input_vector(23) = '1' then
            signo <= '1';
            temp := unsigned(not input_vector) + 1;
        else
            signo <= '0';
            temp := unsigned(input_vector);
        end if;
        
        -- Algoritmo Double Dabble
        bcd_temp := (others => '0');
        for i in 23 downto 0 loop
            if bcd_temp(3 downto 0) > 4 then
                bcd_temp(3 downto 0) := bcd_temp(3 downto 0) + 3;
            end if;
            if bcd_temp(7 downto 4) > 4 then
                bcd_temp(7 downto 4) := bcd_temp(7 downto 4) + 3;
            end if;
            if bcd_temp(11 downto 8) > 4 then
                bcd_temp(11 downto 8) := bcd_temp(11 downto 8) + 3;
            end if;
            if bcd_temp(15 downto 12) > 4 then
                bcd_temp(15 downto 12) := bcd_temp(15 downto 12) + 3;
            end if;
            if bcd_temp(19 downto 16) > 4 then
                bcd_temp(19 downto 16) := bcd_temp(19 downto 16) + 3;
            end if;
            if bcd_temp(23 downto 20) > 4 then
                bcd_temp(23 downto 20) := bcd_temp(23 downto 20) + 3;
            end if;
				if bcd_temp(27 downto 24) > 4 then
					 bcd_temp(27 downto 24) := bcd_temp(27 downto 24) + 3;
				end if;
            -- Desplazamiento
            bcd_temp := bcd_temp(26 downto 0) & temp(23);
            temp := temp(22 downto 0) & '0';
        end loop;

        -- Asignación de los dígitos BCD a las salidas
        BCD_digit_1 <= std_logic_vector(bcd_temp(3 downto 0));
        BCD_digit_2 <= std_logic_vector(bcd_temp(7 downto 4));
        BCD_digit_3 <= std_logic_vector(bcd_temp(11 downto 8));
        BCD_digit_4 <= std_logic_vector(bcd_temp(15 downto 12));
        BCD_digit_5 <= std_logic_vector(bcd_temp(19 downto 16));
        BCD_digit_6 <= std_logic_vector(bcd_temp(23 downto 20));
        BCD_digit_7 <= std_logic_vector(bcd_temp(27 downto 24));
    end process;
end Behavioral;
