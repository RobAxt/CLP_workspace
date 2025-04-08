library IEEE;
use IEEE.std_logic_1164.all;

entity transmitter_impl is
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
end transmitter_impl;

architecture structural of transmitter_impl is

  -- Sección de componentes
  component transmitter is
    generic(
      DATA_SIZE : natural := 4  -- Tamaño de los datos
    );
    port(
      clk_i    : in  std_logic;
      rst_i    : in  std_logic;
      ena_i    : in  std_logic;
      data_i   : in  std_logic_vector(DATA_SIZE-1 downto 0);
      serial_o : out std_logic
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

  -- Sección de señales internas
  signal rst_harden  : std_logic;
  signal ena_gen     : std_logic;
  signal ena_tx      : std_logic;
  signal ena_harden  : std_logic;
  signal btn_harden  : std_logic_vector(DATA_SIZE-1 downto 0);

begin
  
  -- Lógica para habilitación final
  ena_tx <= ena_gen and ena_harden;

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

  -- Generar instancias de meta_harden para cada bit del data_btn
  meta_btn_loop : for i in 0 to DATA_SIZE-1 generate
    meta_btn_inst : meta_harden
      port map(
        clk_dst    => clk_internal,
        rst_dst    => rst_harden,
        signal_src => data_btn(i),
        signal_dst => btn_harden(i)
      );
  end generate meta_btn_loop;

  -- Instancia del transmisor
  transmitter_inst : transmitter
    generic map(
      DATA_SIZE => DATA_SIZE
    )
    port map(
      clk_i    => clk_internal,
      rst_i    => rst_harden,
      ena_i    => ena_tx,
      data_i   => btn_harden,
      serial_o => serial_pin
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

end structural;
