library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity anti_rebote is port(
	clk : in std_logic;
	btn : in std_logic;
	bto : out std_logic
);
end anti_rebote;
architecture registro of anti_rebote is
	signal reg: std_logic_vector (7 downto 0);
begin 
	process (btn, clk)
	begin
		if rising_edge (clk) then 
			reg <= reg(6 downto 0) & btn;
		end if;
		if reg = x"FF" THEN
			bto <= '1';
		else 
			bto <= '0';
		end if;
end process;
end registro;
