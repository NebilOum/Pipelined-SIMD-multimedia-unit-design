----------------------------------------------------------------------------------------
---ESE 345 Porject: Pipelined SIMD multimedia unit design	
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
		registers_in : inout reg_table;
		rdNum : in std_logic_vector(4 downto 0);
        write_to_reg: in std_logic;
        writtenReg: in std_logic_vector(127 downto 0); 
		--registers_out :	out reg_table;
		r1Num,r2Num,r3Num,rdNumOut  : out std_logic_vector(4 downto 0);
		f_write_to_reg: out std_logic;
        out1: out std_logic_vector(127 downto 0);
        out2: out std_logic_vector(127 downto 0);
        out3: out std_logic_vector(127 downto 0)
    );
end entity Register_File;

architecture behavioral of Register_File is
			signal r1NumT,r2NumT,r3NumT : integer:= 0;
		    signal r1,r2,r3:integer := 0;
			
begin 
	
	process(sele)
		variable r1,r2,r3: integer:=0;
		variable r_in :reg_table;
	begin
		if	(write_to_reg = '1') then
			r_in(to_integer(unsigned(rdNum))) := writtenReg;
			registers_in <= r_in;
		end if;
		rdNumOut <= sele(4 downto 0);
		r1Num <= sele(9 downto 5);
		r2Num <= sele(14 downto 10);
		r3Num <= sele(19 downto 15);
		--registers_in(to_integer(unsigned(rdNum))) <= writtenReg when ; --and (rising_edge(clk));
	
		r1 := to_integer(unsigned (sele(9 downto 5)));
		r1NumT <= r1;
		r2 := to_integer(unsigned(sele(14 downto 10)));	
		r2NumT <= r2;
		r3 := to_integer (unsigned (sele(19 downto 15)));
		r3NumT <= r3;
		
		
		if sele(24 downto 23) = "11" then  --r3 instructions
					if sele(18 downto 15) = "0000" then
						f_write_to_reg <= '0'; 
					else 
						f_write_to_reg <= '1';
					end if;
		 elsif sele(24) = '0' then
			 f_write_to_reg <= '1';
		 elsif sele(24 downto 23) ="11" then
			 f_write_to_reg <= '1';
      end if;
	end process;
	out1 <= registers_in(r1NumT)(127 downto 0);
	out2 <= registers_in(r2NumT)(127 downto 0);
	out3 <= registers_in(r3NumT)(127 downto 0);
end architecture behavioral;