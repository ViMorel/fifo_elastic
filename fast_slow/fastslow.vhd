library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fastslow is 
    generic(M : integer := 4);
    port(
        reset    : in std_logic;
        clk      : in std_logic;
        incread  : in std_logic;
        incwrite : in std_logic;
        fast     : out std_logic;
        slow     : out std_logic
    );
end entity;

architecture fastslow of fastslow is 
    signal counter_sig : unsigned(M-1 downto 0) := (others => '0');
    signal enable_xor : std_logic;
begin
    u_DCPT : entity work.DCPT
        generic map(M => M)
        port map(
            reset  => reset,
            ud     => incwrite,
            clk    => clk,
            enable => enable_xor,
            cptr   => counter_sig
    );

    
    enable_xor <= incread xor incwrite;
    
    fast <= not(counter_sig(M-1) or counter_sig(M-2));
    slow <= counter_sig(M-1) and counter_sig(M-2);
    

end architecture fastslow;
