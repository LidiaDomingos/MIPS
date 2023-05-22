library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- Biblioteca IEEE para funções aritméticas

entity ULA_32bit is
    port (
      A, B     : in  std_logic_vector(31 downto 0);
      Seletor  : in  std_logic_vector(1 downto 0);
		InverteB : in  std_logic;
		F_Out    : out std_logic;
      Saida    : out std_logic_vector(31 downto 0)
    );
end entity;

architecture comportamento of ULA_32bit is

   signal C_Out0 : std_logic;
	signal C_Out1 : std_logic;
	signal C_Out2 : std_logic;
	signal C_Out3 : std_logic;
	signal C_Out4 : std_logic;
	signal C_Out5 : std_logic;
	signal C_Out6 : std_logic;
	signal C_Out7 : std_logic;
	signal C_Out8 : std_logic;
	signal C_Out9 : std_logic;
	signal C_Out10 : std_logic;
	signal C_Out11 : std_logic;
	signal C_Out12 : std_logic;
	signal C_Out13 : std_logic;
	signal C_Out14 : std_logic;
	signal C_Out15 : std_logic;
	signal C_Out16 : std_logic;
	signal C_Out17 : std_logic;
	signal C_Out18 : std_logic;
	signal C_Out19 : std_logic;
	signal C_Out20 : std_logic;
	signal C_Out21 : std_logic;
	signal C_Out22 : std_logic;
	signal C_Out23 : std_logic;
	signal C_Out24 : std_logic;
	signal C_Out25 : std_logic;
	signal C_Out26 : std_logic;
	signal C_Out27 : std_logic;
	signal C_Out28 : std_logic;
	signal C_Out29 : std_logic;
	signal C_Out30 : std_logic;
	signal C_Out31 : std_logic;
	
	signal saida31 : std_logic;
	signal Not_B   : std_logic;
	signal saida_ULA   : std_logic_vector(31 downto 0);
	
    begin
	 
	 Bit0 : entity work.ULA_1bit
				port map( A => A(0), 
							 B => B(0), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => InverteB, 
							 SLT => (C_Out30 xor C_Out31) xor saida31, 
							 C_out => C_Out0, 
							 Saida => saida_ULA(0));
							 
	 Bit1 : entity work.ULA_1bit
				port map( A => A(1), 
							 B => B(1), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out0, 
							 SLT => '0', 
							 C_out => C_Out1, 
							 Saida => saida_ULA(1));
							 
	 Bit2 : entity work.ULA_1bit
				port map( A => A(2), 
							 B => B(2), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out1, 
							 SLT => '0', 
							 C_out => C_Out2, 
							 Saida => saida_ULA(2));
	 
	 Bit3 : entity work.ULA_1bit
				port map( A => A(3), 
							 B => B(3), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out2, 
							 SLT => '0', 
							 C_out => C_Out3, 
							 Saida => saida_ULA(3));
							 
	 Bit4 : entity work.ULA_1bit
				port map( A => A(4), 
							 B => B(4), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out3, 
							 SLT => '0', 
							 C_out => C_Out4, 
							 Saida => saida_ULA(4));
							 
	 Bit5 : entity work.ULA_1bit
				port map( A => A(5), 
							 B => B(5), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out4, 
							 SLT => '0', 
							 C_out => C_Out5, 
							 Saida => saida_ULA(5));
							 
	 Bit6 : entity work.ULA_1bit
				port map( A => A(6), 
							 B => B(6), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out5, 
							 SLT => '0', 
							 C_out => C_Out6, 
							 Saida => saida_ULA(6));
							 
	 Bit7 : entity work.ULA_1bit
				port map( A => A(7), 
							 B => B(7), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out6, 
							 SLT => '0', 
							 C_out => C_Out7, 
							 Saida => saida_ULA(7));
							 
	 Bit8 : entity work.ULA_1bit
				port map( A => A(8), 
							 B => B(8), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out7, 
							 SLT => '0', 
							 C_out => C_Out8, 
							 Saida => saida_ULA(8));
							 
	 Bit9 : entity work.ULA_1bit
				port map( A => A(9), 
							 B => B(9), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out8, 
							 SLT => '0', 
							 C_out => C_Out9, 
							 Saida => saida_ULA(9));
							 
	 Bit10 : entity work.ULA_1bit
				port map( A => A(10), 
							 B => B(10), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out9, 
							 SLT => '0', 
							 C_out => C_Out10, 
							 Saida => saida_ULA(10));
							 
	 Bit11 : entity work.ULA_1bit
				port map( A => A(11), 
							 B => B(11), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out10, 
							 SLT => '0', 
							 C_out => C_Out11, 
							 Saida => saida_ULA(11));
							 
	 Bit12 : entity work.ULA_1bit
				port map( A => A(12), 
							 B => B(12), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out11, 
							 SLT => '0', 
							 C_out => C_Out12, 
							 Saida => saida_ULA(12));
							 
	 Bit13 : entity work.ULA_1bit
				port map( A => A(13), 
							 B => B(13), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out12, 
							 SLT => '0', 
							 C_out => C_Out13, 
							 Saida => saida_ULA(13));
							 
	 Bit14 : entity work.ULA_1bit
				port map( A => A(14), 
							 B => B(14), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out13, 
							 SLT => '0', 
							 C_out => C_Out14, 
							 Saida => saida_ULA(14));
							 
	 Bit15 : entity work.ULA_1bit
				port map( A => A(15), 
							 B => B(15), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out14, 
							 SLT => '0', 
							 C_out => C_Out15, 
							 Saida => saida_ULA(15));
							 
	 Bit16 : entity work.ULA_1bit
				port map( A => A(16), 
							 B => B(16), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out15, 
							 SLT => '0', 
							 C_out => C_Out16, 
							 Saida => saida_ULA(16));
							 
	 Bit17 : entity work.ULA_1bit
				port map( A => A(17), 
							 B => B(17), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out16, 
							 SLT => '0', 
							 C_out => C_Out17, 
							 Saida => saida_ULA(17));
							 
	 Bit18 : entity work.ULA_1bit
				port map( A => A(18), 
							 B => B(18), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out17, 
							 SLT => '0', 
							 C_out => C_Out18, 
							 Saida => saida_ULA(18));

	 Bit19 : entity work.ULA_1bit
				port map( A => A(19), 
							 B => B(19), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out18, 
							 SLT => '0', 
							 C_out => C_Out19, 
							 Saida => saida_ULA(19));
							
	 Bit20 : entity work.ULA_1bit
				port map( A => A(20), 
							 B => B(20), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out19, 
							 SLT => '0', 
							 C_out => C_Out20, 
							 Saida => saida_ULA(20));
							
	 Bit21 : entity work.ULA_1bit
				port map( A => A(21), 
							 B => B(21), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out20, 
							 SLT => '0', 
							 C_out => C_Out21, 
							 Saida => saida_ULA(21));
							 
	 Bit22 : entity work.ULA_1bit
				port map( A => A(22), 
							 B => B(22), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out21, 
							 SLT => '0', 
							 C_out => C_Out22, 
							 Saida => saida_ULA(22));
							 
	 Bit23 : entity work.ULA_1bit
				port map( A => A(23), 
							 B => B(23), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out22, 
							 SLT => '0', 
							 C_out => C_Out23, 
							 Saida => saida_ULA(23));
							 
	 Bit24 : entity work.ULA_1bit
				port map( A => A(24), 
							 B => B(24), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out23, 
							 SLT => '0', 
							 C_out => C_Out24, 
							 Saida => saida_ULA(24));
							 
	 Bit25 : entity work.ULA_1bit
				port map( A => A(25), 
							 B => B(25), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out24, 
							 SLT => '0', 
							 C_out => C_Out25, 
							 Saida => saida_ULA(25));
							 
	 Bit26 : entity work.ULA_1bit
				port map( A => A(26), 
							 B => B(26), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out25, 
							 SLT => '0', 
							 C_out => C_Out26, 
							 Saida => saida_ULA(26));
							 
	 Bit27 : entity work.ULA_1bit
				port map( A => A(27), 
							 B => B(27), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out26, 
							 SLT => '0', 
							 C_out => C_Out27, 
							 Saida => saida_ULA(27));
							 
	 Bit28 : entity work.ULA_1bit
				port map( A => A(28), 
							 B => B(28), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out27, 
							 SLT => '0', 
							 C_out => C_Out28, 
							 Saida => saida_ULA(28));
							 
	 Bit29 : entity work.ULA_1bit
				port map( A => A(29), 
							 B => B(29), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out28, 
							 SLT => '0', 
							 C_out => C_Out29, 
							 Saida => saida_ULA(29));
							 
	 Bit30 : entity work.ULA_1bit
				port map( A => A(30), 
							 B => B(30), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out29, 
							 SLT => '0', 
							 C_out => C_Out30, 
							 Saida => saida_ULA(30));
							 
	 Bit31 : entity work.ULA_1bit
				port map( A => A(31), 
							 B => B(31), 
							 Seletor => Seletor, 
							 InverteB => InverteB, 
							 C_In => C_Out30, 
							 SLT => '0', 
							 C_out => C_Out31, 
							 Saida => saida_ULA(31));
	
	Not_B <= not B(31) when InverteB = '1' else B(31);
							 
	saida31 <= C_Out30 xor (A(31) xor Not_B); 
	Saida <= saida_ULA;
							 
	F_Out <= '1' when saida_ULA = x"00000000" else '0';	
							 
							 
					
end architecture;