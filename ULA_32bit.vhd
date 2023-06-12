library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- Biblioteca IEEE para funções aritméticas

entity ULA_32bit is
    port (
		A         : in std_logic_vector(31 downto 0);
		B         : in std_logic_vector(31 downto 0);
      ULACtrl   : in std_logic_vector(3 downto 0);
		saida : out std_logic_vector(31 downto 0);
		F_Out  : out std_logic
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
		
		signal soma        : std_logic;
	 
		signal overflow    : std_logic;
	 
	   signal saida_32bit         : std_logic_vector(31 downto 0);
	 
	 
	 alias inverteA     : std_logic is ULACtrl(3);
	 alias inverteB     : std_logic is ULACtrl(2);
	 alias selecao      : std_logic_vector is ULACtrl(1 downto 0);
	 	 
	 begin
	
	 
	 Bit0 :  entity work.ULA1bit
        port map( A         => A(0),
						B         => B(0),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => inverteB,
						SLT       => overflow,
						C_out     => C_Out0,
						resultado => saida_32bit(0)
		 );
	
	 
	 Bit1 :  entity work.ULA1bit
        port map( A         => A(1),
						B         => B(1),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out0,
						SLT       => '0',
						C_out     => C_Out1,
						resultado => saida_32bit(1)
		 );		
		
	 
	 Bit2 :  entity work.ULA1bit
        port map( A         => A(2),
						B         => B(2),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out1,
						SLT       => '0',
						C_out     => C_Out2,
						resultado => saida_32bit(2)
		 );
		 
	 
	 Bit3 :  entity work.ULA1bit
        port map( A         => A(3),
						B         => B(3),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out2,
						SLT       => '0',
						C_out     => C_Out3,
						resultado => saida_32bit(3)
		 );
		 
	 
	 Bit4 :  entity work.ULA1bit
        port map( A         => A(4),
						B         => B(4),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out3,
						SLT       => '0',
						C_out     => C_Out4,
						resultado => saida_32bit(4)
		 );
		 
		 
	 
	 Bit5 :  entity work.ULA1bit
        port map( A         => A(5),
						B         => B(5),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out4,
						SLT       => '0',
						C_out     => C_Out5,
						resultado => saida_32bit(5)
		 );
		 
	 
	 Bit6 :  entity work.ULA1bit
        port map( A         => A(6),
						B         => B(6),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out5,
						SLT       => '0',
						C_out     => C_Out6,
						resultado => saida_32bit(6)
		 );
		 
	 
	 Bit7 :  entity work.ULA1bit
        port map( A         => A(7),
						B         => B(7),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out6,
						SLT       => '0',
						C_out     => C_Out7,
						resultado => saida_32bit(7)
		 );
		 
	 
	 Bit8 :  entity work.ULA1bit
        port map( A         => A(8),
						B         => B(8),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out7,
						SLT       => '0',
						C_out     => C_Out8,
						resultado => saida_32bit(8)
		 );
		 
	 
	 Bit9 :  entity work.ULA1bit
        port map( A         => A(9),
						B         => B(9),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out8,
						SLT       => '0',
						C_out     => C_Out9,
						resultado => saida_32bit(9)
		 );
	 
	 Bit10 :  entity work.ULA1bit
        port map( A         => A(10),
						B         => B(10),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out9,
						SLT       => '0',
						C_out     => C_Out10,
						resultado => saida_32bit(10)
		 );
		 
	 
	 Bit11 :  entity work.ULA1bit
        port map( A         => A(11),
						B         => B(11),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out10,
						SLT       => '0',
						C_out     => C_Out11,
						resultado => saida_32bit(11)
		 );		
		
	 
	 Bit12 :  entity work.ULA1bit
        port map( A         => A(12),
						B         => B(12),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out11,
						SLT       => '0',
						C_out     => C_Out12,
						resultado => saida_32bit(12)
		 );
		 
	 
	 Bit13 :  entity work.ULA1bit
        port map( A         => A(13),
						B         => B(13),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out12,
						SLT       => '0',
						C_out     => C_Out13,
						resultado => saida_32bit(13)
		 );
		 
	 
	 Bit14 :  entity work.ULA1bit
        port map( A         => A(14),
						B         => B(14),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out13,
						SLT       => '0',
						C_out     => C_Out14,
						resultado => saida_32bit(14)
		 );
		 
		 	 
	 Bit15 :  entity work.ULA1bit
        port map( A         => A(15),
						B         => B(15),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out14,
						SLT       => '0',
						C_out     => C_Out15,
						resultado => saida_32bit(15)
		 );
		 
	 
	 Bit16 :  entity work.ULA1bit
        port map( A         => A(16),
						B         => B(16),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out15,
						SLT       => '0',
						C_out     => C_Out16,
						resultado => saida_32bit(16)
		 );
		 
	 
	 Bit17 :  entity work.ULA1bit
        port map( A         => A(17),
						B         => B(17),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out16,
						SLT       => '0',
						C_out     => C_Out17,
						resultado => saida_32bit(17)
		 );
		 
	 
	 Bit18 :  entity work.ULA1bit
        port map( A         => A(18),
						B         => B(18),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out17,
						SLT       => '0',
						C_out     => C_Out18,
						resultado => saida_32bit(18)
		 );
		 
	 
	 Bit19 :  entity work.ULA1bit
        port map( A         => A(19),
						B         => B(19),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out18,
						SLT       => '0',
						C_out     => C_Out19,
						resultado => saida_32bit(19)
		 );
	 
	 Bit20 :  entity work.ULA1bit
        port map( A         => A(20),
						B         => B(20),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out19,
						SLT       => '0',
						C_out     => C_Out20,
						resultado => saida_32bit(20)
		 );
		 
	 
	 Bit21 :  entity work.ULA1bit
        port map( A         => A(21),
						B         => B(21),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out20,
						SLT       => '0',
						C_out     => C_Out21,
						resultado => saida_32bit(21)
		 );		
		
	 
	 Bit22 :  entity work.ULA1bit
        port map( A         => A(22),
						B         => B(22),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out21,
						SLT       => '0',
						C_out     => C_Out22,
						resultado => saida_32bit(22)
		 );
		 
	 
	 Bit23 :  entity work.ULA1bit
        port map( A         => A(23),
						B         => B(23),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out22,
						SLT       => '0',
						C_out     => C_Out23,
						resultado => saida_32bit(23)
		 );
		 
	 
	 BIT24 :  entity work.ULA1bit
        port map( A         => A(24),
						B         => B(24),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out23,
						SLT       => '0',
						C_out     => C_Out24,
						resultado => saida_32bit(24)
		 );
		 
		 
	 
	 BIT25 :  entity work.ULA1bit
        port map( A         => A(25),
						B         => B(25),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out24,
						SLT       => '0',
						C_out     => C_Out25,
						resultado => saida_32bit(25)
		 );
		 
	 
	 Bit26 :  entity work.ULA1bit
        port map( A         => A(26),
						B         => B(26),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out25,
						SLT       => '0',
						C_out     => C_Out26,
						resultado => saida_32bit(26)
		 );
		 
	 
	 Bit27 :  entity work.ULA1bit
        port map( A         => A(27),
						B         => B(27),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out26,
						SLT       => '0',
						C_out     => C_Out27,
						resultado => saida_32bit(27)
		 );
		 
	 
	 Bit28 :  entity work.ULA1bit
        port map( A         => A(28),
						B         => B(28),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out27,
						SLT       => '0',
						C_out     => C_Out28,
						resultado => saida_32bit(28)
		 );
		 
	 
	 Bit29 :  entity work.ULA1bit
        port map( A         => A(29),
						B         => B(29),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out28,
						SLT       => '0',
						C_out     => C_Out29,
						resultado => saida_32bit(29)
		 );
	 
	 Bit30 :  entity work.ULA1bit
        port map( A         => A(30),
						B         => B(30),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out29,
						SLT       => '0',
						C_out     => C_Out30,
						resultado => saida_32bit(30)
		 );
	
	 
	 Bit31 :  entity work.ULA31bit
        port map( A         => A(31),
						B         => B(31),
						inverteA  => inverteA,
						inverteB  => inverteB,
						selecao   => selecao,
						C_In      => C_Out30,
						SLT       => '0',
						C_out     => C_Out31,
						resultado => saida_32bit(31),
						overflow  => overflow
		 );
		  
   saida <= saida_32bit;
	
	F_Out   <= not(saida_32bit(31) or saida_32bit(30) or saida_32bit(29) or saida_32bit(28) or saida_32bit(27) 
	or saida_32bit(26) or saida_32bit(25) or saida_32bit(24) or saida_32bit(23) or saida_32bit(22) or saida_32bit(21) 
	or saida_32bit(20) or saida_32bit(19) or saida_32bit(18) or saida_32bit(17) or saida_32bit(16) or saida_32bit(15) or 
	saida_32bit(14) or saida_32bit(13) or saida_32bit(12) or saida_32bit(11) or saida_32bit(10) or saida_32bit(9) or 
	saida_32bit(8) or saida_32bit(7) or saida_32bit(6) or saida_32bit(5) or saida_32bit(4) or
	saida_32bit(3) or saida_32bit(2) or saida_32bit(1) or saida_32bit(0));
	
	
end architecture;