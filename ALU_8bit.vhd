--ALU_8bit
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity ALU_8bit is
		Port (
			-- Entradas 
			A0,B0 : in  STD_LOGIC_VECTOR(7 DOWNTO 0);
			OP : in std_LOGIC_VECTOR(1 downto 0);
			-- Salidas
			error : out std_LOGIC;
			resultado : out SIGNED(23 downto 0)
		);
end ALU_8bit;
architecture Behavioral of ALU_8bit is
	-- Señales internas para capturar los números binarios
	signal A : SIGNED(7 downto 0);
	signal B : SIGNED(7 downto 0);
begin
	-- Convierte los vectores de STD_LOGIC_VECTOR a SIGNED
	A <= signed(A0);
	B <= signed(B0);
	-- Proceso que realiza la suma entre A y B
	process(A, B)
	begin	
		error <= '0';
		if OP = "00" then
			-- Realiza la suma y extiende a 24 bits
			resultado <= resize(A, 24) + resize(B, 24);
		elsif OP = "01" then
			-- Realiza la resta y extiende a 24 bits
			resultado <= resize(A, 24) - resize(B, 24);
		elsif OP = "10" then 
			-- Realiza la multiplicación y escala el resultado a 24 bits
			resultado <= resize((resize(A, 8) * resize(B, 8)),24);
		else
			-- Inicializa la señal de error y el resultado
			-- Caso donde A es 0
			if A = 0 then
				resultado <= (others => '0');  -- Resultado es 0
			-- Caso donde B es 0
			elsif B = 0 then
				error <= '1';  -- Señal de error activa
				resultado <= (others => '0');  -- Resultado es 0
			else
				-- Realiza la multiplicación por 10000 y la división y escala a 24 bits
				resultado <= resize( (resize(A, 16) * 10000) / resize(B, 16), 24);
			end if;
		end if;
	end process;
end Behavioral;