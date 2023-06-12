library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- Biblioteca IEEE para funções aritméticas

entity ULA1bit is
    port (
		A         : in std_logic;
		B         : in std_logic;
		inverteA  : in std_logic;
		inverteB  : in std_logic;
		selecao   : in std_logic_vector(1 downto 0);
      C_In      : in std_logic;
		SLT       : in std_logic;
      C_out      : out std_logic;
		resultado : out std_logic
	 );
end entity;

architecture comportamento of ULA1bit is
	
	 signal saida_muxA : std_logic;
	 signal saida_muxB : std_logic;
	 
	 signal soma      : std_logic;
	 
	 signal entrada0  : std_logic;
	 signal entrada1  : std_logic;
	 signal entrada2  : std_logic;
	 signal entrada3  : std_logic;

    begin
	 
	 ------ MUX A inverte A ------
	 MUX_A:  entity work.muxGenerico2x1
        port map( entradaA_MUX   => A,
                 entradaB_MUX    => not(A),
                 seletor_MUX => inverteA,
                 saida_MUX   => saida_muxA);
	 
	 ------ MUX B inverte B------
	 MUX_B :  entity work.muxGenerico2x1
        port map( entradaA_MUX   => B,
                 entradaB_MUX    => not(B),
                 seletor_MUX => inverteB,
                 saida_MUX   => saida_muxB);
	
	------------ AND ------------
	entrada0 <= (saida_muxA and saida_muxB);
	
	------------  OR ------------
	entrada1 <= (saida_muxA or saida_muxB);
	
	------ SOMADOR COMPLETO -----
	SOMADOR_1BIT : entity work.Somador_1bit
					port map(
						A    => saida_muxA,
						B    => saida_muxB,
						C_In => C_In,
						C_Out => C_out,
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
	
end architecture;