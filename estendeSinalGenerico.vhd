library ieee;
use ieee.std_logic_1164.all;

entity estendeSinalGenerico is
    generic
    (
        larguraDadoEntrada : natural  :=    16;
        larguraDadoSaida   : natural  :=    32
    );
    port
    (
		  ORI_e_ANDI : in std_logic;
        estendeSinal_IN : in  std_logic_vector(larguraDadoEntrada-1 downto 0);
        estendeSinal_OUT: out std_logic_vector(larguraDadoSaida-1 downto 0)
    );
end entity;

architecture comportamento of estendeSinalGenerico is
	signal valor_extendido : std_logic;
begin

	 -- ------------ MUX para ORI e ANDI ------------ --
	 
	 MUX_ORI_ANDI : entity work.muxGenerico2x1
        port map( entradaA_MUX => estendeSinal_IN(larguraDadoEntrada-1) , entradaB_MUX => '0',
                 seletor_MUX => ORI_e_ANDI,
                 saida_MUX => valor_extendido);
	 

    estendeSinal_OUT <= (larguraDadoSaida-1 downto larguraDadoEntrada => valor_extendido) & estendeSinal_IN;

end architecture;