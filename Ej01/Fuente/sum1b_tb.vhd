-- Bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de Entidad
entity sum1b_tb is
end;

-- Declaracion Cuerpo de Arquitectura
architecture sum1b_tb_arq of sum1b_tb is
  -- Parte Declarativa
  -- Declaracion de Componentes
  component sum1b is
    port(
		  a_i:  in  std_logic;
      b_i:  in  std_logic;
      ci_i: in  std_logic;
      s_o:  out std_logic;
      co_o: out std_logic
  );
  end component;

  -- Declaracion de senales de prueba
  signal a_tb:  std_logic := '1';
  signal b_tb:  std_logic := '1';
  signal ci_tb: std_logic := '0';
  signal s_tb:  std_logic;
  signal co_tb: std_logic;
	
begin
  -- Parte Descriptiva
  ci_tb <= '1' after 200 ns;
	a_tb  <= '0' after 100 ns, '1' after 200 ns, '0' after 300 ns;
  b_tb  <= '0' after  50 ns, '1' after 100 ns, '0' after 150 ns, '1' after 200 ns,'0' after  250 ns, '1' after 300 ns, '0' after 350 ns, '1' after 400 ns;

  
  DUT: entity work.sum1b
    port map(
      a_i  => a_tb,
      b_i  => b_tb,
      ci_i => ci_tb,
      s_o  => s_tb,
      co_o => co_tb
    );
end;
