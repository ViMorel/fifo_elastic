library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sequencer is 
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

architecture archi_mealy of sequencer is 
    signal state : std_logic_vector(2 downto 0);
begin

    process(clk) begin
        if(rising_edge(clk)) then
            if(reset = '1') then
                state    <= "000";
            end if;
                case state is 
                    when "000" => 
                        if(enread = '1') then
                            state  <= "001";
                        elsif(enwrite = '1') then 
                            state  <= "010";
                        else state <= "000";
                        end if;
                    when "001" => state <= "000";
                    when "010" => state <= "011";
                    when "011" => 
                        if(enread = '1') then 
                            state  <= "100";
                        elsif(req = '1') then 
                            state  <= "000";
                        else state <= "011";
                        end if;
                    when "100"  => state <= "011";
                    when others => state <= "000";
                end case;
        end if;
    end process;

    process(state) begin
        case state is 
            when "000" => --repo
                incread  <= '0';
                incwrite <= '0';
                oe       <= '0';
                hl       <= '0';
                selread  <= '0';
                cs_n     <= '1';
                rw_n     <= '0';
            when "001" => --lecture 1
                incread  <= '1';
                incwrite <= '0';
                oe       <= '1';
                hl       <= '1';
                selread  <= '1';
                cs_n     <= '0';
                rw_n     <= '1';
            when "010" => --ecriture
                incread  <= '0';
                incwrite <= '1';
                oe       <= '0';
                hl       <= '0';
                selread  <= '0';
                cs_n     <= '0';
                rw_n     <= '0';
            when "011" => --attente
                incread  <= '0';
                incwrite <= '0';
                oe       <= '0';
                hl       <= '0';
                selread  <= '0';
                cs_n     <= '1';
                rw_n     <= '0';
            when others => --lecture 2
                incread  <= '1';
                incwrite <= '0';
                oe       <= '1';
                hl       <= '1';
                selread  <= '1';
                cs_n     <= '0';
                rw_n     <= '1';
        end case;
    end process;
end architecture archi_mealy;

architecture archi_moore of sequencer is 
    signal state : std_logic_vector(2 downto 0);
begin

    process(clk) begin
        if(rising_edge(clk)) then
            if(reset = '1') then
                state    <= "000";
            end if;
                case state is 
                    when "000" => 
                        if(enread = '1') then
                            state  <= "001";
                        elsif(enwrite = '1') then 
                            state  <= "010";
                        else state <= "000";
                        end if;
                    when "001" => state <= "000";
                    when "010" => state <= "011";
                    when "011" => 
                        if(enread = '1') then 
                            state  <= "100";
                        elsif(req = '1') then 
                            state  <= "000";
                        else state <= "011";
                        end if;
                    when "100"  => state <= "011";
                    when others => state <= "000";
                end case;
        end if;
    end process;

    process(clk) begin
    if(rising_edge(clk)) then
        case state is 
            when "000" => --repo
                incread  <= '0';
                incwrite <= '0';
                oe       <= '0';
                hl       <= '0';
                selread  <= '0';
                cs_n     <= '1';
                rw_n     <= '0';
            when "001" => --lecture 1
                incread  <= '1';
                incwrite <= '0';
                oe       <= '1';
                hl       <= '1';
                selread  <= '1';
                cs_n     <= '0';
                rw_n     <= '1';
            when "010" => --ecriture
                incread  <= '0';
                incwrite <= '1';
                oe       <= '0';
                hl       <= '0';
                selread  <= '0';
                cs_n     <= '0';
                rw_n     <= '0';
            when "011" => --attente
                incread  <= '0';
                incwrite <= '0';
                oe       <= '0';
                hl       <= '0';
                selread  <= '0';
                cs_n     <= '1';
                rw_n     <= '0';
            when others => --lecture 2
                incread  <= '1';
                incwrite <= '0';
                oe       <= '1';
                hl       <= '1';
                selread  <= '1';
                cs_n     <= '0';
                rw_n     <= '1';
        end case;
    end if;
    end process;
end architecture archi_moore;