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
        clk :in std_logic;
        Instruction : in std_logic_vector(24 downto 0);
       	OutIns : out std_logic_vector(24 downto 0)
    );
end IFStage; 

architecture behavioral of IFStage is 
	signal temp: std_logic_vector(24 downto 0); 
	signal rdTemp :std_logic_vector (4 downto 0);
    begin
        process(clk)
        begin
            if rising_edge(clk) then 
                OutIns <= Instruction;  
            end if;
        end process;
end architecture;