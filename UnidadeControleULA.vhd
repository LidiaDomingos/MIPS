library ieee;
use ieee.std_logic_1164.all;

entity UnidadeControleULA is
  port ( ULAop   : in  std_logic_vector(1 downto 0);
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
  
  constant R: std_logic_vector(1 downto 0) := "00";
  constant LW    : std_logic_vector(1 downto 0) := "01";
  constant SW    : std_logic_vector(1 downto 0) := "10";
  constant BEQ   : std_logic_vector(1 downto 0) := "11";
    
  begin
  
ULActrl <= "000" when (funct = OP_AND and ULAop = R) else
           "001" when (funct = OP_OR  and ULAop = R) else
			  "010" when (funct = SOMA   and ULAop = R) else
			  "110" when (funct = SUB    and ULAop = R) else
		     "111" when (funct = SLT    and ULAop = R) else
		     "010" when (ULAop = LW)    else
			  "010" when (ULAop = SW)    else
			  "110" when (ULAop = BEQ);  
end architecture;