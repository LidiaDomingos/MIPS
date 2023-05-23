library ieee;
use ieee.std_logic_1164.all;

entity top_level is
  -- Total de bits das entradas e saidas
  generic ( larguraEnderecos : natural := 3
  );
  port   (
	 KEY      : in std_logic_vector(3 downto 0);
	 SW       : in std_logic_vector(9 downto 0);
	 LEDR     : out std_logic_vector (9 downto 0);
	 HEX0     : out std_logic_vector(6 downto 0);
	 HEX1 	 : out std_logic_vector(6 downto 0);
	 HEX2 	 : out std_logic_vector(6 downto 0);
	 HEX3 	 : out std_logic_vector(6 downto 0);
	 HEX4 	 : out std_logic_vector(6 downto 0);
	 HEX5 	 : out std_logic_vector(6 downto 0)
);
end entity;


architecture arquitetura of top_level is

---------------------------------------------------------
  signal CLK    : std_logic;
  signal proxPC : std_logic_vector (31 downto 0);
  signal	PC_out : std_logic_vector (31 downto 0);
  signal Endereco : std_logic_vector (31 downto 0);
  signal saida_RAM_lido: std_logic_vector(31 downto 0);
  signal saida_controle: std_logic_vector(9 downto 0);
  signal saida_controle_ULA: std_logic_vector(2 downto 0);
  signal saida_end3: std_logic_vector(4 downto 0);
  signal saida_end_escrita3: std_logic_vector(31 downto 0);
  signal entrada_MUX_A: std_logic_vector(31 downto 0);
  signal sinalEstendidoShift: std_logic_vector(31 downto 0);
  signal sinalExtImediato: std_logic_vector(31 downto 0);
  signal seletor_mux_right: std_logic;
  signal saida_mux_right: std_logic_vector(31 downto 0);
  signal pc_shift_2: std_logic_vector(31 downto 0);
  signal Z: std_logic;
  signal sinalEstendido: std_logic_vector(31 downto 0);
  signal saida_mux_top: std_logic_vector(31 downto 0);
  signal pc_shift: std_logic_vector(25 downto 0);
  
  signal saida_ROM : std_logic_vector (31 downto 0);
  signal saida_ULA : std_logic_vector (31 downto 0);
  signal entradaA_ULA : std_logic_vector (31 downto 0);
  signal entradaB_ULA : std_logic_vector (31 downto 0);

begin

-- Instanciando os componentes:

CLK <= KEY(0);


-- O port map completo do Program Counter.

-- OK
PC : entity work.registradorGenerico   generic map (larguraDados => 32)
          port map (DIN => proxPC, DOUT => Endereco, ENABLE => '1', CLK => CLK, RST => '0');
			 
-- OK
incrementaPC :  entity work.somaConstante  generic map (larguraDados => 32, constante => 4)
        port map( entrada => Endereco, saida => PC_out);
		  
-- OK		 
ROM :  entity work.ROMMIPS
        port map( Endereco => Endereco, Dado => saida_ROM);
		  
-- OK, tinha um erro antes, mas concertado!
RAM : entity work.RAMMIPS
		  port map(clk => CLK, Endereco => saida_ULA, Dado_in => entrada_MUX_A, Dado_out => saida_RAM_lido, 
		  we => saida_controle(0), re => saida_controle(1), habilita => '1');
		  
-- OK
UC  : entity work.UnidadeControleFluxoDados
		  port map(opcode => saida_ROM(31 downto 26), saida_controle => saida_controle);

-- OK, eu acho
UC_ULA: entity work.UnidadeControleULA
		  port map(ULAop => saida_controle(5 downto 4), funct => saida_ROM(5 downto 0), ULActrl => saida_controle_ULA);

-- OK
muxRT_RD : entity work.muxGenerico2x1_32bit generic map(larguraDados => 5) 
        port map( entradaA_MUX => saida_ROM(20 downto 16),
                 entradaB_MUX =>  saida_ROM(15 downto 11),
                 seletor_MUX => saida_controle(8),
                 saida_MUX => saida_end3);

