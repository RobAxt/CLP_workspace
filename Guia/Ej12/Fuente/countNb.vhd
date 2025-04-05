-- Bibliotecas
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

-- Declaracion de entidad
entity countNb is
  generic(
    N : natural := 4
  );
  port (
    clk_i : in std_logic;
    rst_i : in std_logic;
    ena_i : in std_logic;
    cuenta_o : out std_logic_vector(N-1 downto 0)
  );
end;

-- Declaracion cuerpo de arquitectura
architecture countNb_arq of countNb is
  -- Parte declarativa
  signal salReg, salSum : std_logic_vector(N-1 downto 0);

  component reg is
    generic(
      N : natural := 4
    );
    port(
      clk_i	: in std_logic;                       -- clock
      rst_i	: in std_logic;                       -- reset sincronico
      ena_i	: in std_logic;                       -- habilitador
      d_i		: in std_logic_vector(N-1 downto 0);  -- dato de entrada
      q_o		: out std_logic_vector(N-1 downto 0)  -- dato de salida
    );
  end component;

begin
  salSum <= std_logic_vector( unsigned(salReg) + to_unsigned(1,N) );
  cuenta_o <= salReg;

  reg_inst : reg
  generic map(
    N => N
  )
  port map(
    clk_i => clk_i,
    rst_i => rst_i,
    ena_i => ena_i,
    d_i   => salSum,
    q_o   => salReg
  );
end;

