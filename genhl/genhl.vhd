library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity genhl is 
    generic(M : integer := 8);
    port(
        reset   : in std_logic;
        clk     : in std_logic;
        enread  : out std_logic;
        enwrite : out std_logic
    );
end entity;

architecture genhl of genhl is 
    signal counter   : unsigned(M-1 downto 0) := (others => '0');
    signal reset_sig : std_logic;
begin 

    u_DCPT : entity work.DCPT
        generic map(M => M)
        port map(
            reset  => reset_sig,
            ud     => '1',
            clk    => clk,
            enable => '1',
            cptr   => counter
    );

    reset_sig <= '1' when ((counter = 200) or (reset = '1')) else '0';
    enread    <= '1' when (counter = 200) else '0';
    enwrite   <= '1' when (not (counter = 200)) else '0';

end architecture genhl;