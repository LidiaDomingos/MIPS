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
  signal saidaMUXLeft : std_logic_vector (31 downto 0);
  signal	PC_out : std_logic_vector (31 downto 0);
  signal Endereco : std_logic_vector (31 downto 0);
  signal saida_RAM_lido: std_logic_vector(31 downto 0);
  signal saida_controle: std_logic_vector(13 downto 0);
  signal saida_controle_ULA: std_logic_vector(3 downto 0);
  signal saida_end3: std_logic_vector(4 downto 0);
  signal saida_end_escrita3: std_logic_vector(31 downto 0);
  signal entrada_MUX_A: std_logic_vector(31 downto 0);
  signal sinalEstendidoShift: std_logic_vector(31 downto 0);
  signal sinalExtImediato: std_logic_vector(31 downto 0);
  signal seletor_mux_right: std_logic;
  signal saida_mux_right: std_logic_vector(31 downto 0);
  signal pc_shift_2: std_logic_vector(31 downto 0);
  signal Z: std_logic;
  signal saida_MUX_Z_NOT_Z: std_logic;
  signal sinalEstendido: std_logic_vector(31 downto 0);
  signal saida_mux_top: std_logic_vector(31 downto 0);
  signal pc_shift: std_logic_vector(25 downto 0);
  
  signal saida_ROM : std_logic_vector (31 downto 0);
  signal saida_ULA : std_logic_vector (31 downto 0);
  signal entradaA_ULA : std_logic_vector (31 downto 0);
  signal entradaB_ULA : std_logic_vector (31 downto 0);
  
  signal sinalEstendidoLUI: std_logic_vector(31 downto 0);
  
  signal entrada_seletor_mux_right : std_logic;
  
  -- ALIAS PARA FACILITAR OS PONTOS DE CONTROLE
  alias JR: std_logic is saida_controle(13);
  alias MUX_PC_4_BEQ_JMP: std_logic is saida_controle(12);
  alias MUX_RT_RD: std_logic_vector is saida_controle(11 downto 10);
  alias ORI_AND_ESTENDE_SINAL: std_logic is saida_controle(9);
  alias HABILITA_ESCRITA_REG: std_logic is saida_controle(8);
  alias MUX_RT_IMEDIATO: std_logic is saida_controle(7);
  alias TIPO_R: std_logic is saida_controle(6);
  alias MUX_ULA_MEM: std_logic_vector is saida_controle(5 downto 4);
  alias BEQ: std_logic is saida_controle(3);
  alias BNE: std_logic is saida_controle(2);
  alias HABILITA_LEITURA_MEM: std_logic is saida_controle(1);
  alias HABILITA_ESCRITA_MEM: std_logic is saida_controle(0);


begin
-- Instanciando os componentes:

CLK <= KEY(0);


-- Registrador que guarda o endereço da instrução a ser utilizada, onde a entrada é a próxima instrução que vem do MUX_LEFT e a saída é o que vai pra ROM. 
PC : entity work.registradorGenerico   generic map (larguraDados => 32)
          port map (DIN => proxPC, DOUT => Endereco, ENABLE => '1', CLK => CLK, RST => '0');
			 
			 
-- Incrementa 4 ao endereço, exatamente como o MIPS necessita, recebe o endereço do PC e a saida vai para o MUX_RIGHT.
incrementaPC :  entity work.somaConstante  generic map (larguraDados => 32, constante => 4)
        port map( entrada => Endereco, saida => PC_out);
		  
		  
-- Memória ROM recebe o endereço do PC e tem como saida os dados que vão para o banco e afins.
ROM :  entity work.ROMMIPS
        port map( Endereco => Endereco, Dado => saida_ROM);
		  
		  
-- Memória RAM que recebe o resultado da ULA, tem como dado de escrita o dado lido do reg2 do banco, e dado de saída o dado lido do endereço, e as flags de leitura e escrita. 
RAM : entity work.RAMMIPS
		  port map(clk => CLK, Endereco => saida_ULA, Dado_in => entrada_MUX_A, Dado_out => saida_RAM_lido, 
		  we => HABILITA_ESCRITA_MEM, re => HABILITA_LEITURA_MEM, habilita => '1');
		  
		  
-- A unidade de controle recebe o opcode da instrução vinda da ROM e retornas os pontos de controle.
UC  : entity work.UnidadeControleFluxoDados
		  port map(opcode => saida_ROM(31 downto 26), funct => saida_ROM(5 downto 0), saida_controle => saida_controle);

		  
-- Unidade de controle da ULA tem como operação o que vem da unidade de controle, o funct da ROM e retorna os pontos de controle da ULA.
UC_ULA: entity work.UnidadeControleULA
		  port map(TipoR => TIPO_R, funct => saida_ROM(5 downto 0), opCode => saida_ROM(31 downto 26), ULActrl => saida_controle_ULA); -- adicionado opCode e mudou OpULA para Tipo R

		  
-- Mux que escolhe o valor que vai para a entrada B da ULA, ou seja, se vai o dado lido do banco ou se vai o valor recebido na instrução em 32 bits, tal escolha é feita pelo ponto de controle.
muxRT_RD : entity work.muxGenerico4x2_32bit generic map(larguraDados => 5) 
        port map( entradaA_MUX => saida_ROM(20 downto 16),
                 entradaB_MUX =>  saida_ROM(15 downto 11),
					  entradaC_MUX => "11111",
					  entradaD_MUX => "00000",
                 seletor_MUX => MUX_RT_RD, -- atualizado
                 saida_MUX => saida_end3);

					  
