library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM_2pMxNbits is 
    generic(
        data_width : integer := 16; --N = data_width
        addr_width : integer := 8  --M = addr_width,
    );  
    port(oe_i  : in std_logic;
        data_i : in std_logic_vector(data_width-1 downto 0);
        cs_ni  : in std_logic;
        rw_ni  : in std_logic;
        addr_i : in std_logic_vector(addr_width-1 downto 0);
        data_o : out std_logic_vector(data_width-1 downto 0)
    );
end entity;

architecture behavior of RAM_2pMxNbits is 
    type mem_type is array (0 to 2**addr_width-1) of std_logic_vector(data_width-1 downto 0);
    signal mem_reg : mem_type;
begin   
    process(oe_i, data_i, cs_ni, rw_ni, addr_i) begin
        if(cs_ni = '1') then 
            data_o <= (others => 'Z');
        else if(rw_ni = '0')then
            mem_reg(to_integer(unsigned(addr_i))) <= data_i;
            else if(oe_i = '1') then
                data_o <= mem_reg(to_integer(unsigned(addr_i)));
            else data_o <= (others => 'Z');
            end if;
            end if;
        end if;
    end process;
end architecture behavior;