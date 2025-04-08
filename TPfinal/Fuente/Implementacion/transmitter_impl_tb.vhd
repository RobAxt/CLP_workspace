library IEEE;
use IEEE.std_logic_1164.all;

entity transmitter_impl_tb is
  -- Testbench no requiere puertos
end transmitter_impl_tb;

architecture simulation of transmitter_impl_tb is

  -- Definición de constantes de parametrización
  constant DATA_SIZE : natural := 4;
  constant CICLOS    : natural := 10;  -- Overriding el valor de CICLOS para la simulación

  -- Señales de conexión con la DUT (Device Under Test)
  signal clk_tb    : std_logic := '0';
  signal rst_tb    : std_logic := '0';
  signal ena_tb    : std_logic := '0';
  signal data_tb   : std_logic_vector(DATA_SIZE-1 downto 0) := (others => '0');
  signal serial_tb : std_logic;
  
begin

  clk_tb <= not clk_tb after 10 ns;
  rst_tb <= '0' after 20 ns;
  ena_tb <= '1' after 40 ns;

  data_tb <= "1010" after 80 ns;

  -----------------------------------------------------------------------------
  -- Instancia de la unidad bajo prueba (DUT): transmitter_impl
  -----------------------------------------------------------------------------
  uut: entity work.transmitter_impl
    generic map (
      DATA_SIZE => DATA_SIZE,
      CICLOS    => CICLOS
    )
    port map (
      clk_internal => clk_tb,
      rst_swt      => rst_tb,
      ena_swt      => ena_tb,
      data_btn     => data_tb,
      serial_pin   => serial_tb
    );

end;