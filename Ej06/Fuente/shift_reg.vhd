-- Bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de Entidad
entity shift_reg is
  generic (N: natural := 4);
  port(
    ck_i: in std_logic; 
    rt_i: in std_logic; 
    ent_i: in std_logic;
    sal_o: out std_logic
  );
end;

-- Declaracion Cuerpo de Arquitectura
architecture shift_reg_arq of shift_reg is
  -- Parte Declarativa
  component ffd is
    port(
      clk_i: in std_logic;
      rst_i: in std_logic := '0';
      ena_i: in std_logic := '1';
      d_i: in std_logic;
      q_o: out std_logic
    );
  end component;
  
  signal d: std_logic_vector(0 to N);
  
begin
  -- Parte Descriptiva
  shift_reg_i : for i in 0 to N-1 generate
    ff_inst : ffd
       port map(
         clk_i => ck_i,
         d_i   => d(i), 
         rst_i => rt_i, 
         q_o   => d(i +1)
       );
  end generate;
  d(0) <= ent_i;
  sal_o <= d(N);
end;
