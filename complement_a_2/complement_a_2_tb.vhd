LIBRARY ieee  ; 
LIBRARY work  ; 
USE ieee.std_logic_1164.all  ; 
USE work.mes_fonctions.all  ; 
USE ieee.numeric_std.all;



ENTITY complement_a_2_tb  IS 
  GENERIC (
    N  : INTEGER   := 8 ); 
END ; 
 
ARCHITECTURE complement_a_2_tb_arch OF complement_a_2_tb IS
  SIGNAL sortie   :  std_logic_vector (N - 1 downto 0)  ; 
  SIGNAL nombre   :  std_logic_vector (N - 1 downto 0)  ; 
  COMPONENT complement_a_2  
    GENERIC ( 
      N  : INTEGER  );  
    PORT ( 
      sortie  : out std_logic_vector (N - 1 downto 0) ; 
      nombre  : in std_logic_vector (N - 1 downto 0) ); 
  END COMPONENT ; 
BEGIN
  DUT  : complement_a_2  
    GENERIC MAP ( 
      N  => N   )
    PORT MAP ( 
      sortie   => sortie  ,
      nombre   => nombre   ) ; 
    process
      begin
        
    nombre <= (others => '0');
    wait for 10 ns;

    
    nombre <= std_logic_vector(to_unsigned(1, N));
    wait for 10 ns;

    
    nombre <= std_logic_vector(to_unsigned(5, N));
    wait for 10 ns;

    
    nombre <= (others => '1');
    wait for 10 ns;

    
    nombre <= "10000000";
    wait for 10 ns;

    
    wait;
  end process;
END ; 

