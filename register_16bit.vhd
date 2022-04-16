library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_16bit is
  port(
    output: out std_logic_vector(15 downto 0);
    input: in  std_logic_vector(15 downto 0);
    wc: in  std_logic;
    clk: in  std_logic;
	  rst: in std_logic
    );
end register_16bit;


architecture arc of register_16bit is
  signal reg : std_logic_vector(15 downto 0) := (others => '0');
begin
  output <= reg;
		
  process (clk)
  begin
    if rising_edge(clk) then		
		if rst = '1' then
			reg <= "0000000000000000";
		else 
			if wc = '1' then
				reg <= input; 
			end if;
		end if;
	end if;
  end process;
end arc;