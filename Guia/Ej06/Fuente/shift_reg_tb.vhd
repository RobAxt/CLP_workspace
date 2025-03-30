-- Bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de Entidad
entity shift_reg_tb is
end;

-- Declaracion Cuerpo de Arquitectura
architecture shift_reg_arq_tb of shift_reg_tb is
  -- Declaracion de componentes
  component shift_reg is
    generic (N: natural := 4);
      port(
        ck_i: in std_logic; 
        rt_i: in std_logic; 
        ent_i: in std_logic;
        sal_o: out std_logic
      );
  end component;
  
  constant N_tb: natural := 4;
  
	-- Senales de prueba
  signal clk_tb : std_logic := '0';
  signal rst_tb : std_logic := '0'; 
  signal ent_tb : std_logic := '0';
  signal sal_tb : std_logic;
	
begin
	-- Senales de excitacion
  clk_tb <= not clk_tb after 10 ns;
  ent_tb <= not ent_tb after 16 ns;
  
	-- Instanciacion del componente a probar
	DUT: shift_reg
		generic map(
			N => N_tb
		)
    port map(
      ck_i  => clk_tb,
      rt_i   => rst_tb,
      ent_i  => ent_tb,
      sal_o  => sal_tb
    );
end;

