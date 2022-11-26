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

-------------
type IBuffer is array (0 to 63) of std_logic_vector(127 downto 0);
entity InstrctionBuffer is
    port(
        clk : in std_logic;
        reg : in IBuffer;
        PC: in integer;
        outp : out std_logic_vector;



    );
end InstrctionBuffer;
architecture behavioral of InstrctionBuffer is
type twodi_array is array (0 to 63) of std_logic_vector(7 downto 0);
signal registers : twodi_array;
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            outp <= registers(PC);
        end if;
    end process;


end InstrctionBuffer;