LIBRARY ieee  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
ENTITY dcpt_tb  IS 
  GENERIC (
    M  : INTEGER := 8  ); 
END ; 
 
ARCHITECTURE dcpt_tb_arch OF dcpt_tb IS
  SIGNAL cptr   :  std_logic_vector (M - 1 downto 0)  ; 
  SIGNAL ud   :  STD_LOGIC  ; 
  SIGNAL clk   :  STD_LOGIC  ; 
  SIGNAL enable   :  STD_LOGIC  ; 
  SIGNAL reset   :  STD_LOGIC  ; 
  COMPONENT DCPT  
    GENERIC ( 
      M  : INTEGER  );  
    PORT ( 
      cptr  : out std_logic_vector (M - 1 downto 0) ; 
      ud  : in STD_LOGIC ; 
      clk  : in STD_LOGIC ; 
      enable  : in STD_LOGIC ; 
      reset  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : DCPT  
    GENERIC MAP ( 
      M  => 8   )
    PORT MAP ( 
      cptr   => cptr  ,
      ud   => ud  ,
      clk   => clk  ,
      enable   => enable  ,
      reset   => reset   ) ; 
      
      process
  begin
    clk<='0'; Wait for 50 ns;
    clk<='1'; Wait for 50 ns;
    
 end process;
 
 Process
   begin
   reset<='1';enable<='1';UD<='0'; Wait for 200 ns;
    reset<='0'; enable<='1';UD<='0'; Wait for 300 ns;
    enable<='0';UD<='1'; Wait for 400 ns;
    enable<='1';UD<='1'; Wait for 1000 ns;
      
     wait;
 end Process;
END ; 

