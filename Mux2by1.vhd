library ieee; 
use ieee.std_logic_1164.all;

entity Mux2by1 is
    port (i0, i1, selec : in std_logic;
            z : out std_logic);
end entity;

architecture mux of Mux2by1 is
    signal x, y: std_logic;

begin

    x <= i1 and selec;
    y <= i0 and (not selec);
    z<= x or y;
end;