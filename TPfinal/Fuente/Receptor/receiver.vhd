library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity receiver is
  generic (
    DATA_SIZE : natural := 4  -- Número de bits de datos
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

  constant PREAMBLE_SIZE : natural := 3;
  constant PREAMBLE      : std_logic_vector(PREAMBLE_SIZE-1 downto 0) := std_logic_vector(to_unsigned(2,PREAMBLE_SIZE));
  constant CRC_SIZE      : natural := 3;
  constant PAYLOAD_SIZE  : natural := DATA_SIZE + CRC_SIZE;  -- Datos + CRC
  
  -- Estados de la FSM
  type state_type is (PREAMBLE_SEARCH, RECEIVING, WAIT_IDLE);
  signal state : state_type := PREAMBLE_SEARCH;
  
  signal preamble_reg : std_logic_vector(PREAMBLE_SIZE-1 downto 0) := (others => '1');
  signal payload_reg  : std_logic_vector(PAYLOAD_SIZE-1 downto 0) := (others => '0');
  signal bit_count    : natural range 0 to PAYLOAD_SIZE := 0;

  -- Función CRC3 usando LFSR (procesamiento de MSB a LSB)
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
    variable premble  : std_logic_vector(PREAMBLE_SIZE-1 downto 0);
    variable payload  : std_logic_vector(PAYLOAD_SIZE-1 downto 0);
    variable data_rx  : std_logic_vector(DATA_SIZE-1 downto 0);
    variable crc_rx   : std_logic_vector(CRC_SIZE-1 downto 0);
    variable crc_calc : std_logic_vector(CRC_SIZE-1 downto 0);
  begin
    if rising_edge(clk_i) then
      if rst_i = '1' then
        state       <= PREAMBLE_SEARCH;
        preamble_reg    <= (others => '1');
        payload_reg <= (others => '0');
        bit_count   <= 0;
        valid_o     <= '0';
        data_o      <= (others => '0');
      elsif ena_i = '1' then
        case state is
          when PREAMBLE_SEARCH =>
            -- Desplaza el registro de preambulo e incorpora el nuevo bit.
            premble := preamble_reg(PREAMBLE_SIZE-2 downto 0) & serial_i;
            preamble_reg  <= premble;
            -- Verifica la secuencia de preambulo.
            if premble = PREAMBLE then
              state <= RECEIVING;
              bit_count <= PAYLOAD_SIZE - 1;
              payload_reg <= (others => '0');
            end if;
          
          when RECEIVING =>
            -- Desplaza el registro de recepción para capturar los datos y el CRC.
            payload := payload_reg(PAYLOAD_SIZE-2 downto 0) & serial_i;
            payload_reg  <= payload;
            if bit_count = 0 then
              -- Se extraen los datos y el CRC recibido
              data_rx := payload(PAYLOAD_SIZE-1 downto CRC_SIZE);
              crc_rx  := payload(CRC_SIZE-1 downto 0);
              crc_calc := crc3_lfsr(data_rx);
              if crc_rx = crc_calc then
                valid_o <= '1';
                data_o  <= data_rx;
              else
                valid_o <= '0';
                data_o  <= (others => '0');
              end if;
              -- Una vez evaluado el frame se pasa al estado de espera del bit idle.
              state <= WAIT_IDLE;
            else
              bit_count <= bit_count - 1;
            end if;
          
          when WAIT_IDLE =>
            -- En este estado se descarta el bit idle y se vuelve a iniciar la búsqueda.
            if serial_i = '1' then
              state <= PREAMBLE_SEARCH;
              preamble_reg <= (others => '1');  -- Reinicializa el registro de sincronización
            end if;
        end case;
      end if;
    end if;
  end process;
end behavioral;
