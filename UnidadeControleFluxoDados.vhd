library ieee;
use ieee.std_logic_1164.all;

entity UnidadeControleFluxoDados is
	  port ( opcode : in std_logic_vector(5 downto 0);
				funct : in std_logic_vector(5 downto 0);
         saida_controle : out std_logic_vector(13 downto 0)
  );
end entity;

architecture comportamento of UnidadeControleFluxoDados is
  
  constant LW     : std_logic_vector(5 downto 0) := "100011";
  constant SW     : std_logic_vector(5 downto 0) := "101011";
  constant BEQ    : std_logic_vector(5 downto 0) := "000100";
  constant JMP    : std_logic_vector(5 downto 0) := "000010";
  constant R      : std_logic_vector(5 downto 0) := "000000";
 
 -- COMECEI NA TERÇA A NOITE, FAVOR REVISAR
  constant LUI     : std_logic_vector(5 downto 0) := "001111"; -- f hex 
  constant ADDI    : std_logic_vector(5 downto 0) := "001000";-- 8 hex 
  constant ANDI    : std_logic_vector(5 downto 0) := "001100";-- C hex
  constant ORI     : std_logic_vector(5 downto 0) := "001101";-- D hex
  constant SLTI    : std_logic_vector(5 downto 0) := "001010";-- 10 hex
  constant BNE     : std_logic_vector(5 downto 0) := "000101";-- 5 HEX
  constant JAL     : std_logic_vector(5 downto 0) := "000011";-- 3 HEX
  
  
  
  -- FUNCTS
  constant functJR : std_logic_vector(5 downto 0) := "001000"; -- 08 hex
  

  begin         --  NEW                                   NEW                           |_ NEW(Ulaop)_| 
 --                 JR  | mux[PC+4, BEQ]/JMP |muxRtRd31 | ORI | habEscRegULA | muxRT/Im | TIPO R     |muxULA/mem| BEQ | BNE |  RD  |  WR   |(APAGAR "0000...00")!
saida_controle <=   '1' &         '0'        &   "10"   & '0' &      '0'     &   '0'  &    '1'   &     "00"     & '0' & '0' & '0' &  '0'  when (opcode = R and funct = functJR) else -- Como o jr é uma instrução do tipo R, devemos alterar a unidade de controle para que essa instrução não ative o habEscritaReg.
						  '0' &         '0'        &   "01"   & '0' &      '1'     &   '0'  &    '1'   &     "00"     & '0' & '0' & '0' &  '0'  when (opcode = R)     else   -- TESTAR  00
						  '0' &         '0'        &   "00"   & '0' &      '1'     &   '1'  &    '0'   &     "01"     & '0' & '0' & '1' &  '0'  when (opcode = LW)    else   -- TESTAR 
						  '0' &         '0'        &   "00"   & '0' &      '0'     &   '1'  &    '0'   &     "01"     & '0' & '0' & '0' &  '1'  when (opcode = SW)    else   -- TESTAR
						  '0' &         '0'        &   "00"   & '0' &      '0'     &   '0'  &    '0'   &     "01"     & '1' & '0' & '0' &  '0'  when (opcode = BEQ)   else   -- TESTAR
						  '0' &         '1'        &   "00"   & '0' &      '0'     &   '0'  &    '0'   &     "01"     & '0' & '0' & '0' &  '0'  when (opcode = JMP)   else   -- TESTAR
						  '0' &         '0'        &   "00"   & '0' &      '1'     &   '0'  &    '0'   &     "11"     & '0' & '0' & '0' &  '0'  when (opcode = LUI)   else   -- TESTAR 11
						  '0' &         '0'        &   "00"   & '0' &      '1'     &   '1'  &    '0'   &     "00"     & '0' & '0' & '0' &  '0'  when (opcode = ADDI)  else   -- TESTAR 00
						  '0' &         '0'        &   "00"   & '1' &      '1'     &   '1'  &    '0'   &     "00"     & '0' & '0' & '0' &  '0'  when (opcode = ANDI)  else   -- TESTAR 00
						  '0' &         '0'        &   "00"   & '1' &      '1'     &   '1'  &    '0'   &     "00"     & '0' & '0' & '0' &  '0'  when (opcode = ORI)   else   -- TESTAR 00
						  '0' &         '0'        &   "00"   & '0' &      '1'     &   '1'  &    '0'   &     "00"     & '0' & '0' & '0' &  '0'  when (opcode = SLTI)  else  -- TESTAR 00
						  '0' &         '0'        &   "00"   & '0' &      '0'     &   '0'  &    '0'   &     "01"     & '0' & '1' & '0' &  '0'  when (opcode = BNE)   else   -- TESTAR 
						  '0' &         '1'        &   "10"   & '0' &      '1'     &   '0'  &    '0'   &     "10"     & '0' & '0' & '0' &  '0'  when (opcode = JAL)   else   -- TESTAR 10
						  '0' &         '0'        &   "00"   & '0' &      '0'     &   '0'  &    '0'   &     "00"     & '0' & '0' & '0' &  '0';  
end architecture;