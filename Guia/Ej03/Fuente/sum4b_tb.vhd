-- Bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de Entidad
entity sumrest4b_tb is
end;

-- Declaracion Cuerpo de Arquitectura
architecture sumrest4b_arq_tb of sumrest4b_tb is
  -- Declaracion de componentes
  component sumrest4b is
    port(
      a_i:  in  std_logic_vector(3 downto 0);
      b_i:  in  std_logic_vector(3 downto 0);
      sr_i: in  std_logic;
      s_o:  out std_logic_vector(3 downto 0);
      co_o: out std_logic
    );
  end component;
  
	-- Senales de prueba
	signal a_tb: std_logic_vector(3 downto 0) := "0111";
	signal b_tb: std_logic_vector(3 downto 0) := "0100";
	signal sr_tb: std_logic := '0';
	signal s_tb: std_logic_vector(3 downto 0);
	signal co_tb: std_logic;
	
begin
	-- Senales de excitacion
	sr_tb <= '1' after 50 ns;

	-- Instanciacion del componente a probar
	DUT: sumrest4b
		port map(
			a_i		=> a_tb,
			b_i 	=> b_tb,
			sr_i 	=> sr_tb,
			s_o 	=> s_tb,
			co_o	=> co_tb
		);
end;

--          ┌──────────────────────SUM─REST─4B───────────────────────────────────┐            
--          │                                                                    │            
--          │                                      ┌─────SUM─4B──────┐           │            
--        4 │                                    4 │                 │           │            
-- a_tb  ───┤  a_i  ───────────────────────────────┤a_i              │ 4         │            
-- b_tb  ───┤  b_i  ─────────────────────────┐     │            s_o  ├───  s_o   ├─────  s_tb 
--        4 │                          4     │   4 │                 │           │            
--          │                               XOR ───┤b_i              │           │            
--          │                          4     │     │                 │ 1         │            
--          │          ┌────sr_i(4) ─────────┘   1 │            co_o ├───  co_o  ├─────  co_tb
--        1 │          │                           │                 │           │            
-- s_tb  ───┼ sr_i(1)──┴───────────────────────────┤ci_i             │           │            
--          │                                      │                 │           │            
--          │                                      └─────────────────┘           │            
--          │                                                                    │            
--          └────────────────────────────────────────────────────────────────────┘            
