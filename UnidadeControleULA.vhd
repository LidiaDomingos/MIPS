library ieee;
use ieee.std_logic_1164.all;

entity UnidadeControleULA is
  port ( TipoR   : in  std_logic;    -- Mudou. Precisa verificar o funcionamento 
			opCode   : in  std_logic_vector(5 downto 0);   -- NOVO. Precisa ver o funcionamento com esse novo input!
			funct   : in  std_logic_vector(5 downto 0);
         ULActrl : out std_logic_vector(2 downto 0)
  );
end entity;

architecture comportamento of UnidadeControleULA is

  constant SOMA   : std_logic_vector(5 downto 0) := "100000";
  constant SUB    : std_logic_vector(5 downto 0) := "100010";
  constant OP_AND : std_logic_vector(5 downto 0) := "100100";
  constant OP_OR  : std_logic_vector(5 downto 0) := "100101";
  constant SLT    : std_logic_vector(5 downto 0) := "101010";
  
  constant LW     : std_logic_vector(5 downto 0) := "100011";
  constant SW     : std_logic_vector(5 downto 0) := "101011";
  constant BEQ    : std_logic_vector(5 downto 0) := "000100";
  constant ORI    : std_logic_vector(5 downto 0) := "001101";-- D hex
  constant ADDI   : std_logic_vector(5 downto 0) := "001000";-- 8 hex 
  constant ANDI   : std_logic_vector(5 downto 0) := "001100";-- C hex
  constant SLTI   : std_logic_vector(5 downto 0) := "001010";-- 10 hex
  
  signal opcode_funct: std_logic_vector(5 downto 0);

  begin
  
    opcode_funct <= funct when TipoR = '1' else opcode;

    ULActrl(0) <= '1' when(opcode_funct = OP_OR 
								or opcode_funct = SLT
								or opcode_funct = SLTI
								or opcode_funct = ORI) else 
						'0' ;
						
    ULActrl(1) <= '1' when(opcode_funct = LW  
								or opcode_funct = SW 
								or opcode_funct = BEQ 
								or opcode_funct = SOMA 
								or opcode_funct = ADDI 
								or opcode_funct = SLTI 
								or opcode_funct = SUB 
								or opcode_funct = SLT) else 
						'0' ;
						
    ULActrl(2) <= '1' when(opcode_funct = BEQ 
								or opcode_funct = SLTI
								or opcode_funct = SUB
								or opcode_funct = SLT) else
						'0' ;
  
  
end architecture;