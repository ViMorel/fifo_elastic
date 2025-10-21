library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_elastic is 
    generic(
        N       : integer := 8;
        M       : integer := 16;
        Tsetup  : time    := 10 ns;
        Thold   : time    := 3 ns
    );
    port(
        clk     : in std_logic;
        reset   : in std_logic;
        Din     : in std_logic_vector(N-1 downto 0);
        req     : in std_logic;
        ack     : out std_logic;
        Dout    : out std_logic_vector(N-1 downto 0);
        hl      : out std_logic;
        fast    : out std_logic;
        slow    : out std_logic
    );
end entity;

architecture fifo_elastic of fifo_elastic is 
    signal read     : std_logic;
    signal write    : std_logic;
    signal incread  : std_logic;
    signal incwrite : std_logic;
    signal selread  : std_logic;
    signal oe       : std_logic;
    signal rw_n     : std_logic;
    signal cs_n     : std_logic;
    signal data     : std_logic_vector(N-1 downto 0);
    signal data_c   : std_logic_vector(N-1 downto 0);
    signal addr     : std_logic_vector(M-1 downto 0);
begin
    genhl : entity work.genhl
        port map(
            reset   => reset,
            clk     => clk,
            enread  => read,
            enwrite => write
    );

    sequencer : entity work.sequencer
        port map(
            clk      => clk,
            reset    => reset,
            enread   => read,
            enwrite  => write,
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

    fastslow : entity work.fastslow
        generic map(M => M)
        port map(
            reset    => reset,
            clk      => clk,
            incread  => incread,
            incwrite => incwrite,
            fast     => fast,
            slow     => slow
        );

    genadr : entity work.genadr
        generic map(M => M)
        port map(
            clk      => clk,
            reset    => reset,
            incread  => incread,
            incwrite => incwrite,
            selread  => selread,
            adrg     => addr
        );

    RAM_2pMxNbits : entity work.RAM_2pMxNbits
        generic map(
            data_width => N,
            addr_width => M
        )
        port map(
            oe_i   => oe,
            data_i => data_c,
            cs_ni  => cs_n,
            rw_ni  => rw_n,
            addr_i => addr,
            data_o => Dout
        );

    registre_n_bits : entity work.registre
        generic map(
            N      => N,
            Tsetup => Tsetup,
            Thold  => Thold
        ) 
        port map(
            clk  => clk,
            Din  => Din,
            regN => data
        );

    complement_a_2 : entity work.complement_a_2
        generic map(
            N => N
        )
        port map(
            nombre => data,
            sortie => data_c
        );

end architecture fifo_elastic;