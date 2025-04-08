library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity receiver is
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
end receiver;

architecture behavioral of receiver is
  constant CRC_SIZE    : natural := 3;
  constant FRAME_SIZE  : natural := 1 + DATA_SIZE + CRC_SIZE;
  constant IDLE        : std_logic := '1';

  type state_type is (IDLE_STATE, RECEIVING);
  signal state      : state_type := IDLE_STATE;
  signal shift_reg  : std_logic_vector(FRAME_SIZE-1 downto 0) := (others => '1');
  signal bit_count  : integer range 0 to FRAME_SIZE := 0;

  --Funcion CRC3 estilo LFSR (procesa de MSB a LSB)
  function crc3_lfsr(data : std_logic_vector(3 downto 0)) return std_logic_vector is
    variable shift_reg : std_logic_vector(2 downto 0) := (others => '0');
    variable d : std_logic;
  begin
    for i in data'range loop
      d := data(i) xor shift_reg(2);
      shift_reg(2) := shift_reg(1);
      shift_reg(1) := shift_reg(0) xor d;
      shift_reg(0) := d;
    end loop;
    return shift_reg;
  end function;

begin

  process(clk_i)
    -- Extraer datos y CRC
    variable data_rx : std_logic_vector(DATA_SIZE-1 downto 0);
    variable crc_rx  : std_logic_vector(CRC_SIZE-1 downto 0);
    variable crc_calc: std_logic_vector(CRC_SIZE-1 downto 0);
  begin
    if rising_edge(clk_i) then
      if rst_i = '1' then
        shift_reg <= (others => '1');
        bit_count <= 0;
        state <= IDLE_STATE;
        valid_o <= '0';
        data_o <= (others => '0');
      elsif ena_i = '1' then
        case state is
          when IDLE_STATE =>
            if serial_i = '0' then  -- Detectar bit de start
              state <= RECEIVING;
              bit_count <= FRAME_SIZE - 1;
              shift_reg(FRAME_SIZE-1) <= serial_i;
            end if;

          when RECEIVING =>
            shift_reg <= shift_reg(FRAME_SIZE-2 downto 0) & serial_i;
            if bit_count = 0 then
              state <= IDLE_STATE;
              data_rx := shift_reg(FRAME_SIZE-2 downto CRC_SIZE);
              crc_rx  := shift_reg(CRC_SIZE-1 downto 0);
              crc_calc := crc3_lfsr(data_rx);
              if crc_rx = crc_calc then
                valid_o <= '1';
                data_o <= data_rx;
              else
                valid_o <= '0';
                data_o <= (others => '0');
              end if;
            else
              bit_count <= bit_count - 1;
            end if;
        end case;
      end if;
    end if;
  end process;

end behavioral;
