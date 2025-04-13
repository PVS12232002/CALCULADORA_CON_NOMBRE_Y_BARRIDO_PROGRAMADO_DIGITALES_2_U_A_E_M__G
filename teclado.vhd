library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity teclado is port(
	clk : in std_logic;
	c : in std_logic_vector(3 downto 0);
	LED : out std_logic;
	f : out std_logic_vector(3 downto 0);
	bina : out std_logic_vector(3 downto 0);
	seg : out std_logic_vector (6 downto 0);
	t : out std_logic
);
end teclado;
architecture tecla of teclado is
	component div_frec
	port(
		clk: in std_logic;
		Nciclos : in integer;
		f : out std_logic
	);
	end component;
	
	component anti_rebote
	port(
		clk,btn: in std_logic;
		bto : out std_logic
	);
	end component;
	component deco_BCD_seg7
	port(
		bcd: in std_logic_vector(3 downto 0);
		seg7 : out std_logic_vector(6 downto 0)
	);
	end component;
	signal fr,far, b : std_logic;
	signal reg : std_logic_vector (3 downto 0) := "0001";
	signal bcd, cl : std_logic_vector (3 downto 0);
	signal col_fil : std_logic_vector (7 downto 0);
begin 
	df1: div_frec port map(clk,10000,far);
	df2: div_frec port map(clk,125000,fr);
	ar : for i in 0 to 3 generate
		antr : anti_rebote port map(far,c(i),cl(i));
	end generate;
	process (fr, b)
	begin
		
		if rising_edge (fr) then
			
			reg <= reg(0) & reg(3 downto 1);
		end if;
		
		b <= cl(0) or cl(1) or cl(2) or cl(3);
		case b is
			when '0' => LED<='0';
			when others => LED<='1';
		end case;
			
		if rising_edge(b) then
			col_fil <= c & reg;
		end if;
		
end process;
	with col_fil select 
		bcd <=	"0000" when "01000001",
					"0001" when "10001000",
					"0010" when "01001000",
					"0011" when "00101000",
					"0100" when "10000100",
					"0101" when "01000100",
					"0110" when "00100100",
					"0111" when "10000010",
					"1000" when "01000010",
					"1001" when "00100010",
					"1010" when "00011000",
					"1011" when "00010100",
					"1100" when "00010010",
					"1101" when "10000001",
					"1110" when "00010001",
					"1111" when "00100001",
					bcd when others;
	bcd_seg7 : deco_BCD_seg7 port map(bcd,seg);
	t <= b;
	f <= reg;
	bina <= bcd;
end tecla;
