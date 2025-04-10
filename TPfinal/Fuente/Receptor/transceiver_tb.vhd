library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity transceiver_tb is
end transceiver_tb;

architecture test of transceiver_tb is

  -- Parámetros del sistema
  constant CLK_PERIOD : time := 20 ns;
  constant DATA_SIZE  : natural := 4;

  -- Señales internas
  signal clk_tb       : std_logic := '0';
  signal rst_tb       : std_logic := '0';
  signal ena_tb       : std_logic := '1';
  signal data_in_tb   : std_logic_vector(DATA_SIZE-1 downto 0) := (others => '0');
  signal serial_out_tb: std_logic := '1';
  signal serial_in_tb : std_logic := '1';
  signal data_out_tb  : std_logic_vector(DATA_SIZE-1 downto 0);
  signal valid_tb     : std_logic;

  -- DUTs
  component transmitter
    generic (
      DATA_SIZE : natural := 4
    );
    port (
      clk_i    : in  std_logic;
      rst_i    : in  std_logic;
      ena_i    : in  std_logic;
      data_i   : in  std_logic_vector(DATA_SIZE-1 downto 0);
      serial_o : out std_logic
    );
  end component;

  component receiver
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

begin
  clk_tb <= not clk_tb after 10 ns;

  -- Instanciación del Transmitter
  U_TX: transmitter
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      clk_i    => clk_tb,
      rst_i    => rst_tb,
      ena_i    => ena_tb,
      data_i   => data_in_tb,
      serial_o => serial_out_tb
    );

  -- Instanciación del Receiver
  U_RX: receiver
    generic map (
      DATA_SIZE => DATA_SIZE
    )
    port map (
      clk_i    => clk_tb,
      rst_i    => rst_tb,
      ena_i    => ena_tb,
      serial_i => serial_in_tb,
      data_o   => data_out_tb,
      valid_o  => valid_tb
    );

  -- Estímulos
  stimulus : process
  begin
    -- Reset inicial
    rst_tb <= '1';
    ena_tb <= '0';
    wait for CLK_PERIOD;
    ena_tb <= '1';
    wait for CLK_PERIOD;
    rst_tb <= '0';

    -- Primer dato: 1010
    data_in_tb <= "1010";
    
    -- Se transmite y recibe correctamente
    for i in 0 to 10 loop
      wait for CLK_PERIOD;
      serial_in_tb <= serial_out_tb;
    end loop;

    -- Se corrompe transmision
    for i in 0 to 10 loop
      wait for CLK_PERIOD;
      if i = 4 or i = 5 or i = 6 or i = 7  then
        serial_in_tb <= '0';  --  bits alterado
      else
        serial_in_tb <= serial_out_tb;
      end if;
    end loop;
    
    -- Segundo dato: 0101
    data_in_tb <= "0101"; 

    -- Se transmite y recibe correctamente
    for i in 0 to 10 loop
      wait for CLK_PERIOD;
      serial_in_tb <= serial_out_tb;
     end loop;

    -- Se corrompe transmision
    for i in 0 to 10 loop
      wait for CLK_PERIOD;
      if i = 4 or i = 5 or i = 6 or i = 7  then
        serial_in_tb <= '0';  --  bits alterado
      else
        serial_in_tb <= serial_out_tb;
      end if;
    end loop; 

    for i in 0 to 10 loop
      wait for CLK_PERIOD;
      serial_in_tb <= serial_out_tb;
     end loop;
     for i in 0 to 10 loop
      wait for CLK_PERIOD;
      serial_in_tb <= serial_out_tb;
     end loop;
    -- Se mantiene en idle la recepcion
    for i in 0 to 10 loop
     wait for CLK_PERIOD;
     serial_in_tb <= '1';
    end loop;

    -- Fin de la simulación
    wait;
  end process;

end test;
