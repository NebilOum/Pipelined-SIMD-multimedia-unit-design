--- This documents generates values from the 128 bit inputs and the three instruction operartions 
--- and tests to make sure the vhdl file produces the correct output.
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.all;  

entity alu_tb is
end alu_tb;

architecture testbench of alu_tb is
	--- inputs
	signal ir1,ir2,ir3 : std_logic_vector(127 downto 0); 
	signal insR : std_logic_vector(24 downto 0);	 
	--- ouput
	signal oReg : std_logic_vector(127 downto 0); 
begin  	   
	uut:entity aluIO port map(
		inReg1 => ir1,
		inReg2 => ir2,
		inReg3 => ir3,	
		insReg => insR,
		outReg => oReg
		);
	process
	begin 
		for i in 0 to 7 loop   ---- loop to test the load instruction
			insR(24) <='0';  --- 24th bit set to zero so that the ALU can expect to do a load operation
			insR(23 downto 21) <= std_logic_vector(to_unsigned(i,3)); --- choosing which position the loaded value is being placed in
			insR(20 downto 5) <= std_logic_vector(to_unsigned(i,16)); --- value that is going to be loaded into rd
			insR(5 downto 0) <= std_logic_vector(to_unsigned(4,6));   --- choose which register is rd, in our case rd is going to be the 4th register
--			assert insR(((i*16)+15) downto (i*16)) = std_logic_vector(to_unsigned(i,16)) report "Load failed" severity failure;  --- check that the load function was operational 
			wait for 10ns; ---wait 20ns to clearly display waveform
		end loop;
		
		for i in 0 to 7 loop	--- loop to test R4 instructions
			insR(24 downto 23) <= "10";   --- 24th and 23rd bit set to zero so that the ALU ca expect to do R4 operations
			insR(22 downto 20)	 <= std_logic_vector(to_unsigned(i,3));	 --- 3 bits that determine what operation is going to be performed, cycling through all operations in this loop
			insR(19 downto 15) <= std_logic_vector(to_unsigned(4,5));   --- choose which register is rs3, in our case rd is going to be the 3rd register
			insR(14 downto 10) <= std_logic_vector(to_unsigned(4,5));   --- choose which register is rs2, in our case rd is going to be the 2nd register
			insR(9 downto 5) <= std_logic_vector(to_unsigned(4,5));   	 --- choose which register is rs1, in our case rd is going to be the 1st register
			insR(5 downto 0) <= std_logic_vector(to_unsigned(4,6));     --- choose which register is rd, in our case rd is going to be the 4th register
--			assert insR((i*16)+16 downto i*16) = std_logic_vector(to_unsigned(i,15)) report "Load failed" severity error  --- check that the load function was operational 
			wait for 10ns; ---wait 20ns to clearly display waveform
		end loop;
		
		for i in 0 to 15 loop	--- loop to test R3 instructions
			insR(24 downto 23) <= "11";   --- 24th and 23rd bit set to zero so that the ALU ca expect to do R4 operations
			insR(22 downto 15)	 <= std_logic_vector(to_unsigned(i,8));	 --- 3 bits that determine what operation is going to be performed, cycling through all operations in this loop
			insR(14 downto 10) <= std_logic_vector(to_unsigned(4,5));   --- choose which register is rs2, in our case rd is going to be the 2nd register
			insR(9 downto 5) <= std_logic_vector(to_unsigned(4,5));   	 --- choose which register is rs1, in our case rd is going to be the 1st register
			insR(4 downto 0) <= std_logic_vector(to_unsigned(4,5));     --- choose which register is rd, in our case rd is going to be the 4th register
--			assert insR((i*16)+16 downto i*16) = std_logic_vector(to_unsigned(i,15)) report "Load failed" severity error  --- check that the load function was operational 
			wait for 10ns; ---wait 20ns to clearly display waveform
		end loop; 
		wait;
	end process;
	
end testbench;