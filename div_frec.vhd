library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity div_frec is port(
	clk : in std_logic;
	Nciclos : in integer;
	f : out std_logic
);
end div_frec;
architecture divisor of div_frec is
	signal salida: std_logic;
	signal cuenta : integer range 0 to 25000000 := 0;
begin
	process(clk)
	begin
		if rising_edge (clk) then 
			if cuenta >= Nciclos -1 then
			cuenta <= 0;
			salida <= not salida;
			else
			cuenta <= cuenta +1;
			end if;
		end if;
end process;	
		f <= salida;
end;