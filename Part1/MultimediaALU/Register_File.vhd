----------------------------------------------------------------------------------------
---ESE 345 Porject: Pipelined SIMD multimedia unit design - Part 2	
---Authors: Nebil Oumer and Elijah Farrell
---File:register FIle.vhd
---11/23/2022
----------------------------------------------------------------------------------------
library ieee;								  	
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.all;  
/*Assembler, instruction buffer, if/id stage, register file and id/ex stage*/
entity Register_File is
    port (
        clk : in std_logic;
        sele: in std_logic_vector(24 downto 0);
        write_to_reg: in std_logic;
        writtenReg: in std_logic_vector(127 downto 0);
        out1: out std_logic_vector(127 downto 0);
        out2: out std_logic_vector(127 downto 0);
        out3: out std_logic_vector(127 downto 0);


    );
end entity Register_File;

architecture behavioral of Register_File is
type twodi_array is array (0 to 31) of std_logic_vector(127 downto 0);
signal registers : twodi_array;
signal write_to_reg : integer;
begin
    process(clk);
    variable t1:integer;
    variable t2:integer;
    variable t3:integer;
        begin
            if rising_edge(clk) then
                
			    if sele (24 downto 23) = "11" then --r3 instructions
			        t1 := to_integer(unsigned (sele(9 downto 5)));
				    out1 <= registers( t1)(127 downto 0);
			        t2 := to_integer(unsigned(sele(14 downto 10)));
                    out2 <= registers(t2)(127 downto 0);
                elsif sele(24 downto 23) ="10" then--r4 instructions
                        t1 := to_integer(unsigned (sele(9 downto 5)));	 
                        out1 <= registers( t1)(127 downto 0);
                        t2 := to_integer(unsigned(sel(14 downto 10)));
                        out2 <= registers(t2)(127 downto 0);
                        t3 := to_integer (unsigned (sele(19 downto 15)));
                        out3 <= regsisters(t3)(127 downto 0); 	 
			
		
		end if;	
        if write_to_reg = '1' then
            registers(write_to_reg) <= writtenReg;
        end if;
    end if;
end process;
end Register_File;