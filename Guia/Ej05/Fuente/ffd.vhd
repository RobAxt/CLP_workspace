-- Bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de Entidad
entity ffd is
  port(
    clk_i: in std_logic;
    rst_i: in std_logic;
    ena_i: in std_logic;
    d_i: in std_logic;
    q_o: out std_logic
  );
end;

-- Declaracion Cuerpo de Arquitectura
architecture ffd_arq of ffd is
  -- Parte Declarativa
begin
  -- Parte Descriptiva
  process(clk_i)
  begin
    if rising_edge(clk_i) then
      if rst_i = '1' then
        q_o <= '0';
      elsif ena_i = '1' then
        q_o <= d_i;
      end if;
    end if;
  end process;
end;
