library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity controller is
	port(
		reset, clk, bootload: in std_logic; 
		operation: in std_logic_vector(3 downto 0);
		condition: in std_logic_vector(1 downto 0);
		T: out std_logic_vector(24 downto 0);
		boot: out std_logic;
		C, OV, Z, invalid, eq, B, finish: in std_logic);
end entity;

architecture controller_arc of controller is
	type states is (B0, B1, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16);
	signal Q, notQ: states := S0;
begin

	clocked:
	process(clk, notQ)
	begin
		if (clk'event and clk = '1') then
			Q <= notQ;
		end if;
	end process;
	
	outputs:
	process(operation, Q)
	begin
		T <= (others => '0');
		boot <= '0';
		case Q is
			when B0 => boot <= '1';
			when B1 => boot <= '1';
		   when S0 => 
				T <= (others => '0');
			when S1 =>
				T(19 downto 17) <= "001";	
				T(21 downto 20) <= "11"; 	
				T(22) <= '1';				
				T(9) <= '1';				
				T(1) <= '1';				
				T(24) <= '1';				
			when S2 =>
				T(0) <= '1';				
				T(6) <= '1';
				T(3) <= '1';				
				T(23) <= '0';				
				T(7) <= '1';				
				T(11) <= '0';				
			when S3 =>
				T(21 downto 20) <= "10";	
				T(19 downto 17) <= "010";	
				T(23) <= '1';				
				T(7) <= '1';				
				T(10) <= '1';				
			when S4 =>
				T(13 downto 12) <= "11";	
				T(16 downto 14) <= "001";	
				T(2) <= '1';				
			when S5 =>
				T(16 downto 14) <= "000";	
				T(13 downto 12) <= "00";	
				T(2) <= '1';				
				T(21 downto 20) <= "00";	
				T(19 downto 17) <= "000";	
			when S6 =>
				T(16 downto 14) <= "010";	
				T(13 downto 12) <= "01";	
				T(2) <= '1';				
			when S7 =>
				T(21 downto 20) <= "10";	
				T(19 downto 17) <= "011";	
				T(23) <= '1';				
				T(7) <= '1';				
				T(10) <= '1';				
				T(0) <= '1';				
				T(5) <= '1';				
			when S8 =>
				T(16 downto 14) <= "101";	
				T(8)  <= '1';				
				T(13 downto 12) <= "01";	
				T(2) <= '1';				
			when S9 =>
				T(16 downto 14) <= "000";	
				T(13 downto 12) <= "00";	
				T(2) <= '1';				
			when S10 =>
				T(8)  <= '1';				
			when S11 =>
				T(16 downto 14) <= "011";	
				T(13 downto 12) <= "10";	
				T(2) <= '1';				
				T(21 downto 20) <= "01";	
				T(19 downto 17) <= "001";	
				T(23) <= '1';				
				T(7) <= '1';				
				T(4) <= '1';				
				T(0) <= '1';				
			when S12 =>
				T(11) <= '1';				
				T(5) <= '1';				
				T(6) <= '1';				
			when S13 =>
				T(21 downto 20) <= "01";	
				T(19 downto 17) <= "001";	
				T(23) <= '1';				
				T(7) <= '1';				
				T(4) <= '1';				
			when S14 =>
				T(21 downto 20) <= "11";	
				T(19 downto 17) <= "011";	
				T(22) <= '1';				
				T(9) <= '1';				
			when S15 =>
				T(16 downto 14) <= "000";	
				T(13 downto 12) <= "01";	
				T(21 downto 20) <= "11";	
				T(19 downto 17) <= "100";	
				T(22) <= '1';				
				T(9) <= '1';				
				T(2) <= '1';				
			when S16 =>
				T(22) <= '0';				
				T(13 downto 12) <= "01";	
				T(16 downto 14) <= "000";	
				T(2) <= '1';				
				T(9) <= '1';				
			when others =>
				--Do Nothing
		end case;
	end process;
	
	
	next_state:
	process(operation, condition, C, OV, Z, invalid, eq, B, reset, Q, finish, bootload)
	begin
		notQ <= Q;
		case Q is
			when B0 => notQ <= B1;
			when B1 =>
				if (finish = '1') then notQ <= S0;
				end if;
			when S0 => notQ <= S1;
			when S1 =>
				case operation is
					when "0011" | "1011" => notQ <= S6;	
					when "1000" =>	notQ <= S15;
					when "1001" => notQ <= S16;
					when others =>	notQ <= S2;
				end case;
			when S2 =>
				case operation is
					when "0000" | "0010"=>
						case condition is
							when "00" => notQ <= S3;
							when "10" =>
								if (C = '1') then	notQ <= S3;
								else	notQ <= S5;
							end if;
						when "01" =>
								if (Z = '1') then	notQ <= S3;
								else notQ <= S5;
								end if;
							when "11" =>
								if (OV = '1') then	notQ <= S3;
								else notQ <= S5;
								end if;
							when others =>	notQ <= S5;
						end case;
					when "0001" => notQ <= S7;
					when "0100" =>	notQ <= S7;
					when "0101" =>	notQ <= S7;
					when "0110" => notQ <= S10;
					when "0111" => notQ <= S12;
					when "1100" =>
						if (eq = '1') then notQ <= S14;
						else	notQ <= S5;
						end if;
					when others =>	notQ <= S5;
				end case;
			when S3 =>	notQ <= S4;
			when S4 => 	
				if(B = '0') then notQ <= S5;
				else notQ <= S1;
				end if;
			when S5 =>	notQ <= S1;
			when S6 =>	
				if(B = '0') then notQ <= S5;
				else notQ <= S1;
				end if;
			when S7 =>
				if (operation(0) = '0') then	notQ <= S8;
				elsif (operation(2) = '1') then	notQ <= S9;
				else notQ <= S4;
				end if;
			when S8 => notQ <= S5;
			when S9 =>	notQ <= S1;
			when S10 => notQ <= S11;
			when S11 =>
				if (invalid = '1') then notQ <= S5;
				else notQ <= S10;
				end if;
			when S12 =>	notQ <= S13;
			when S13 =>
				if (invalid = '1') then
					if(B = '0') then notQ <= S5;
					else notQ <= S1;
					end if;
				else notQ <= S12;
				end if;
			when S14 =>	
				notQ <= S5;
			when S15 => 
				if(B = '0') then notQ <= S5;
				else notQ <= S1;
				end if;
			when S16 =>
				if(B = '0') then notQ <= S5;
				else notQ <= S1;
				end if;
			when others =>	notQ <= S5;
		end case;
		if ((reset = '1') and (bootload = '1')) then
			notQ <= B0;
		elsif (reset = '1') then
			notQ <= S0;
		end if;
	end process;
		
end architecture;
