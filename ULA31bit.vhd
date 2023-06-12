library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- Biblioteca IEEE para funções aritméticas

entity ULA31bit is
    port (
		A         : in std_logic;
		B         : in std_logic;
		inverteA  : in std_logic;
		inverteB  : in std_logic;
		selecao   : in std_logic_vector(1 downto 0);
      C_In      : in std_logic;
		SLT       : in std_logic;
      C_out      : out std_logic;
		resultado : out std_logic;
		overflow  : out std_logic
	 );
end entity;

architecture comportamento of ULA31bit is
	
	 signal saida_mux : std_logic;
	 	 
	 signal soma      : std_logic;
	 signal entrada0  : std_logic;
	 signal entrada1  : std_logic;
	 signal entrada2  : std_logic;
	 signal entrada3  : std_logic;
	 
	 signal carry_out     : std_logic;

    begin
	 
	 ------ MUX B inverte B------
	 MUX_B :  entity work.muxGenerico2x1
        port map( entradaA_MUX   => B,
                 entradaB_MUX => not(B),
                 seletor_MUX => inverteB,
                 saida_MUX   => saida_mux);
	
	
	------------ AND ------------
	entrada0 <= (saida_mux and A);
	
	------------  OR ------------
	entrada1 <= (saida_mux or A);
	
	------ SOMADOR COMPLETO -----
	SOMADOR_1BIT : entity work.Somador_1bit
					port map(
						A    => A,
						B    => saida_mux,
						C_In => C_In,
						C_Out => carry_out,
						Soma => soma
					);
	
	entrada2 <= soma;
	
	------------ SLT -----------
	entrada3 <= SLT;
	
	
	------ MUX DE SELEÇAO ------
	MUX_SELECAO :  entity work.muxGenerico4x1
        port map( entradaA_MUX => entrada0, entradaB_MUX => entrada1,
						entradaC_MUX => entrada2, entradaD_MUX => entrada3,
                 seletor_MUX => selecao,
                 saida_MUX   => resultado);
				
	-------- OVERFLOW --------	
	C_Out <= carry_out;
	overflow <= (C_In xor C_Out) xor soma;
	
end architecture;