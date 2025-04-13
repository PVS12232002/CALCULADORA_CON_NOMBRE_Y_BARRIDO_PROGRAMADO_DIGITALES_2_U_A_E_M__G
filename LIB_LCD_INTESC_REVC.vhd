library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--use IEEE.std_logic_unsigned.all;
--use IEEE.std_logic_arith.all;
USE WORK.COMANDOS_LCD_REVC.ALL;
entity LIB_LCD_INTESC_REVC is
PORT(CLK      : IN STD_LOGIC;
		RS      : OUT STD_LOGIC;
		RW      : OUT STD_LOGIC;
		ENA     : OUT STD_LOGIC;
		CORD    : IN STD_LOGIC;
		CORI    : IN STD_LOGIC;
		DATA_LCD: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		BLCD    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		MEN0    : IN STD_LOGIC;--BIENVENIDO
		MEN1    : IN STD_LOGIC;--ELIGE UNA OPCION
		MEN2    : IN STD_LOGIC;--1 NOMBRE
		MEN3    : IN STD_LOGIC;--2 PRUEBA
		MEN4    : IN STD_LOGIC;--3 BARRIDO 
		MEN5    : IN STD_LOGIC;--4 CALCULADORA
		CALM    : IN STD_LOGIC;--MOSTRAR DATOS DE LA CALCULADORA
		NOMBM   : IN STD_LOGIC;--MOSTRAR NOMBRE 
		HOLA    : IN STD_LOGIC;--MOSTRAR HOLA MUNDO
		BARM    : IN STD_LOGIC;--NO MOSTRAR NADA
		ERROR   : IN STD_LOGIC;
		PUNTO   : IN STD_LOGIC;
		BCD_digit_1 : in STD_LOGIC_VECTOR(3 downto 0); -- Primer dígito BCD
		BCD_digit_2 : in STD_LOGIC_VECTOR(3 downto 0); -- Segundo dígito BCD
		BCD_digit_3 : in STD_LOGIC_VECTOR(3 downto 0); -- Tercer dígito BCD
		BCD_digit_4 : in STD_LOGIC_VECTOR(3 downto 0); -- Cuarto dígito BCD
		BCD_digit_5 : in STD_LOGIC_VECTOR(3 downto 0); -- Quinto dígito BCD
		BCD_digit_6 : in STD_LOGIC_VECTOR(3 downto 0); -- Sexto dígito BCD
		BCD_digit_7 : in STD_LOGIC_VECTOR(3 downto 0); -- Séptimo dígito BCD
		SIGNO : in std_LOGIC
		);
end LIB_LCD_INTESC_REVC;

