library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Declaracion de entidad
entity genEna_tb is
end;

-- Declaracion cuerpo de arquitectura
architecture genEna_tb_arch of genEna_tb is
  -- Parte declarativa
  component genEna is
    generic(
      N: natural := 4
    );
    port (
      rst_i: in std_logic;
      clk_i: in std_logic;
      s_o:   out std_logic
    );
    end component genEna;

  constant N_tb : natural := 4;
  signal rst_tb : std_logic := '1';
  signal clk_tb : std_logic := '0';
  signal s_tb   : std_logic;

begin
  -- Parte descriptiva

  rst_tb <= '0' after 20 ns;
  clk_tb <= not clk_tb after 10 ns;

  DUT: genEna
    generic map(
      N => N_tb
    )
    port map(
      rst_i => rst_tb,
      clk_i => clk_tb,
      s_o   => s_tb
    );            

end architecture;