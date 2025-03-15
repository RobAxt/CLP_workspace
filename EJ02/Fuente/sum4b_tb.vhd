-- Bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de Entidad
entity sum4b_tb is
end;

-- Declaracion Cuerpo de Arquitectura
architecture sum4b_arq_tb of sum4b_tb is
  -- Declaracion de componentes
  component sum4b is
    port(
      a_i:  in  std_logic_vector(3 downto 0);
      b_i:  in  std_logic_vector(3 downto 0);
      ci_i: in  std_logic;
      s_o:  out std_logic_vector(3 downto 0);
      co_o: out std_logic
    );
  end component;
  
	-- Senales de prueba
	signal a_tb: std_logic_vector(3 downto 0) := "0101";
	signal b_tb: std_logic_vector(3 downto 0) := "0110";
	signal ci_tb: std_logic := '0';
	signal s_tb: std_logic_vector(3 downto 0);
	signal co_tb: std_logic;
	
begin
	-- Senales de excitacion
	ci_tb <= '1' after 50 ns;

	-- Instanciacion del componente a probar
	DUT: sum4b
		port map(
			a_i		=> a_tb,
			b_i 	=> b_tb,
			ci_i 	=> ci_tb,
			s_o 	=> s_tb,
			co_o	=> co_tb
		);
end;
