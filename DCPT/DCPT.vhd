library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DCPT is  
  generic(M : integer:=8);
  port ( clk, reset, enable, ud : in std_logic;
         cptr : out unsigned(M-1 downto 0));
end DCPT;

architecture DCPT of DCPT is
  signal  compteur : unsigned(M-1 downto 0) := (others => '0');
  
  begin
    
    process(clk) begin
      if (rising_edge(clk)) then
        if reset = '1' then
        compteur<=(others=>'0');
        else if enable ='1' then
          if ud ='1' then
            compteur<=compteur + 1;
          else compteur<=compteur- 1;
          end if;
        end if;
        end if;
      end if;
    end process;
    
    cptr<= compteur; --std_logic_vector(to_unsigned(compteur,M));
     
end architecture DCPT;
    
  