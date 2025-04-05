-- Bibliotecas
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;


-- Declaracion de entidad
entity countBCD_tb is
end;

-- Declaracion de arquitectura
architecture countBCD_arq of countBCD_tb is
  -- Parte declarativa
  component countBCD is
    generic(
      N		: natural := 4
    );
    port(
      clk_i   : in std_logic;
      rst_i   : in std_logic;
      ena_i   : in std_logic;
      cuenta_o : out std_logic_vector(N-1 downto 0)
    );
  end component countBCD;

  constant N_tb : natural := 4;

  signal clk_tb   : std_logic := '0';
  signal rst_tb   : std_logic := '1';
  signal ena_tb   : std_logic := '1';
  signal cuenta_tb : std_logic_vector(N_tb-1 downto 0);

begin
  -- Parte descriptiva
  clk_tb  <= not clk_tb after 10 ns;
  rst_tb  <= '0' after 40 ns, '1' after 300 ns, '0' after 325 ns;
  ena_tb  <= '0' after 400 ns, '1' after 430 ns;

  DUT: entity work.countBCD(countBCD_behavior_arq)
    generic map (
      N => N_tb
    )
    port map(
      clk_i   => clk_tb,
      rst_i   => rst_tb,
      ena_i   => ena_tb,
      cuenta_o => cuenta_tb
    );
end countBCD_arq;