library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
  port(
    outA: out std_logic_vector(15 downto 0);
    outB: out std_logic_vector(15 downto 0);
	  outr: out std_logic_vector(15 downto 0);
    input: in  std_logic_vector(15 downto 0);
    wc: in  std_logic;
    rAs: in  std_logic_vector(2 downto 0);
    rBs: in  std_logic_vector(2 downto 0);
    wrs: in  std_logic_vector(2 downto 0);
    clk: in  std_logic
    );
end register_file;


architecture arc of register_file is
  type mem is array(0 to 7) of std_logic_vector(15 downto 0);
  signal regs : mem := (others=>"0000000000000000");
begin
  outA <= regs(to_integer(unsigned(rAs)));
  outB <= regs(to_integer(unsigned(rBs)));
  outr <= regs(0);
		
  process (clk) is
  begin
    if rising_edge(clk) then

      if wc = '1' then
        regs(to_integer(unsigned(wrs))) <= input; 
      end if;

    end if;
  end process;
end arc;