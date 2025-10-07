library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity genhl_tb is
end entity;

architecture tb of genhl_tb is
    constant M : integer := 8;

    signal reset   : std_logic := '0';
    signal clk     : std_logic := '0';
    signal enread  : std_logic;
    signal enwrite : std_logic;
begin
    -- instanciation du DUT
    dut : entity work.genhl
        generic map (
            M => M
        )
        port map (
            reset   => reset,
            clk     => clk,
            enread  => enread,
            enwrite => enwrite
        );

    -- génération d’horloge
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 10 ps;
            clk <= '1';
            wait for 10 ps;
        end loop;
    end process;

    -- stimuli
    stim_proc : process
    begin
        -- reset actif pendant 40 ns
        reset <= '1';
        wait for 40 ps;
        reset <= '0';

        -- laisse tourner
        wait for 600 ps;
        wait;
    end process;
end architecture;
