library ieee;
use ieee.std_logic_1164.all;

entity top_level is
  -- Total de bits das entradas e saidas
  generic ( larguraEnderecos : natural := 3
  );
  port   (
	 CLOCK_50 : in std_logic;
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
  signal sinal_controle: std_logic_vector(9 downto 0);
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

--detectorSub0: work.edgeDetector(bordaSubida)
--     port map (clk => CLOCK_50, entrada => (not KEY(0)), saida => CLK);

-- O port map completo do Program Counter.
PC : entity work.registradorGenerico   generic map (larguraDados => 32)
          port map (DIN => proxPC, DOUT => Endereco, ENABLE => '1', CLK => CLK, RST => '0');

incrementaPC :  entity work.somaConstante  generic map (larguraDados => 32, constante => 4)
        port map( entrada => Endereco, saida => PC_out);
		 
ROM :  entity work.ROMMIPS
        port map( Endereco => Endereco, Dado => saida_ROM);

RAM : entity work.RAMMIPS
		  port map(clk => CLK, Endereco => saida_ULA, Dado_in => entradaB_ULA, Dado_out => saida_RAM_lido, 
		  we => saida_controle(0), re => saida_controle(1), habilita => '1');

UC  : entity work.UnidadeControleFluxoDados
		  port map(opcode => saida_ROM(31 downto 26), saida_controle => saida_controle);

UC_ULA: entity work.UnidadeControleULA
		  port map(ULAop => saida_controle(5 downto 4), funct => saida_ROM(5 downto 0), ULActrl => saida_controle_ULA);
		  
muxRT_RD : entity work.muxGenerico2x1_32bit generic map(larguraDados => 5) 
        port map( entradaA_MUX => saida_ROM(20 downto 16),
                 entradaB_MUX =>  saida_ROM(15 downto 11),
                 seletor_MUX => saida_controle(8),
                 saida_MUX => saida_end3);

banco :  entity work.bancoReg  generic map (larguraDados => 32, larguraEndBancoRegs => 5)
        port map( clk => CLK, enderecoA => saida_ROM(25 downto 21), enderecoB => saida_ROM(20 downto 16), 
		  enderecoC => saida_end3, dadoEscritaC => saida_end_escrita3, escreveC => sinal_controle(7),
		  saidaA => entradaA_ULA , saidaB => entrada_MUX_A);
		  
muxULA_mem : entity work.muxGenerico2x1_32bit 
        port map(entradaA_MUX => saida_ULA,
                 entradaB_MUX =>  saida_RAM_lido,
                 seletor_MUX => saida_controle(3),
                 saida_MUX => saida_end_escrita3);
					  
muxULA_entrada : entity work.muxGenerico2x1_32bit
		  port map(entradaA_MUX => entrada_MUX_A, entradaB_MUX => sinalEstendidoShift, seletor_MUX => sinal_controle(6), saida_MUX => entradaB_ULA);

mux_right : entity work.muxGenerico2x1_32bit
			port map(entradaA_MUX => proxPC, entradaB_MUX => sinalExtImediato, seletor_MUX => seletor_mux_right, saida_MUX => saida_mux_right);
			
mux_left : entity work.muxGenerico2x1_32bit
			port map(entradaA_MUX => saida_mux_right, entradaB_MUX => pc_shift_2, seletor_MUX => sinal_controle(9), saida_MUX => proxPC);
					  
ULA : entity work.ULA_32bit
          port map (A => entradaA_ULA, B => entradaB_ULA, seletor => saida_controle_ULA(1 downto 0), inverteB => saida_controle_ULA(2),
			 F_Out => Z,saida => saida_ULA);
		
estendeSinal: entity work.estendeSinalGenerico
				  port map(estendeSinal_IN => saida_ROM(15 downto 0), estendeSinal_OUT => sinalEstendido);
				  
somador : entity work.somadorGenerico 
				  port map(entradaA => PC_out, entradaB => sinalEstendidoShift, saida => sinalExtImediato);
				  
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
seletor_mux_right <= Z and sinal_controle(2);
pc_shift <= sinalEstendido(25 downto 0);
pc_shift_2 <= PC_out(31 downto 28) & pc_shift & "00";

LEDR(3 downto 0) <= saida_mux_top(27 downto 24);
LEDR(7 downto 4) <= saida_mux_top(31 downto 28);

end architecture;