architecture Behavioral of LIB_LCD_INTESC_REVC is
TYPE RAM IS ARRAY (0 TO  60) OF STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL INST : RAM;
COMPONENT PROCESADOR_LCD_REVC is
PORT(CLK : IN STD_LOGIC;
		VECTOR_MEM : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
		INC_DIR : OUT INTEGER RANGE 0 TO 1024;
		CORD : IN STD_LOGIC;
		CORI : IN STD_LOGIC;
		RS : OUT STD_LOGIC;
		RW : OUT STD_LOGIC;
		DELAY_COR : IN INTEGER RANGE 0 TO 1000;
		BD_LCD : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		ENA  : OUT STD_LOGIC;
		C1A,C2A,C3A,C4A : IN STD_LOGIC_VECTOR(39 DOWNTO 0);
		C5A,C6A,C7A,C8A : IN STD_LOGIC_VECTOR(39 DOWNTO 0);
		DATA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
end  COMPONENT PROCESADOR_LCD_REVC;
COMPONENT CARACTERES_ESPECIALES_REVC is
PORT( C1,C2,C3,C4:OUT STD_LOGIC_VECTOR(39 DOWNTO 0);
		C5,C6,C7,C8:OUT STD_LOGIC_VECTOR(39 DOWNTO 0);
		CLK : IN STD_LOGIC
		);
end COMPONENT CARACTERES_ESPECIALES_REVC;
CONSTANT CHAR1 : INTEGER := 1;
CONSTANT CHAR2 : INTEGER := 2;
CONSTANT CHAR3 : INTEGER := 3;
CONSTANT CHAR4 : INTEGER := 4;
CONSTANT CHAR5 : INTEGER := 5;
CONSTANT CHAR6 : INTEGER := 6;
CONSTANT CHAR7 : INTEGER := 7;
CONSTANT CHAR8 : INTEGER := 8;
SIGNAL DIR : INTEGER RANGE 0 TO 1024 := 0;
SIGNAL VECTOR_MEM_S : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL RS_S, RW_S, E_S : STD_LOGIC;
SIGNAL DATA_S : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL DIR_S : INTEGER RANGE 0 TO 1024;
SIGNAL DELAY_COR : INTEGER RANGE 0 TO 1000;
SIGNAL C1S,C2S,C3S,C4S : STD_LOGIC_VECTOR(39 DOWNTO 0);
SIGNAL C5S,C6S,C7S,C8S : STD_LOGIC_VECTOR(39 DOWNTO 0);
--------------AGREGA TUS SE�ALES AQU�--------------------
SIGNAL BCD_digit_A,BCD_digit_B,BCD_digit_C,BCD_digit_D,BCD_digit_E,BCD_digit_F,BCD_digit_G : integer range 0 to 9 :=0;
BEGIN
------------COMPONENTES PARA LCD -------------------------
U1 : PROCESADOR_LCD_REVC PORT MAP(CLK  => CLK,
			VECTOR_MEM => VECTOR_MEM_S,
			RS  => RS_S,
			RW  => RW_S,
			ENA => E_S,
			INC_DIR => DIR_S,
			DELAY_COR => DELAY_COR,
			BD_LCD => BLCD,
			CORD => CORD,
			CORI => CORI,
			C1A =>C1S,
			C2A =>C2S,
			C3A =>C3S,
			C4A =>C4S,
			C5A =>C5S,
			C6A =>C6S,
			C7A =>C7S,
			C8A =>C8S,
			DATA  => DATA_S );
U2 : CARACTERES_ESPECIALES_REVC PORT MAP(C1 =>C1S,
			C2 =>C2S,
			C3 =>C3S,
			C4 =>C4S,
			C5 =>C5S,
			C6 =>C6S,
			C7 =>C7S,
			C8 =>C8S,
			CLK => CLK
			);
DIR <= DIR_S;
VECTOR_MEM_S <= INST(DIR);
RS <= RS_S;
RW <= RW_S;
ENA <= E_S;
DATA_LCD <= DATA_S;
DELAY_COR <= 600;
-----------------ABAJO ESCRIBE TU C�DIGO EN VHDL-------------------
-----------------ABAJO ESCRIBE TU C�DIGO PARA LA LCD---------------
INST(0)  <= LCD_INI("11");
INST(1)  <= LCD_INI("00");
INST(2) <= BUCLE_INI(1);
INST(3) <= POS(1,1);
process(MEN0,MEN1,MEN2,MEN3,MEN4,MEN5,NOMBM,BARM,HOLA,CALM)
BEGIN
BCD_digit_A <= to_integer(unsigned(BCD_digit_1));
BCD_digit_B <= to_integer(unsigned(BCD_digit_2));
BCD_digit_C <= to_integer(unsigned(BCD_digit_3));
BCD_digit_D <= to_integer(unsigned(BCD_digit_4));
BCD_digit_E <= to_integer(unsigned(BCD_digit_5));
BCD_digit_F <= to_integer(unsigned(BCD_digit_6));
BCD_digit_G <= to_integer(unsigned(BCD_digit_7));
case MEN0 is--BIENVENIDO
when '1' =>
	INST(4)  <= CHAR(MB);
	INST(5)  <= CHAR(I);   
	INST(6)  <= CHAR(E); 
	INST(7)  <= CHAR(N);
	INST(8)  <= CHAR(V);
	INST(9)  <= CHAR(E);
	INST(10) <= CHAR(N);
	INST(11) <= CHAR(I);
	INST(12) <= CHAR(D);
	INST(13) <= CHAR(O);
	INST(14) <= CHAR_ASCII(x"20");
	INST(15) <= CHAR_ASCII(x"20");
	INST(16) <= CHAR_ASCII(x"20");
	INST(17) <= CHAR_ASCII(x"20");
	INST(18) <= CHAR_ASCII(x"20");
	INST(19) <= CHAR_ASCII(x"20");
	when others => NULL;
	end case;
	
	if MEN1  = '1' THEN--ELIGE UNA OPCION
	INST(4)  <= CHAR(ME);
	INST(5)  <= CHAR(L);   
	INST(6)  <= CHAR(I); 
	INST(7)  <= CHAR(G);
	INST(8)  <= CHAR(E);
	INST(9)  <= CHAR_ASCII(x"20");
	INST(10) <= CHAR(MU);
	INST(11) <= CHAR(N);
	INST(12) <= CHAR(A);
	INST(13) <= CHAR_ASCII(x"20");
	INST(14) <= CHAR(MO);
	INST(15) <= CHAR(P);
	INST(16) <= CHAR(C);
	INST(17) <= CHAR(I);
	INST(18) <= CHAR(O);
	INST(19) <= CHAR(N);
	end if;
if MEN2  = '1' THEN--1)NOMBRE
	INST(4)  <= INT_NUM(1);
	INST(5)  <= CHAR_ASCII(x"29");
	INST(6)  <= CHAR(MN); 
	INST(7)  <= CHAR(O);
	INST(8)  <= CHAR(M);
	INST(9)  <= CHAR(B);
	INST(10) <= CHAR(R);
	INST(11) <= CHAR(E);
	INST(12) <= CHAR_ASCII(x"20");
	INST(13) <= CHAR_ASCII(x"20");
	INST(14) <= CHAR_ASCII(x"20");
	INST(15) <= CHAR_ASCII(x"20");
	INST(16) <= CHAR_ASCII(x"20");
	INST(17) <= CHAR_ASCII(x"20");
	INST(18) <= CHAR_ASCII(x"20");
	INST(19) <= CHAR_ASCII(x"20");
	end if;
