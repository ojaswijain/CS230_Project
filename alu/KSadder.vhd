library std;
use std.standard.all;
use work.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

entity KSadder is
    port (g, p : in std_logic_vector(15 downto 0);
            c: in std_logic;
            s: out std_logic_vector(16 downto 0));

end entity KSadder;

architecture KSarc of KSadder is
    signal g1, g2, g3, g4, p1, p2, p3, p4, carry: std_logic_vector(15 downto 0);

begin

    g1(0)<=g(0);
    p1(0)<=p(0);

    for i in 1 to 15 generate
        g1(i) <= g(i) or (g(i-1) and p(i));
        p1(i) <= p(i) and p(i-1);
    end generate;

    for i in 0 to 1 generate
        g2(i)<=g1(i);
        p2(i)<=p1(i);
    end generate;
    
    for i in 2 to 15 generate
        g2(i) <= g1(i) or (g1(i-2) and p1(i));
        p2(i) <= p1(i) and p1(i-2);
    end generate;

    for i in 0 to 3 generate
        g3(i)<=g2(i);
        p3(i)<=p2(i);
    end generate;
    
    for i in 4 to 15 generate
        g3(i) <= g2(i) or (g2(i-4) and p2(i));
        p3(i) <= p2(i) and p2(i-4);
    end generate;
    
    for i in 0 to 7 generate
        g4(i)<=g3(i);
        p4(i)<=p3(i);
    end generate;
     
    for i in 8 to 15 generate
        g4(i) <= g3(i) or (g3(i-8) and p3(i));
        p4(i) <= p3(i) and p3(i-8);
    end generate;
    
    for i in 0 to 15 generate
        carry(i) <=g4(i) or (p4(i) and c);
    end generate;
    
    s(0) <= c xor p(0);
    
    for i in 1 to 15 generate
        s(i) <= p(i) xor carry(i-1);
    end generate;
    
    s(16) <= carry(15);
    

end architecture;