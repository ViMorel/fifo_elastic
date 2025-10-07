library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.CHECK_PKG.ALL;

entity registre is
  generic (
    N      : integer := 8;
    Tsetup : time    := 5 ns;
    Thold  : time    := 3 ns
  );
  port (
    clk : in  std_logic;
    d   : in  std_logic_vector(N-1 downto 0);
    q   : out std_logic_vector(N-1 downto 0)
  );
end entity registre;

architecture registre of registre is
begin

  
  process(clk)
  begin
    if rising_edge(clk) then
      q <= d;
    end if;
  end process;

  -- Vérification setup
  setup_check : process
  begin
    check_setup(clk, d, Tsetup, error);
    wait;
  end process;

  -- Vérification hold
  hold_check : process
  begin
    check_hold(clk, d, Thold, error);
    wait;
  end process;

end;