if MEN3  = '1' THEN--2)PRUEBA
	INST(4)  <= INT_NUM(2);
	INST(5)  <= CHAR_ASCII(x"29");
	INST(6)  <= CHAR(MP); 
	INST(7)  <= CHAR(R);
	INST(8)  <= CHAR(U);
	INST(9)  <= CHAR(E);
	INST(10) <= CHAR(B);
	INST(11) <= CHAR(A);
	INST(12) <= CHAR_ASCII(x"20");
	INST(13) <= CHAR_ASCII(x"20");
	INST(14) <= CHAR_ASCII(x"20");
	INST(15) <= CHAR_ASCII(x"20");
	INST(16) <= CHAR_ASCII(x"20");
	INST(17) <= CHAR_ASCII(x"20");
	INST(18) <= CHAR_ASCII(x"20");
	INST(19) <= CHAR_ASCII(x"20");
	end if;
if MEN4  = '1' THEN--3)BARRIDO
	INST(4)  <= INT_NUM(3);
	INST(5)  <= CHAR_ASCII(x"29");
	INST(6)  <= CHAR(MB); 
	INST(7)  <= CHAR(A);
	INST(8)  <= CHAR(R);
	INST(9)  <= CHAR(R);
	INST(10) <= CHAR(I);
	INST(11) <= CHAR(D);
	INST(12) <= CHAR(O);
	INST(13) <= CHAR_ASCII(x"20");
	INST(14) <= CHAR_ASCII(x"20");
	INST(15) <= CHAR_ASCII(x"20");
	INST(16) <= CHAR_ASCII(x"20");
	INST(17) <= CHAR_ASCII(x"20");
	INST(18) <= CHAR_ASCII(x"20");
	INST(19) <= CHAR_ASCII(x"20");
	end if;
if MEN5  = '1' THEN--4)CALCULADORA
	INST(4)  <= INT_NUM(4);
	INST(5)  <= CHAR_ASCII(x"29");
	INST(6)  <= CHAR(MC); 
	INST(7)  <= CHAR(A);
	INST(8)  <= CHAR(L);
	INST(9)  <= CHAR(C);
	INST(10) <= CHAR(U);
	INST(11) <= CHAR(L);
	INST(12) <= CHAR(A);
	INST(13) <= CHAR(D);
	INST(14) <= CHAR(O);
	INST(15) <= CHAR(R);
	INST(16) <= CHAR(A);
	INST(17) <= CHAR_ASCII(x"20");
	INST(18) <= CHAR_ASCII(x"20");
	INST(19) <= CHAR_ASCII(x"20");
	end if;