-- OK
banco :  entity work.bancoReg  generic map (larguraDados => 32, larguraEndBancoRegs => 5)
        port map( clk => CLK, enderecoA => saida_ROM(25 downto 21), enderecoB => saida_ROM(20 downto 16), 
		  enderecoC => saida_end3, dadoEscritaC => saida_end_escrita3, escreveC => saida_controle(7),
		  saidaA => entradaA_ULA , saidaB => entrada_MUX_A);
		
-- OK
muxULA_mem : entity work.muxGenerico2x1_32bit 
        port map(entradaA_MUX => saida_ULA,
                 entradaB_MUX =>  saida_RAM_lido,
                 seletor_MUX => saida_controle(3),
                 saida_MUX => saida_end_escrita3);
					  
-- tinha um erro no sinal estendido, ajeitado! OK!
muxULA_entrada : entity work.muxGenerico2x1_32bit
		  port map(entradaA_MUX => entrada_MUX_A, entradaB_MUX => sinalEstendido, seletor_MUX => saida_controle(6), saida_MUX => entradaB_ULA);

-- tinha um erro na entradaA_mux, OK
mux_right : entity work.muxGenerico2x1_32bit
			port map(entradaA_MUX => PC_out, entradaB_MUX => sinalExtImediato, seletor_MUX => seletor_mux_right, saida_MUX => saida_mux_right);
			
-- OK
mux_left : entity work.muxGenerico2x1_32bit
			port map(entradaA_MUX => saida_mux_right, entradaB_MUX => pc_shift_2, seletor_MUX => saida_controle(9), saida_MUX => proxPC);
					  
-- OK
ULA : entity work.ULA_32bit
          port map (A => entradaA_ULA, B => entradaB_ULA, seletor => saida_controle_ULA(1 downto 0), inverteB => saida_controle_ULA(2),
			 F_Out => Z,saida => saida_ULA);

-- OK 
estendeSinal: entity work.estendeSinalGenerico
				  port map(estendeSinal_IN => saida_ROM(15 downto 0), estendeSinal_OUT => sinalEstendido);

-- OK
somador : entity work.somadorGenerico 
				  port map(entradaA => PC_out, entradaB => sinalEstendidoShift, saida => sinalExtImediato);
				  
-- OK daqui pra baixo
mux_top : entity work.muxGenerico2x1_32bit
			 port map(entradaA_MUX => Endereco, entradaB_MUX => saida_ULA, seletor_MUX => SW(0), saida_MUX => saida_mux_top);

Decoder_HEX0 :  entity work.conversorHex7Seg
			 port map(dadoHex => saida_mux_top(3 downto 0), saida7seg => HEX0);
 
Decoder_HEX1 :  entity work.conversorHex7Seg
			 port map(dadoHex => saida_mux_top(7 downto 4), saida7seg => HEX1);

Decoder_HEX2 :  entity work.conversorHex7Seg
			 port map(dadoHex => saida_mux_top(11 downto 8), saida7seg => HEX2);
			 
Decoder_HEX3 :  entity work.conversorHex7Seg
			 port map(dadoHex => saida_mux_top(15 downto 12), saida7seg => HEX3);
			 
Decoder_HEX4 :  entity work.conversorHex7Seg
			 port map(dadoHex => saida_mux_top(19 downto 16), saida7seg => HEX4);
			 
Decoder_HEX5 :  entity work.conversorHex7Seg
			 port map(dadoHex => saida_mux_top(23 downto 20), saida7seg => HEX5);
				  
sinalEstendidoShift <= sinalEstendido(29 downto 0) & "00";
seletor_mux_right <= Z and saida_controle(2);
pc_shift <= saida_ROM(23 downto 0) & "00";
pc_shift_2 <= PC_out(31 downto 28) & pc_shift & "00";

LEDR(3 downto 0) <= saida_mux_top(27 downto 24);
LEDR(7 downto 4) <= saida_mux_top(31 downto 28);

end architecture;