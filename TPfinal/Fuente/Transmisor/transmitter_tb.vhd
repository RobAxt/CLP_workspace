library IEEE;
use IEEE.std_logic_1164.all;

entity transmitter_tb is
end;

architecture transmitter_tb_arq of transmitter_tb is
  component transmitter is
    generic(
      DATA_SIZE : natural := 4
    );
    port(
      clk_i    : in std_logic;                              -- Clock
      rst_i    : in std_logic;                              -- Synchronous reset
      ena_i    : in  std_logic;                             -- Habilitador
      data_i   : in std_logic_vector(DATA_SIZE-1 downto 0); -- Data inputs
      serial_o : out std_logic                              -- Serial data output
    );
  end component;

  constant DATA_SIZE_tb : natural := 4;
  signal clk_tb         : std_logic := '0';
  signal rst_tb         : std_logic := '1';
  signal ena_tb         : std_logic := '1';
  signal data_tb        : std_logic_vector (DATA_SIZE_tb-1 downto 0) := "0010";
  signal serial_tb      : std_logic;
begin
  clk_tb <= not clk_tb after 10 ns;
  rst_tb <= '0' after 20 ns;

  trans_inst : transmitter
    generic map(
      DATA_SIZE => DATA_SIZE_tb
    )
    port map(
      clk_i    => clk_tb,
      rst_i    => rst_tb,
      ena_i    => ena_tb,
      data_i   => data_tb,
      serial_o => serial_tb
    );
end;