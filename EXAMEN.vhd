library ieee;
use ieee.std_logic_1164.all;

entity teclado is 
port (
reloj : in std_logic;
col : in std_logic_vector (3 downto 0);
filas : out std_logic_vector (3 downto 0);
display : out std_logic;
Binario: out std_logic_vector(3 downto 0);
segmentos : out std_logic_vector (6 downto 0)
);
end teclado;

architecture logica of teclado is 

component LIB_TEC_MATRICIAL_4x4_INTESC_RevA is 

GENERIC(
            FREQ_CLK : INTEGER := 50000000         --FRECUENCIA DE LA TARJETA
);


PORT(
    CLK           : IN  STD_LOGIC;                        --RELOJ FPGA
    COLUMNAS   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); --PUERTO CONECTADO A LAS COLUMNAS DEL TECLADO
    FILAS     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); --PUERTO CONECTADO A LA FILAS DEL TECLADO
    BOTON_PRES : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); --PUERTO QUE INDICA LA TECLA QUE SE PRESIONÓ
    IND       : OUT STD_LOGIC                             --BANDERA QUE INDICA CUANDO SE PRESIONÓ UNA TECLA (SÓLO DURA UN CICLO DE RELOJ)
);

end component LIB_TEC_MATRICIAL_4x4_INTESC_RevA;

signal boton_pres : std_logic_vector (3 downto 0) := (others => '0');
signal ind : std_logic := '0';
signal segm : std_logic_vector (6 downto 0) := "0000000";

begin 

instancia_teclado: LIB_TEC_MATRICIAL_4x4_INTESC_RevA 
    Generic map (FREQ_CLK => 50000000)
    port map (
        CLK => reloj,
        COLUMNAS => col,
        FILAS => filas,
        BOTON_PRES => boton_pres,
        IND => ind
    );

proceso_teclado : process(reloj) 
begin
    if rising_edge(reloj) then 
        if ind='1' then
            case boton_pres is
                when x"0" => segm <= "1000000"; binario <= "0000";
                when x"1" => segm <= "1111001";binario <= "0001";
                when x"2" => segm <= "0100100";binario <= "0010";
                when x"3" => segm <= "0110000";binario <= "0011";
                when x"4" => segm <= "0011001";binario <= "0100";
                when x"5" => segm <= "0010010";binario <= "0101";
                when x"6" => segm <= "0000010";binario <= "0110";
                when x"7" => segm <= "1111000";binario <= "0111";
                when x"8" => segm <= "0000000";binario <= "1000";
                when x"9" => segm <= "0011000";binario <= "1001";
                when x"A" => segm <= "0001000";binario <= "1010";
                when x"B" => segm <= "0000011";binario <= "1011";
                when x"C" => segm <= "1000110";binario <= "1100";
                when x"D" => segm <= "0100001";binario <= "1101";
                when x"E" => segm <= "0000110";binario <= "1110";
                when x"F" => segm <= "0001110";binario <= "1111";
                when others => segm <= "0000000";
            end case;
        end if;
    end if;
end process;

display <= '0';
segmentos <= segm;

end logica;