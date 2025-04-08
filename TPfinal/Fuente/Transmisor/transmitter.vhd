library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity transmitter is
  generic(
    DATA_SIZE : natural := 4  -- Tamaño de los datos
  );
  port(
    clk_i    : in  std_logic;                              -- Reloj
    rst_i    : in  std_logic;                              -- Reset sincrónico
    ena_i    : in  std_logic;                              -- Habilitador
    data_i   : in  std_logic_vector(DATA_SIZE-1 downto 0); -- Datos de entrada
    serial_o : out std_logic                               -- Salida serial
  );
end transmitter;

architecture behavioral of transmitter is
  constant PREAMBLE_SIZE : natural := 1;
  constant PREAMBLE : std_logic_vector(PREAMBLE_SIZE-1 downto 0) := std_logic_vector(to_unsigned(0,PREAMBLE_SIZE));
  constant IDLE : std_logic := '1';
  constant CRC_SIZE : natural := 3;
  constant FRAME_SIZE : natural := PREAMBLE_SIZE + DATA_SIZE + CRC_SIZE;  -- preamble + data + crc-3
  signal shift_reg : std_logic_vector(FRAME_SIZE-1 downto 0);
  signal bit_count : natural range 0 to FRAME_SIZE := 0;

  --Funcion estilo LFSR (procesa de MSB a LSB)
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
  begin
    if rising_edge(clk_i) then
      if rst_i = '1' then
        shift_reg <= (others => IDLE);  -- Estado idle
        bit_count <= 0;
        serial_o <= IDLE;
      else
        if ena_i = '1' then
          if bit_count = 0 then
            -- Cargar el frame completo: bit start, datos 
            shift_reg <= PREAMBLE & data_i & crc3_lfsr(data_i);
            -- Carga el bit de idle
            serial_o <= IDLE;
            -- asignamos bit_count con FRAME_SIZE
            bit_count <= FRAME_SIZE;
          else
            bit_count <= bit_count - 1;
            -- Enviar el bit más significativo del registro
            serial_o <= shift_reg(FRAME_SIZE-1);
            -- Desplazar el registro a la izquierda
            shift_reg <= shift_reg(FRAME_SIZE-2 downto 0) & IDLE;
          end if;
        end if;
      end if;
    end if;
  end process;

end behavioral;
