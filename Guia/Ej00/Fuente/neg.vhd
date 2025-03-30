-- Bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de Entidad
entity neg is
	port(
		a_i: in std_logic;
		b_o: out std_logic
	);
end;

-- Declaracion Cuerpo de Arquitectura
architecture neg_arq of neg is
  -- Parte Declarativa
begin
  -- Parte Descriptiva
	b_o <= not a_i;
end;
