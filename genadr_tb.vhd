LIBRARY ieee  ; 
USE ieee.NUMERIC_STD.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.STD_LOGIC_UNSIGNED.all  ; 
ENTITY genadr_tb  IS 
  GENERIC (
    M  : INTEGER   := 8 ); 
END ; 
 
ARCHITECTURE genadr_tb_arch OF genadr_tb IS
  SIGNAL selread   :  STD_LOGIC  ; 
  SIGNAL incwrite   :  STD_LOGIC  ; 
  SIGNAL Adrg   :  std_logic_vector (M - 1 downto 0)  ; 
  SIGNAL incread   :  STD_LOGIC  ; 
  SIGNAL clk   :  STD_LOGIC  ; 
  SIGNAL reset   :  STD_LOGIC  ; 
  COMPONENT genadr  
    GENERIC ( 
      M  : INTEGER  );  
    PORT ( 
      selread  : in STD_LOGIC ; 
      incwrite  : in STD_LOGIC ; 
      Adrg  : out std_logic_vector (M - 1 downto 0) ; 
      incread  : in STD_LOGIC ; 
      clk  : in STD_LOGIC ; 
      reset  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : genadr  
    GENERIC MAP ( 
      M  => M   )
    PORT MAP ( 
      selread   => selread  ,
      incwrite   => incwrite  ,
      Adrg   => Adrg  ,
      incread   => incread  ,
      clk   => clk  ,
      reset   => reset   ) ; 


 process
  begin
    clk<='0'; Wait for 50 ns;
    clk<='1'; Wait for 50 ns;
  end process;
  
 process
   begin
    
    reset <= '1'; wait for 200 ns;
    reset <= '0';

    
    selread  <= '0';incwrite <= '1';wait for 400 ns;         
    incwrite <= '0';wait for 200 ns;

    
    selread <= '1';incread <= '1';wait for 300 ns;         
    incread <= '0';wait for 200 ns;

    
    selread <= '0';wait for 200 ns;
    wait;  
  end process;
end;
     