if CALM  = '1' THEN--CALCULADORA CALCULOS
	if ERROR = '1' then
		INST(4)  <= CHAR(ME);
		INST(5)  <= CHAR(MR);
		INST(6)  <= CHAR(MR);
		INST(7)  <= CHAR(MO);
		INST(8)  <= CHAR(MR);
		INST(9)  <= CHAR_ASCII(X"20");
		INST(10) <= CHAR_ASCII(x"20");
		INST(11) <= CHAR_ASCII(x"20");
		INST(12) <= CHAR_ASCII(x"20");
		INST(13) <= CHAR_ASCII(x"20");
		INST(14) <= CHAR_ASCII(x"20");
		INST(15) <= CHAR_ASCII(x"20");
		INST(16) <= CHAR_ASCII(x"20");
		INST(17) <= CHAR_ASCII(x"20");
		INST(18) <= CHAR_ASCII(x"20");
		INST(19) <= CHAR_ASCII(x"20");
	else
		if SIGNO = '0' then 
			INST(4)  <= CHAR_ASCII(X"20");
		else
			INST(4)  <= CHAR_ASCII(X"2D");
		end if;
		if PUNTO = '0' then
			INST(5)  <= INT_NUM(BCD_digit_G);
			INST(6)  <= INT_NUM(BCD_digit_F);
			INST(7)  <= INT_NUM(BCD_digit_E);
			INST(8)  <= INT_NUM(BCD_digit_D);
			INST(9)  <= INT_NUM(BCD_digit_C);
			INST(10)  <= INT_NUM(BCD_digit_B);
			INST(11) <= INT_NUM(BCD_digit_A);
			INST(12) <= CHAR_ASCII(X"20");
			INST(13) <= CHAR_ASCII(X"20");
			INST(14) <= CHAR_ASCII(x"20");
			INST(15) <= CHAR_ASCII(x"20");
			INST(16) <= CHAR_ASCII(x"20");
			INST(17) <= CHAR_ASCII(x"20");
			INST(18) <= CHAR_ASCII(x"20");
			INST(19) <= CHAR_ASCII(x"20");
		else
			INST(5)  <= INT_NUM(BCD_digit_G);
			INST(6)  <= INT_NUM(BCD_digit_F);
			INST(7)  <= INT_NUM(BCD_digit_E);
			INST(8)  <= CHAR_ASCII(X"2E");
			INST(9)  <= INT_NUM(BCD_digit_D);
			INST(10) <= INT_NUM(BCD_digit_C);
			INST(11) <= INT_NUM(BCD_digit_B);
			INST(12) <= INT_NUM(BCD_digit_A);
			INST(13) <= CHAR_ASCII(X"20");
			INST(14) <= CHAR_ASCII(X"20");
			INST(15) <= CHAR_ASCII(x"20");
			INST(16) <= CHAR_ASCII(x"20");
			INST(17) <= CHAR_ASCII(x"20");
			INST(18) <= CHAR_ASCII(x"20");
			INST(19) <= CHAR_ASCII(x"20");
		end if;
	end if;
end if;
if NOMBM = '1' THEN--NOMBRE Y APELLIDO MOSTRAR
	INST(4)  <= CHAR(P);
	INST(5)  <= CHAR(V);
	INST(6)  <= CHAR(S);
	INST(7)  <= CHAR(P);
	INST(8)  <= CHAR(V);
	INST(9)  <= CHAR(S);
	INST(10) <= CHAR(P);
	INST(11) <= CHAR(V);
	INST(12) <= CHAR(S);
	INST(13) <= CHAR_ASCII(x"20");
	INST(14) <= CHAR(P);
	INST(15) <= CHAR(V);
	INST(16) <= CHAR(S);
	INST(17) <= CHAR(X);
	INST(18) <= CHAR(D);
	INST(19) <= CHAR_ASCII(x"20");
	end if;
if HOLA  = '1' THEN--HOLA MUNDO
	INST(4)  <= CHAR(MH);
	INST(5)  <= CHAR(O);   
	INST(6)  <= CHAR(L); 
	INST(7)  <= CHAR(A);
	INST(8)  <= CHAR_ASCII(x"20");
	INST(9)  <= CHAR(MM);
	INST(10) <= CHAR(U);
	INST(11) <= CHAR(N);
	INST(12) <= CHAR(D);
	INST(13) <= CHAR(O);
	INST(14) <= CHAR_ASCII(x"20");
	INST(15) <= CHAR_ASCII(x"20");
	INST(16) <= CHAR_ASCII(x"20");
	INST(17) <= CHAR_ASCII(x"20");
	INST(18) <= CHAR_ASCII(x"20");
	INST(19) <= CHAR_ASCII(x"20");
	end if;
if BARM  = '1' THEN--MOSTRAR BARRIDO --SIN MENSAJE EN LCD
	INST(4)  <= CHAR_ASCII(x"20");
	INST(5)  <= CHAR_ASCII(x"20");
	INST(6)  <= CHAR_ASCII(x"20");
	INST(7)  <= CHAR_ASCII(x"20");
	INST(8)  <= CHAR_ASCII(x"20");
	INST(9)  <= CHAR_ASCII(x"20");
	INST(10) <= CHAR_ASCII(x"20");
	INST(11) <= CHAR_ASCII(x"20");
	INST(12) <= CHAR_ASCII(x"20");
	INST(13) <= CHAR_ASCII(x"20");
	INST(14) <= CHAR_ASCII(x"20");
	INST(15) <= CHAR_ASCII(x"20");
	INST(16) <= CHAR_ASCII(x"20");
	INST(17) <= CHAR_ASCII(x"20");
	INST(18) <= CHAR_ASCII(x"20");
	INST(19) <= CHAR_ASCII(x"20");
	end if;

end process;
INST(20) <= BUCLE_FIN(1);
INST(21) <= CODIGO_FIN(1);
end Behavioral;