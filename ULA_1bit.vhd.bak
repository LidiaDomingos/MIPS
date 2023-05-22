library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- Biblioteca IEEE para funções aritméticas

entity ULA_1bit is
    port (
      A, B     : in  std_logic;
      Seletor  : in  std_logic_vector(1 downto 0);
		InverteB : in  std_logic;
		C_In     : in  std_logic;
		SLT      : in  std_logic;
		C_out    : out std_logic;
      Saida    : out std_logic
    );
end entity;

architecture comportamento of ULA_1bit is

   signal entrada0 : std_logic;
	signal entrada1 : std_logic;
	signal entrada2 : std_logic;
	signal entrada3 : std_logic;
	signal soma1bit : std_logic;
	signal saidaMuxB: std_logic;
	
    begin
	 
		muxInverteB : entity work.muxGenerico2x1 
        port map( entradaA_MUX => B,
                 entradaB_MUX =>  not B,
                 seletor_MUX => InverteB,
                 saida_MUX => saidaMuxB);
		
      entrada0 <= saidaMuxB and A;
		
		entrada1 <= saidaMuxB or A;
		
		Somador1bit : entity work.Somador_1bit
		  port map( C_In => C_In, 
						A => A, 
						B => saidaMuxB, 
						C_out => C_out, 
						Soma => soma1bit);
						
		entrada2 <= soma1bit;
		
		entrada3 <= SLT;
				
      MUX_ULA :  entity work.muxGenerico4x1 
        port map( entradaA_MUX =>  entrada0,
                  entradaB_MUX =>  entrada1,
						entradaC_MUX =>  entrada2,
						entradaD_MUX =>  entrada3,
						seletor_MUX => Seletor,
                  saida_MUX => Saida);
					
end architecture;