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
		rdNum : in std_logic_vector(4 downto 0);
        write_to_reg: in std_logic;
		registers_in : in reg_table;
        writtenReg: in std_logic_vector(127 downto 0); 
		registers_out :	out reg_table;
		r1Num,r2Num,r3Num  : out std_logic_vector(4 downto 0);
        out1: out std_logic_vector(127 downto 0);
        out2: out std_logic_vector(127 downto 0);
        out3: out std_logic_vector(127 downto 0)
    );
end entity Register_File;

architecture behavioral of Register_File is
begin
    process(clk)
		    variable r1:integer;
		    variable r2:integer;
		    variable r3:integer;
    begin
            if rising_edge(clk) then
			    if sele (24 downto 23) = "11" then  --r3 instructions
			        r1 := to_integer(unsigned (sele(9 downto 5)));
				    out1 <= registers_in(r1)(127 downto 0);
			        r2 := to_integer(unsigned(sele(14 downto 10)));
                    out2 <= registers_in(r2)(127 downto 0);
                elsif sele(24 downto 23) ="10" then --r4 instructions
                    r1 := to_integer(unsigned (sele(9 downto 5)));	 
                    out1 <= registers_in( r1)(127 downto 0);
                    r2 := to_integer(unsigned(sele(14 downto 10)));
                    out2 <= registers_in(r2)(127 downto 0);
                    r3 := to_integer (unsigned (sele(19 downto 15)));
                    out3 <= registers_in(r3)(127 downto 0);
				elsif sele(24) = '0' then
					r1 := 1;
					r2 := 2;
					r3 := 3;
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