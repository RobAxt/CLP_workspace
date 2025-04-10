library IEEE;
use IEEE.std_logic_1164.all;

entity transceriver_impl_tb is
end;

architecture simulation of transceriver_impl_tb is

  -- Definición de constantes de parametrización
  constant DATA_SIZE : natural := 4;
  constant CICLOS    : natural := 125;  -- Overriding el valor de CICLOS para la simulación

  -- Señales de conexión con la DUT (Device Under Test)
  signal clk_tb    : std_logic := '0';
  signal rst_tb    : std_logic := '1';
  signal ena_tb    : std_logic := '1';
  signal data_in_tb   : std_logic_vector(DATA_SIZE-1 downto 0) := "1010";
  signal data_out_tb  : std_logic_vector(DATA_SIZE-1 downto 0);
  signal serial_tb    : std_logic;
  signal valid_tb     : std_logic;

begin

  clk_tb <= not clk_tb after 4 ns;
  rst_tb <= '0' after 1 us;

  dut: entity work.transceriver_impl
    generic map(
      DATA_SIZE => DATA_SIZE,
      CICLOS    => CICLOS
    )
    port map(
      clk_internal     => clk_tb,
      rst_swt          => rst_tb,
      ena_swt          => ena_tb,
      data_btn         => data_in_tb,
      serial_out_pin   => serial_tb,
      serial_input_pin => serial_tb,
      data_led         => data_out_tb,
      valid_led        => valid_tb
    );

end;