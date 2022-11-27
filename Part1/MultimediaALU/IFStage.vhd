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

entity IFStage is
    port(
        clk in: std_logic;
        Instrcution in: std_logic_vector(24 downto 0);
       OutIns out:std_logic_vector(24 downto 0);
    );
    end IFStage;
    architecture behavioral of IFStage is 
    begin
        process(clk)
        begin
            if rising_edge(clk) then 
                OutIns <= Instrcution;
            end if;
        end process;
    end IFStage;