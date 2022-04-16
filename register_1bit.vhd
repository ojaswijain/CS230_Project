library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_1bit is
  port(
    output: out std_logic;
    input: in  std_logic;
    wc: in  std_logic;
    clk: in  std_logic
    );
end register_1bit;


architecture arc of register_1bit is
  signal reg : std_logic := '0';
begin
  output <= reg;
		
  process (clk)
  begin
    if rising_edge(clk) then

      if wc = '1' then
        reg <= input; 
      end if;

    end if;
  end process;
end arc;