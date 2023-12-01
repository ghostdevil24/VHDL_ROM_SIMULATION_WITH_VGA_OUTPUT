library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;


entity street_de10 is
  port (max10_clk1_50  : in  std_logic;                    
        key            : in  std_logic_vector(0 downto 0);  
        vga_vs         : out std_logic;                     
        vga_hs         : out std_logic;
        vga_r          : out std_logic_vector(1 downto 0);
        vga_g          : out std_logic_vector(1 downto 0);
        vga_b          : out std_logic_vector(1 downto 0));
end street_de10;

architecture shell of street_de10 is

signal clk_25   : std_logic;
signal reset    : std_logic;
signal reset_a, reset_b, reset_c, reset_d, reset_e : std_logic;
signal r, g, b  : std_logic_vector(1 downto 0);

begin

reset <= not key(0);

process
begin
  wait until rising_edge(max10_clk1_50);
  if (reset = '1') then
    clk_25 <= '0';
    reset_a <= '1';
    reset_b <= '1';
    reset_c <= '1';
    reset_d <= '1';
    reset_e <= '1';
  else
    clk_25 <= not clk_25;
    reset_a <= '0';
    reset_b <= reset_a;
    reset_c <= reset_b;
    reset_d <= reset_c;
    reset_e <= reset_d;
  end if;
end process;
-- generic submodule
street: entity work.street_image
    port map (clk_25    => clk_25,
              reset     => reset_e,
              vs_out    => vga_vs,
              hs_out    => vga_hs,
              de_out    => open,
              r_out     => r,
              g_out     => g,
              b_out     => b);

vga_r <= r(1 downto 0);
vga_g <= g(1 downto 0);
vga_b <= b(1 downto 0);
end shell;
--1. Generar una señal valida de vga (pulso del reloj correcto, pixeles derivados del timing, front porch y back porck- v sync y h sync)
--2. Simulación de memoria 
--3. Preparación de la imagen 
--4. Escritura de datos. 