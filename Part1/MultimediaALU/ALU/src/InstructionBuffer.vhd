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

package myPackage is
    type instruc_table is array (0 to 63) of std_logic_vector(24 downto 0);
	type reg_table is array (0 to 31) of std_logic_vector(127 downto 0);
	type instructions_at_stages is array (1 to 4) of std_logic_vector(24 downto 0);
end package;
-------------
library ieee;								  	
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.myPackage.all;
use work.all; 

entity InstrctionBuffer is
    port(
        clk : in std_logic;
        inst : in instruc_table;
        PC: in integer;
        outp : out std_logic_vector(24 downto 0)
    );
end InstrctionBuffer;

architecture behavioral of InstrctionBuffer is
begin
    process(PC)	
		variable  opt :std_logic_vector(24 downto 0);
    begin
       -- if(PC >= 0 and PC < 63) then
			opt := inst(PC);
			outp <= inst(PC);
       -- end if;
    end process;
end architecture behavioral;