-- O banco recebe os endereços dos registradores a serem utilizados, além de receber também o dado que vem do MUX que escolhe entre dado da RAM e o que sai do PC, a escrita é controlada pelo ponto de controle que vem da ULA, tendo duas saídas
-- uma que vai para a entrada A da ULA e outra que vai para a entrada A do mux que controla o que vai para a entrada B da ULA.
banco :  entity work.bancoReg  generic map (larguraDados => 32, larguraEndBancoRegs => 5)
        port map( clk => CLK, enderecoA => saida_ROM(25 downto 21), enderecoB => saida_ROM(20 downto 16), 
		  enderecoC => saida_end3, dadoEscritaC => saida_end_escrita3, escreveC => HABILITA_ESCRITA_REG,
		  saidaA => entradaA_ULA , saidaB => entrada_MUX_A);
		
		
-- MUX que controla o que vai para o banco, e escolhe entre o endereço do PC e o dado lido da RAM, e a escolha é feita pelo ponto de controle da UC.
muxULA_mem : entity work.muxGenerico4x2_32bit 
        port map(entradaA_MUX => saida_ULA,
                 entradaB_MUX =>  saida_RAM_lido,
					  entradaC_MUX =>  PC_out,          
					  entradaD_MUX => sinalEstendidoLUI,
                 seletor_MUX => MUX_ULA_MEM, 
                 saida_MUX => saida_end_escrita3);
					 
					 
-- MUX que controla o que vai para a ULA, escolhe entre o sinal estendido e a saída 2 do banco, a escolha é feita pelo ponto de controle da UC.
muxULA_entrada : entity work.muxGenerico2x1_32bit
		  port map(entradaA_MUX => entrada_MUX_A, entradaB_MUX => sinalEstendido, seletor_MUX => MUX_RT_IMEDIATO, saida_MUX => entradaB_ULA);

		  
-- Escolhe o que vai para o MUX_LEFT, que define o que vai para o PC. Recebe o que sai do incrementaPC e o sinal estendido shiftado. É controlado pela flag out Z da ula e o ponto de controle BEQ.
mux_right : entity work.muxGenerico2x1_32bit
			port map(entradaA_MUX => PC_out, entradaB_MUX => sinalExtImediato, seletor_MUX => seletor_mux_right, saida_MUX => saida_mux_right);
			
			
-- Define o que vai para o mux ProxPC entrada , se é o endereço que vem do mux_right ou o endereço shiftado que vem da ROM.
mux_left : entity work.muxGenerico2x1_32bit
			port map(entradaA_MUX => saida_mux_right, entradaB_MUX => pc_shift_2, seletor_MUX => MUX_PC_4_BEQ_JMP, saida_MUX => saidaMUXLeft);
			

-- Define o que vai para o PC
mux_ProxPC : entity work.muxGenerico2x1_32bit
			port map(entradaA_MUX => saidaMUXLeft, entradaB_MUX => entradaA_ULA, seletor_MUX => JR, saida_MUX => proxPC);
			
	
-- Faz as operações que a instrução pede, controlada pela unidade de controle e o banco de registradores.
ULA : entity work.ULA_32bit
          port map (A => entradaA_ULA, B => entradaB_ULA, ULACtrl => saida_controle_ULA, F_Out => Z,saida => saida_ULA);

			 
-- MUX flag zero que define o jump
MUX_Z_NOT_Z : entity work.muxGenerico2x1
			port map (entradaA_MUX =>  NOT(Z), entradaB_MUX => Z, seletor_MUX => BEQ, saida_MUX => saida_MUX_Z_NOT_Z);
			  
			  
-- Pelo fato da instrução só vim com 16 bits de imediato, é necessário transformar ele em 32bits para funcionamento.
estendeSinal: entity work.estendeSinalGenerico
				  port map(ORI_e_ANDI => ORI_AND_ESTENDE_SINAL, estendeSinal_IN => saida_ROM(15 downto 0), estendeSinal_OUT => sinalEstendido); -- adicionado ponto de crtl 
				  
				  
-- Estender o sinal para a instruçao LUI, j´a que so vem 16 bits do imediato e precisamos de 32
estendeSinalLUI: entity work.estendeSinalComZeros
				   port map(estendeSinal_IN => saida_ROM(15 downto 0), estendeSinal_OUT => sinalEstendidoLUI); -- a saida ira para a entrada 3 do mux(ULA/mem)
					

-- Faz a soma do endereço da próxima instrução com o sinal shiftado que vem da instrução.
somador : entity work.somadorGenerico 
				  port map(entradaA => PC_out, entradaB => sinalEstendidoShift, saida => sinalExtImediato);
				 
				 
-- Escolhe os dados que vão para os displays, se é a saída da ULA ou se é o PC, controlado pela chave 0 da plaquinha.
mux_top : entity work.muxGenerico2x1_32bit	
			 port map(entradaA_MUX => Endereco, entradaB_MUX => saida_ULA, seletor_MUX => SW(0), saida_MUX => saida_mux_top);

			 
-- Define os valores que vai para cada hex.
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
				  
				  
-- Faz o shift do sinal. 				  
sinalEstendidoShift <= sinalEstendido(29 downto 0) & "00";


-- Porta OR entre BEQ e BNE para a Porta AND mux right 
entrada_seletor_mux_right <= BEQ or BNE;


-- Porta AND que controla o mux right.
seletor_mux_right <= saida_MUX_Z_NOT_Z and entrada_seletor_mux_right;


-- Define o valor acertado para ser a próxima instrução.
pc_shift_2 <= PC_out(31 downto 28) & saida_ROM(25 downto 0) & "00";

-- Escreve nos LED's
LEDR(3 downto 0) <= saida_mux_top(27 downto 24);
LEDR(7 downto 4) <= saida_mux_top(31 downto 28);

end architecture;