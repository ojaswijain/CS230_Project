library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
library ieee;
use ieee.numeric_std.all;

entity adder is
    port (a, b: in std_logic_vector(15 downto 0);
            s: out std_logic_vector(16 downto 0));
end entity;


architecture add_arc of adder is

    component KSadder is
        port (g, p: in std_logic_vector(15 downto 0);
                c: in std_logic;
                s: out std_logic_vector(16 downto 0));
    end component;

    signal c: std_logic;
    signal g, p: std_logic_vector(15 downto 0);

begin
    c<='1';
    g<= a and b;
    p<= a xor b;

    adder_16 : KSadder port map(g,p,c,s);

end architecture;