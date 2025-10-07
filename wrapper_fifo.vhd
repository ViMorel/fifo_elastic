library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_elastic is 
    generic(
        N       : integer := 8;
        M       : integer := 16;
        Tsetup  : time := 5ns;
        Thold   : time := 3ns;
    )
    port(
        clk     : in std_logic;
        reset   : in std_logic;
        Din     : in std_logic_vector(N-1 downto 0);
        req     : in std_logic
    );
end entity;

architecture fifo_elastic of fifo_elastic is 

end architecture fifo_elastic;