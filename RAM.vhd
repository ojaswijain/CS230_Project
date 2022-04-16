LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY RAM IS
   PORT
   (
      add:  IN   std_logic_vector (15 DOWNTO 0);
		input:  IN   std_logic_vector (15 DOWNTO 0);
		output:     OUT  std_logic_vector (15 DOWNTO 0);
      wc :    IN   std_logic;
		clk: IN   std_logic
   );
END RAM;
ARCHITECTURE arc OF RAM IS
   TYPE mem IS ARRAY(0 TO 65535) OF std_logic_vector(15 DOWNTO 0);
BEGIN
   PROCESS (clk)
   Variable ram_block : mem:= (others => "0000000000000000");
   BEGIN
      IF (falling_edge(clk)) THEN
         IF (wc = '1') THEN
            ram_block((to_integer(unsigned(add)))) := input;
         END IF;
         output <= ram_block((to_integer(unsigned(add))));
      END IF;
   END PROCESS;
END arc;