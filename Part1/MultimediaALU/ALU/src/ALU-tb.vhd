--- This documents generates values from the 128 bit inputs and the three instruction operartions 
--- and tests to make sure the vhdl file produces the correct output.
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.all;  

entity alu_tb is
end alu_tb;

architecture testbench of alu_tb is
	port map(
		clk => clk
		inReg1 => ir1
		inReg2 => ir2
		inReg3 => ir3,	
		intsReg3 => iR3,
		intsReg4 => iR4,
		outReg => oReg
		); 
--signal;
begin 
	
end testbench;