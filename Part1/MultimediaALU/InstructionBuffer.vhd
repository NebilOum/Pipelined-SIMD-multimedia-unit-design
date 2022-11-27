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

library IEEE;
package myPackage is
use IEEE.std_logic_1164.all;	
    type IBuffer is array (0 to 63) of std_logic_vector(24 downto 0);
end package;
-------------

entity InstrctionBuffer is
    port(
        clk : in std_logic;
        reg : in IBuffer;
        PC: in integer;
        previous: out std_logic_vector(24 downto 0);
        outp : out std_logic_vector(24 downto 0);



    );
end InstrctionBuffer;

architecture behavioral of InstrctionBuffer is
type twodi_array is array (0 to 63) of std_logic_vector(24 downto 0);
signal registers : twodi_array;
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            outp <= registers(PC);
            if(PC < 1) then
                previous <= "000000000000000000000000"
            else
                previous <= registers(PC-1);
        
            end if;
        end if;
    end process;


end InstrctionBuffer;