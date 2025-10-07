library ieee;
use ieee.std_logic_1164.all;

entity sequencer_tb is
end entity;

architecture tb of sequencer_tb is
    signal clk      : std_logic := '0';
    signal reset    : std_logic := '0';
    signal enread   : std_logic := '0';
    signal enwrite  : std_logic := '0';
    signal req      : std_logic := '0';

    signal ack      : std_logic;
    signal rw_n     : std_logic;
    signal oe       : std_logic;
    signal incwrite : std_logic;
    signal incread  : std_logic;
    signal hl       : std_logic;
    signal selread  : std_logic;
    signal cs_n     : std_logic;

begin
    -- DUT
    dut : entity work.sequencer(archi_mealy)
        port map (
            clk      => clk,
            reset    => reset,
            enread   => enread,
            enwrite  => enwrite,
            req      => req,
            ack      => ack,
            rw_n     => rw_n,
            oe       => oe,
            incwrite => incwrite,
            incread  => incread,
            hl       => hl,
            selread  => selread,
            cs_n     => cs_n
        );

    -- horloge 20 ns période
    clk_process : process
    begin
        while true loop
            clk <= '0'; wait for 10 ns;
            clk <= '1'; wait for 10 ns;
        end loop;
    end process;

    -- stimuli
    stim_proc : process
    begin
        -- reset
        reset <= '1'; wait for 40 ns;
        reset <= '0';

        -- cycle de lecture
        enread <= '1'; enwrite <= '0'; req <= '1';
        wait for 100 ns;
        req <= '0';
        wait for 40 ns;
        enread <= '0';

        -- cycle d'écriture
        enwrite <= '1'; enread <= '0'; req <= '1';
        wait for 100 ns;
        req <= '0';
        wait for 40 ns;
        enwrite <= '0';

        -- alternance lecture / écriture
        enread <= '1'; req <= '1';
        wait for 60 ns;
        enread <= '0'; enwrite <= '1';
        wait for 80 ns;
        req <= '0'; enwrite <= '0';

        -- fin
        wait for 200 ns;
        wait;
    end process;
end architecture;
