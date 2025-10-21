--==================================================
-- Testbench: fifo_elastic_tb
--==================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_elastic_tb is
end entity;

architecture tb of fifo_elastic_tb is
  -- Choose small sizes for fast sim
  constant N_c : integer := 8;
  constant M_c : integer := 4;

  signal clk   : std_logic := '0';
  signal reset : std_logic := '0';
  signal Din   : std_logic_vector(N_c-1 downto 0) := (others => '0');
  signal req   : std_logic := '0';

  signal ack   : std_logic;
  signal Dout  : std_logic_vector(N_c-1 downto 0);
  signal hl    : std_logic;
  signal fast  : std_logic;
  signal slow  : std_logic;
begin
  -- DUT
  dut: entity work.fifo_elastic
    generic map (
      N      => N_c,
      M      => M_c,
      Tsetup => 10 ns,
      Thold  => 3 ns
    )
    port map (
      clk   => clk,
      reset => reset,
      Din   => Din,
      req   => req,
      ack   => ack,
      Dout  => Dout,
      hl    => hl,
      fast  => fast,
      slow  => slow
    );

  -- Clock 20 ns
  clk <= not clk after 10 ns;

  -- Stimuli
  stim: process
  begin
    -- Reset
    reset <= '1';
    wait for 60 ns;
    reset <= '0';

    -- Drive a few words with req pulses
    for i in 0 to 15 loop
      Din <= std_logic_vector(to_unsigned(i, N_c));
      req <= '1';
      wait for 40 ns;         -- request width
      req <= '0';
      wait for 80 ns;         -- idle gap
    end loop;

    -- Finish
    wait for 500 ns;
    wait;
  end process;
end architecture;

