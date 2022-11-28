----------------------------------------------------------------------------------------
---ESE 345 Porject: Pipelined SIMD multimedia unit design - Part 2	
---Authors: Nebil Oumer and Elijah Farrell
---File:register FIle.vhd
---11/23/2022
----------------------------------------------------------------------------------------
library ieee;								  	
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
use work.myPackage.all;
use work.all;  

entity Register_File is
    port (
        clk : in std_logic;
        sele: in std_logic_vector(24 downto 0);
		registers_in : in reg_table;
		rdNum : in std_logic_vector(4 downto 0);
        write_to_reg: in std_logic;
        writtenReg: in std_logic_vector(127 downto 0); 
		registers_out :	out reg_table;
		r1Num,r2Num,r3Num  : out std_logic_vector(4 downto 0);
        out1: out std_logic_vector(127 downto 0);
        out2: out std_logic_vector(127 downto 0);
        out3: out std_logic_vector(127 downto 0)
    );
end entity Register_File;

architecture behavioral of Register_File is
	 signal r1NumT,r2NumT,r3NumT  : std_logic_vector(4 downto 0);
begin  
	
    process(clk)
		    variable r1:integer;
		    variable r2:integer;
		    variable r3:integer;
    begin
            if rising_edge(clk) then
			    if sele (24 downto 23) = "11" then  --r3 instructions
			        r1 := to_integer(unsigned (sele(9 downto 5)));
					r1Num <= std_logic_vector(to_unsigned(r1,5));
					--r1Num <= r1NumT;
				    out1 <= registers_in(r1);
			        r2 := to_integer(unsigned(sele(14 downto 10)));
					r2NumT <=  std_logic_vector(to_unsigned(r2,5));
					r2Num <= r2NumT;
                    out2 <= registers_in(r2)(127 downto 0);
                elsif sele(24 downto 23) ="10" then --r4 instructions
                    r1 := to_integer(unsigned (sele(9 downto 5)));
					r1NumT <= std_logic_vector(to_unsigned(r1,5));
					r1Num <= r1NumT;
                    out1 <= registers_in( r1)(127 downto 0);
                    r2 := to_integer(unsigned(sele(14 downto 10)));
					r2NumT <=  std_logic_vector(to_unsigned(r2,5));
					r2Num <= r2NumT;
                    out2 <= registers_in(r2)(127 downto 0);
                    r3 := to_integer (unsigned (sele(19 downto 15)));
					r3NumT <=  std_logic_vector(to_unsigned(r3,5));
					r3Num <= r3NumT;
                    out3 <= registers_in(r3)(127 downto 0);
				elsif sele(24) = '0' then   -- load
					r1 := 1;
					r1NumT <=  std_logic_vector(to_unsigned(r1,5));
					r1Num <= r1NumT;
					r2 := 2;
					r2NumT <=  std_logic_vector(to_unsigned(r2,5));
					r2Num <= r2NumT;
					r3 := 3;
					r3NumT <=  std_logic_vector(to_unsigned(r3,5));
					r3Num <= r3NumT;
					out1 <= registers_in(r1)(127 downto 0);
					out2 <= registers_in(r2)(127 downto 0);
					out3 <= registers_in(r3)(127 downto 0);
				end if;	
		        if write_to_reg = '1' then 
					registers_out <= registers_in;
		            registers_out(to_integer(unsigned(rdNum))) <= writtenReg;
		        end if;
   			 end if;
	end process;
end architecture behavioral;