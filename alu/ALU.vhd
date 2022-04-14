library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
library ieee;
use ieee.numeric_std.all; 

entity ALU is
	port(
		a, b : in std_logic_vector(15 downto 0);
		control : in std_logic_vector(1 downto 0);
		ALU_output : out std_logic_vector(15 downto 0);
		c, zero : out std_logic	
		);

end entity;

architecture ALU_arc of ALU is

	component adder is
		port (a, b: in std_logic_vector(15 downto 0);
				s: out std_logic_vector(16 downto 0));
	end component;

	component subtracter is
		port (a, b: in std_logic_vector(15 downto 0);
				s: out std_logic_vector(16 downto 0));
	end component;

	signal add_output, sub_output : std_logic_vector(16 downto 0);

begin
		adder_comp : adder port map(a, b, add_output);
		sub_comp : subtracter port map(a, b, sub_output);

		process (control, add_output, sub_output, a, b)
		begin
			if (control = "10") then
				ALU_output <= a nand b;
				c<= '0';
				if (a = "1111111111111111") then
					if (b = "1111111111111111") then
						zero<= '1';
					end if;
				end if;
			else
				if (control = "00") then
					ALU_output <= add_output(15 downto 0);
					c<= add_output(16);
					zero<= not (add_output(0) or add_output(1) or add_output(2) or add_output(3) or add_output(4) or add_output(5) or add_output(6) or add_output(7) or add_output(8) or add_output(9) or add_output(10) or add_output(11) or add_output(12) or add_output(13) or add_output(14) or add_output(15));
				else
					ALU_output <= sub_output(15 downto 0);
					c<= sub_output(16);
					zero<= not (sub_output(0) or sub_output(1) or sub_output(2) sub_output(3) sub_output(4) sub_output(5) sub_output(6) sub_output(7) sub_output(8) sub_output(9) sub_output(10) sub_output(11) sub_output(12) sub_output(13) sub_output(14) sub_output(15));
				end if;
			end if;
		end process;
end architecture;
