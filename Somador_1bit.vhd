library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Somador_1bit is
  port (  
		C_In     : in 	std_logic;
		A, B     : in 	std_logic;
		C_Out    : out std_logic;
		Soma	 	: out std_logic
  );
  
end entity;

architecture arquitetura of Somador_1bit is

begin

	Soma <= C_In xor (A xor B);
	
	C_Out <= (A and B) or (C_In and (A xor B));

end architecture;