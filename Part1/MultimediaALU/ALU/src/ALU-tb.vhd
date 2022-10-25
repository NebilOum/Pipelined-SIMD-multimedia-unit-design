--- This documents generates values from the 128 bit inputs and the three instruction operartions 
--- and tests to make sure the vhdl file produces the correct output.
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.all;  

entity alu_tb is
end alu_tb;

architecture testbench of alu_tb is	  
	signal clk: std_logic;
	signal ir1,ir2,ir3 : std_logic_vector(127 downto 0); 
	signal insR3,insR4 : std_logic_vector(24 downto 0);
	signal oReg : std_logic_vector(127 downto 0); 
--signal;
begin  
	uut:entity aluIO port map(
		clk => clk,
		inReg1 => ir1,
		inReg2 => ir2,
		inReg3 => ir3,	
		insReg3 => insR3,
		insReg4 => insR4,
		outReg => oReg
		);		
	process
	begin
--		for i in 0 to loop
--			assert oReg  report "failed" severtiy failure;
--		end loop;
	end process;
	
end testbench;