-- Bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de Entidad
entity sumrest4b is
  port(
    a_i:  in  std_logic_vector(3 downto 0);
    b_i:  in  std_logic_vector(3 downto 0);
    sr_i: in  std_logic;  -- sr_i = 1 resta
    s_o:  out std_logic_vector(3 downto 0);
    co_o: out std_logic
  );
end;

-- Declaracion Cuerpo de Arquitectura
architecture sumrest4b_arq of sumrest4b is
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

  signal b_mod: std_logic_vector(3 downto 0);
  
begin
  
  b_mod <= b_i xor std_logic_vector'(3 downto 0 => sr_i);
  
  sum4b_inst : sum4b
    port map (
      a_i => a_i,
      b_i => b_mod,
      ci_i =>  sr_i,
      s_o => s_o,
      co_o => co_o
    );
  
end;
