-- Bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de Entidad
entity mux1b is
  port (
    a_i, b_i: in std_logic;
    sel_i:  in std_logic;
    o_o:   out std_logic
  );
end;

-- Declaracion Cuerpo de Arquitectura
architecture mux1b_arq of mux1b is
  -- Parte Declarativa
begin
  -- Parte Descriptiva
  o_o <= a_i when sel_i = '0' else  b_i;
end;
