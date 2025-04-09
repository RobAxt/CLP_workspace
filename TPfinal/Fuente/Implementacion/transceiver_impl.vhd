library IEEE;
use IEEE.std_logic_1164.all;

entity transceriver_impl is
  generic(
    DATA_SIZE : natural := 4;    -- Tamaño de los datos
    CICLOS    : natural := 125E4 -- Cantidad de ciclos para genEna
  );
  port (
    clk_internal     : in  std_logic;  -- reloj interno de alta frecuencia
    rst_swt          : in  std_logic;  -- switch de reset
    ena_swt          : in  std_logic;  -- switch de habilitacion
    data_btn         : in  std_logic_vector(DATA_SIZE-1 downto 0);  -- Botones para ingreso de datos
    serial_out_pin   : out std_logic;  -- Salida serial
    serial_input_pin : in  std_logic;  -- Entrada serial
    data_led         : out std_logic_vector(DATA_SIZE-1 downto 0);  -- Leds de visualizacion de datos
    valid_led        : out std_logic   -- 
  );
end transceriver_impl;

architecture structural of transceriver_impl is

  component transmitter_impl is
    generic(
      DATA_SIZE : natural := 4;    -- Tamaño de los datos
      CICLOS    : natural := 125E4 -- Cantidad de ciclos para genEna
    );
    port(
      clk_internal  : in  std_logic;                               -- Reloj
      rst_swt       : in  std_logic;                               -- Reset sincrónico
      ena_swt       : in  std_logic;                               -- Habilitador
      data_btn      : in  std_logic_vector(DATA_SIZE-1 downto 0);  -- Datos de entrada
      serial_pin    : out std_logic                                -- Salida serial
    );
  end component;

  component receiver_impl is
    generic(
      DATA_SIZE : natural := 4;    -- Tamaño de los datos
      CICLOS    : natural := 125E4 -- Cantidad de ciclos para genEna
    );
    port (
      clk_internal : in  std_logic;
      rst_swt      : in  std_logic;
      ena_swt      : in  std_logic;
      serial_pin   : in  std_logic;
      data_led     : out std_logic_vector(DATA_SIZE-1 downto 0);
      valid_led    : out std_logic
    );
  end component;

begin

  transmitter_impl_inst : transmitter_impl
    generic map(
      DATA_SIZE => DATA_SIZE,
      CICLOS => CICLOS
    )
    port map(
     clk_internal => clk_internal,
     rst_swt      => rst_swt,
     ena_swt      => ena_swt,
     data_btn     => data_btn,
     serial_pin   => serial_out_pin
    );
 
  receiver_impl_inst : receiver_impl
    generic map(
      DATA_SIZE => DATA_SIZE,
      CICLOS => CICLOS
    )
    port map(
      clk_internal => clk_internal,
      rst_swt      => rst_swt,
      ena_swt      => ena_swt,
      serial_pin   => serial_input_pin,
      data_led     => data_led,
      valid_led    => valid_led
    );
end;