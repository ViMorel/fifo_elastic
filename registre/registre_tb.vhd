library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registre_tb is
end entity;

architecture arch of registre_tb is
  constant N : integer := 8;
  constant Tsetup : time := 10 ns;
  constant Thold  : time := 3 ns;

  signal clk  : std_logic := '0';
  signal Din  : std_logic_vector(N-1 downto 0) := (others => '0');
  signal regN : std_logic_vector(N-1 downto 0);

  component registre
    generic (
      N      : integer;
      Tsetup : time;
      Thold  : time
    );
    port (
      clk : in  std_logic;
      Din  : in  std_logic_vector(N-1 downto 0);
      regN   : out std_logic_vector(N-1 downto 0)
    );
  end component;
begin

  DUT: registre
    generic map(N => N, Tsetup => Tsetup, Thold => Thold)
    port map(clk => clk, Din => Din, regN => regN);

  -- Clock
  clk_process: process
  begin
    loop
      clk <= '0'; wait for 50 ns;
      clk <= '1'; wait for 50 ns;
    end loop;
  end process;

  
  process
  begin
    Din<= "10101010";  
    wait for 100 ns;
    

    -- Violation setup 
    wait for 45 ns; 
    d <= "11110000";
    wait for 100 ns;

    -- Violation hold 
    wait until rising_edge(clk);
    wait for 2 ns;
    Din<= "00001111";

    wait for 200 ns;
    wait;
  end process;

end architecture;

