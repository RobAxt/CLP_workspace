library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Declaracion de entidad
entity genEna is
    generic(
        N: natural := 4
    );
    port (
        rst_i: in std_logic;
        clk_i: in std_logic;
        s_o:   out std_logic
    );
end entity genEna;

-- Declaracion cuerpo de arquitectura
architecture genEna_arch of genEna is
  -- Parte declarativa

begin
  -- Parte descriptiva
  process(clk_i)
    variable count: integer range 0 to N := 0;
  begin
    if rising_edge(clk_i) then
      if rst_i = '1' then
        s_o <= '0';
        count := 0;
      else 
        count := count  + 1;
        if count = N then
          count := 0;
          s_o <= '1';
        else
          s_o <= '0';
        end if; 
      end if;
    end if;
  end process;
  
end architecture;