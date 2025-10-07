library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_tb is
end entity;

architecture ram_tb of ram_tb is
    constant DATA_WIDTH : integer := 8;   -- plus petit pour test
    constant ADDR_WIDTH : integer := 4;

    signal oe_i   : std_logic := '0';
    signal data_i : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
    signal cs_ni  : std_logic := '0';
    signal rw_ni  : std_logic := '0';
    signal addr_i : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
    signal data_o : std_logic_vector(DATA_WIDTH-1 downto 0);

begin
    -- instanciation de la RAM
    DUT: entity work.RAM_2pMxNbits
        generic map (
            data_width => DATA_WIDTH,
            addr_width => ADDR_WIDTH
        )
        port map (
            oe_i   => oe_i,
            data_i => data_i,
            cs_ni  => cs_ni,
            rw_ni  => rw_ni,
            addr_i => addr_i,
            data_o => data_o
        );

    -- Stimuli
    stim_proc: process
    begin
        -- Écriture à l'adresse 3
        cs_ni  <= '0';
        rw_ni  <= '1';       -- écriture
        oe_i   <= '0';
        addr_i <= std_logic_vector(to_unsigned(3, ADDR_WIDTH));
        data_i <= x"AA";
        wait for 20 ns;

        -- Lecture à l'adresse 3
        rw_ni  <= '0';       -- lecture
        oe_i   <= '1';
        wait for 20 ns;

        -- Écriture à l'adresse 5
        rw_ni  <= '1';
        oe_i   <= '0';
        addr_i <= std_logic_vector(to_unsigned(2, ADDR_WIDTH));
        data_i <= x"55";
        wait for 20 ns;

        -- Lecture à l'adresse 5
        rw_ni  <= '0';
        oe_i   <= '1';
        wait for 20 ns;

        wait;
    end process;
end architecture;
