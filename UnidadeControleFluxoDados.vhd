library ieee;
use ieee.std_logic_1164.all;

entity UnidadeControleFluxoDados is
  port ( opcode : in std_logic_vector(5 downto 0);
         saida_controle : out std_logic_vector(9 downto 0)
  );
end entity;

architecture comportamento of UnidadeControleFluxoDados is
  
  constant LW     : std_logic_vector(5 downto 0) := "100011";
  constant SW     : std_logic_vector(5 downto 0) := "101011";
  constant BEQ    : std_logic_vector(5 downto 0) := "000100";
  
  constant JMP    : std_logic_vector(5 downto 0) := "000010";
  
  constant R      : std_logic_vector(5 downto 0) := "000000";

  begin 
    -- mux[PC+4, BEQ]/JMP | muxRT/RD | habEscRegULA | muxRT/Im | ULAOP | muxULA/mem | BEQ | RD | WR  
	saida_controle <= "0110000000" when (opcode = R)     else
							"0011011010" when (opcode = LW)    else
							"0001100001" when (opcode = SW)    else
							"0000110100" when (opcode = BEQ)   else
							"1000000000" when (opcode = JMP)   else
							"0000100000";  
end architecture;