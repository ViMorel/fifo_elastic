library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity genadr is  
  generic(M : integer := 8);
  port ( 
    clk, reset, incread, incwrite, selread: in std_logic;
    Adrg : out std_logic_vector(M-1 downto 0)
  );
end genadr;

architecture genadr of genadr is
  
  
  component DCPT
    generic(M : integer := 8);
    port (
      clk, reset, enable, ud : in std_logic;
      cptr : out unsigned(M-1 downto 0)
    );
  end component;

  signal addr_read  : unsigned(M-1 downto 0);
  signal addr_write : unsigned(M-1 downto 0);

begin

  -- Instanciation lecture
  compteur_read : DCPT
    generic map(M => M)
    port map(
      clk    => clk,
      reset  => reset,
      enable => incread,
      ud     => '1',           
      cptr   => addr_read
    );
    
  -- Instanciation �criture
  compteur_write : DCPT
    generic map(M => M)
    port map(
      clk    => clk,
      reset  => reset,
      enable => incwrite,
      ud     => '1',           
      cptr   => addr_write
    );
  
  process(addr_read, addr_write, selread)
    begin 
    
  if selread='1'then
    Adrg<= std_logic_vector(addr_read);
  else 
    Adrg<= std_logic_vector(addr_write);
    end if;
    
    end process;
end genadr;
