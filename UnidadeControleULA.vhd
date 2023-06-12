library ieee;
use ieee.std_logic_1164.all;

entity UnidadeControleULA is
    generic
    (
        larguraDados : natural := 32
    );
    port
    (
		  TipoR     : in std_logic;
		  opcode    : in std_logic_vector(5 downto 0);
		  funct     : in std_logic_vector(5 downto 0);
		  ULActrl   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture comportamento of UnidadeControleULA is
	 
	 -- Opcodes
	 
	 constant LW      : std_logic_vector(5 downto 0) :=  "100011"; -- hex "23"
	 constant SW      : std_logic_vector(5 downto 0) :=  "101011"; -- hex "2b"
	 constant ORI     : std_logic_vector(5 downto 0) :=  "001101"; -- hex "0d"
	 constant ANDI    : std_logic_vector(5 downto 0) :=  "001100"; -- hex "0c"
	 constant BEQ     : std_logic_vector(5 downto 0) :=  "000100"; -- hex "04"
	 constant BNE     : std_logic_vector(5 downto 0) :=  "000101"; -- hex "05"
	 constant JMP     : std_logic_vector(5 downto 0) :=  "000010"; -- hex "02"
	 constant JAL     : std_logic_vector(5 downto 0) :=  "000011"; -- hex "03"
	 constant ADDI    : std_logic_vector(5 downto 0) :=  "001000"; -- hex "08"
	 constant SLTI    : std_logic_vector(5 downto 0) :=  "001010"; -- hex "0a"
	 
	 -- Funct Tipo R
	 constant ADD     : std_logic_vector(5 downto 0) :=  "100000"; -- hex "20"
	 constant SUB     : std_logic_vector(5 downto 0) :=  "100010"; -- hex "22"
	 constant op_AND  : std_logic_vector(5 downto 0) :=  "100100"; -- hex "24"
	 constant op_OR   : std_logic_vector(5 downto 0) :=  "100101"; -- hex "25"
	 constant op_SLT  : std_logic_vector(5 downto 0) :=  "101010"; -- hex "2a"
	 constant op_NOR  : std_logic_vector(5 downto 0) :=  "100111"; -- hex "27" -- Extra 1
	 
	 begin
	    
				  --  inverteA  |  inverteB  | selMux
		ULActrl <=     '0'     &    '0'    &  "10" when (funct = ADD and TipoR = '1') else
							'0'     &    '1'    &  "10" when (funct = SUB and TipoR = '1') else
							'0'     &    '0'    &  "00" when (funct= op_AND and TipoR = '1') else
							'0'     &    '0'    &  "01" when (funct= op_OR  and TipoR = '1') else
							'0'     &    '1'    &  "11" when (funct = op_SLT and TipoR = '1') else 
							'1'     &    '1'    &  "00" when (funct = op_NOR and TipoR = '1') else -- Extra 1
							
							'0'     &    '1'    &  "11" when (opcode = SLTI and TipoR = '0') else 
							'0'     &    '0'    &  "10" when (opcode = LW and TipoR = '0') else
							'0'     &    '0'    &  "10" when (opcode = SW and TipoR = '0') else
							'0'     &    '0'    &  "01" when (opcode = ORI and TipoR = '0') else
							'0'     &    '0'    &  "00" when (opcode = ANDI and TipoR = '0') else
							'0'     &    '0'    &  "10" when (opcode = ADDI and TipoR = '0') else
							'0'     &    '1'    &  "10" when (opcode = BEQ and TipoR = '0') else
							'0'     &    '1'    &  "10" when (opcode = BNE  and TipoR = '0') else
							'0'     &    '1'    &  "10"; -- (opcode = JMP or JR or JAL) 

end architecture;