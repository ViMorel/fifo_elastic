library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sequencer_custom is 
    port(
        clk      : in std_logic;
        reset    : in std_logic;
        enread   : in std_logic;
        enwrite  : in std_logic;
        req      : in std_logic;
        ack      : out std_logic;
        rw_n     : out std_logic;
        oe       : out std_logic;
        incwrite : out std_logic;
        incread  : out std_logic;
        hl       : out std_logic;
        selread  : out std_logic;
        cs_n     : out std_logic
    );
end entity;

architecture perso of sequencer_custom is 
    signal req_q  : std_logic;
    signal ack_q  : std_logic;
    signal read_q : std_logic;
    
begin

    ack <= ack_q;

    process(clk) begin
        if(rising_edge(clk)) then
            if(reset = '1') then
                req_q    <= '1';
                ack_q    <= '1';
                read_q   <= '0';
            else
                req_q    <= req;
                ack_q    <= req_q;
                read_q   <= enread;
            end if;
        end if;
    end process;

    process(ack_q, read_q) begin
        if(read_q = '1') then
            incread  <= '1';
            incwrite <= '0';
            oe       <= '1';
            hl       <= '1';
            selread  <= '1';
            cs_n     <= '1';
            rw_n     <= '1';
        elsif(ack_q = '0') then
            if(enwrite = '1' and enread = '0') then
                incread  <= '0';
                incwrite <= '1';
                oe       <= '0';
                hl       <= '0';
                selread  <= '0';
                cs_n     <= '1';
                rw_n     <= '0';
            end if;
        end if;
    end process;
end architecture perso;