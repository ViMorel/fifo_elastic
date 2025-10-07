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
    Din   : in  std_logic_vector(N-1 downto 0);
    regN   : out std_logic_vector(N-1 downto 0)
  );
end entity registre;

architecture registre of registre is
begin

  
  process(clk)
  begin
    if rising_edge(clk) then
      regN <= Din;
    end if;
  end process;

  -- V�rification setup
  setup_check : process
  begin
    check_setup(clk, Din, Tsetup, error);
    wait;
  end process;

  -- V�rification hold
  hold_check : process
  begin
    check_hold(clk, Din, Thold, error);
    wait;
  end process;

end;
