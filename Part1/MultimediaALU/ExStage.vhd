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

entity ExStage is
    port(
        clk in:std_logic;
        inp1 in: std_logic_vector(127 downto 0);
        inp2 in: std_logic_vector(127 downto 0);
        inp3 in: std_logic_vector(127 downto 0);

        out1 out: std_logic_vector(127 downto 0);
        out2 out: std_logic_vector(127 downto 0);
        out3 out: std_logic_vector(127 downto 0);
    );
    end ExStage;
architecture behavioral of ExStage is 
    begin
        process(clk)
        begin
            if rising_edge(clk) then
                out1 <= inp1;
                out2 <= inp2;
                out3 <= inp3;
            end if;
        end process;
    end ExStage;