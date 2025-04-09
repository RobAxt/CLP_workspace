library IEEE;
use IEEE.std_logic_1164.all;

entity receiver_impl is
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
end receiver_impl;

architecture structural of receiver_impl is

  -- Declaracion de componentes
  component receiver is
    generic (
      DATA_SIZE : natural := 4
    );
    port (
      clk_i    : in  std_logic;
      rst_i    : in  std_logic;
      ena_i    : in  std_logic;
      serial_i : in  std_logic;
      data_o   : out std_logic_vector(DATA_SIZE-1 downto 0);
      valid_o  : out std_logic
    );
  end component;

  component meta_harden is
    port(
      clk_dst    : in  std_logic;
      rst_dst    : in  std_logic;
      signal_src : in  std_logic;
      signal_dst : out std_logic
    );
  end component;

  component genEna is
    generic(
      N : natural := 1250000
    );
    port (
      rst_i : in  std_logic;
      clk_i : in  std_logic;
      s_o   : out std_logic
    );
  end component;

  -- Declaracion de senales internas
  signal rst_harden  : std_logic;
  signal ena_gen     : std_logic;
  signal ena_rx      : std_logic;
  signal ena_harden  : std_logic;
  signal serial_input_harden : std_logic;
  
begin

  -- Lógica para habilitación final
  ena_rx <= ena_gen and ena_harden;

  -- Instancia para “endurecer” la señal de reset
  meta_rst_inst : meta_harden
    port map(
      clk_dst    => clk_internal,
      rst_dst    => '0',        -- Se asume que no necesitas reset aquí
      signal_src => rst_swt,
      signal_dst => rst_harden
    );

  -- Instancia para “endurecer” la señal de enable
  meta_ena_inst : meta_harden
    port map(
      clk_dst    => clk_internal,
      rst_dst    => rst_harden,
      signal_src => ena_swt,
      signal_dst => ena_harden
    );
  
  -- Instancias para “endurecer” la señal de entrada de datos seriales
  meta_serial_inst : meta_harden
    port map(
      clk_dst    => clk_internal,
      rst_dst    => rst_harden,
      signal_src => serial_pin,
      signal_dst => serial_input_harden
    );

  receiver_inst : receiver
    generic map(
      DATA_SIZE => DATA_SIZE
    )
    port map(
      clk_i    => clk_internal,
      rst_i    => rst_harden,
      ena_i    => ena_rx,
      serial_i => serial_input_harden,
      data_o   => data_led,
      valid_o  => valid_led
    );
    
  -- Instancia del generador de enable
  genEna_inst : genEna
    generic map(
      N => CICLOS
    )
    port map(
      rst_i => rst_harden,
      clk_i => clk_internal,
      s_o   => ena_gen
    );
end;