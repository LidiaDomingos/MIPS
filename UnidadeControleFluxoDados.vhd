library ieee;
use ieee.std_logic_1164.all;

entity UnidadeControleFluxoDados is
    generic
    (
        larguraDados : natural := 32
    );
    port
    (
        funct  : in std_logic_vector(5 downto 0);
		  opcode : in std_logic_vector(5 downto 0);
		  saida_controle : out std_logic_vector(13 downto 0)
    );
end entity;

architecture comportamento of UnidadeControleFluxoDados is
	 
	 -- Tipo I
	 constant LW      : std_logic_vector(5 downto 0) :=  "100011"; -- hex "23"
	 constant SW      : std_logic_vector(5 downto 0) :=  "101011"; -- hex "2b"
	 constant ORI     : std_logic_vector(5 downto 0) :=  "001101"; -- hex "0d"
	 constant ANDI    : std_logic_vector(5 downto 0) :=  "001100"; -- hex "0c"
	 constant LUI     : std_logic_vector(5 downto 0) :=  "001111"; -- hex "0f"
	 constant ADDI    : std_logic_vector(5 downto 0) :=  "001000"; -- hex "08"
	 constant SLTI    : std_logic_vector(5 downto 0) :=  "001010"; -- hex "0a"
	 constant SLTIU   : std_logic_vector(5 downto 0) :=  "001011"; -- hex "0b" --Extra
	 
	 constant BEQ    : std_logic_vector(5 downto 0) :=  "000100"; -- hex "04"
	 constant BNE    : std_logic_vector(5 downto 0) :=  "000101"; -- hex "05"
	 
	 -- Tipo J
	 constant JMP    : std_logic_vector(5 downto 0) :=  "000010"; -- hex "02"
	 constant JAL    : std_logic_vector(5 downto 0) :=  "000011"; -- hex "03"
	 
	 -- Tipo R 
	 constant TIPO_R    : std_logic_vector(5 downto 0) :=  "000000"; -- hex "00"
	 constant JR        : std_logic_vector(5 downto 0) :=  "001000"; -- hex "08"
	
    begin
 --                JR |muxPC+4,BEQ/JMP|muxRtRd31| ORI  | habEscRegULA  | muxRT/Im |  TIPO R | muxULA/mem | BEQ | BNE | RD |  WR 
 saida_controle <=  '0'  &  '0'  &   "00"    &    '0'    &    '1'    &      '1'       &  '0'  &    "01"    & '0' & '0' & '1' &  '0' when (opcode= LW ) else
						  '0'  &  '0'  &   "00"    &    '0'    &    '0'    &      '1'       &  '0'  &    "00"    & '0' & '0' & '0' &  '1' when (opcode= SW ) else 
						  '0'  &  '0'  &   "00"    &    '1'    &    '1'    &      '1'       &  '0'  &    "00"    & '0' & '0' & '0' &  '0' when (opcode= ORI) else
						  '0'  &  '0'  &   "00"    &    '1'    &    '1'    &      '1'       &  '0'  &    "00"    & '0' & '0' & '0' &  '0' when (opcode= ANDI) else
						  '0'  &  '0'  &   "00"    &    '0'    &    '1'    &      '0'       &  '0'  &    "11"    & '0' & '0' & '0' &  '0' when (opcode= LUI) else
						  '0'  &  '0'  &   "00"    &    '0'    &    '1'    &      '1'       &  '0'  &    "00"    & '0' & '0' & '0' &  '0' when (opcode= ADDI) else
						  '0'  &  '1'  &   "00"    &    '0'    &    '0'    &      '0'       &  '0'  &    "00"    & '0' & '0' & '0' &  '0' when (opcode= JMP ) else
						  '0'  &  '1'  &   "10"    &    '0'    &    '1'    &      '0'       &  '0'  &    "10"    & '0' & '0' & '0' &  '0' when (opcode= JAL ) else
						  '0'  &  '0'  &   "00"    &    '0'    &    '0'    &      '0'       &  '0'  &    "00"    & '1' & '0' & '0' &  '0' when (opcode= BEQ ) else
						  '0'  &  '0'  &   "00"    &    '0'    &    '0'    &      '0'       &  '0'  &    "00"    & '0' & '1' & '0' &  '0' when (opcode= BNE ) else
						  '0'  &  '0'  &   "00"    &    '0'    &    '1'    &      '1'       &  '0'  &    "00"    & '0' & '0' & '0' &  '0' when (opcode= SLTI) else
						  '0'  &  '0'  &   "00"    &    '1'    &    '1'    &      '1'       &  '0'  &    "00"    & '0' & '0' & '0' &  '0' when (opcode= SLTIU) else  -- Novo, estende com zero (unsigned) 
						  
						   -- Como o jr é uma instrução do tipo R, devemos alterar a unidade de controle para que essa instrução não ative o habEscritaReg.
						  '1'  &  '0'  &   "00"    &    '0'    &    '0'    &      '0'       &  '0'  &    "00"    & '0' & '0' & '0' &  '0' when (opcode= TIPO_R and funct= JR )  else 
						  '0'  &  '0'  &   "01"    &    '0'    &    '1'    &      '0'       &  '1'  &    "00"    & '0' & '0' & '0' &  '0' when (opcode= TIPO_R) else
						  '0'  &  '0'  &   "00"    &    '0'    &    '0'    &      '0'       &  '0'  &    "00"    & '0' & '0' & '0' &  '0'; 
end architecture;