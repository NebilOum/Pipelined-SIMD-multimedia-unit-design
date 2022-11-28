--- This documents generates values from the 128 bit inputs and the three instruction operartions 
--- and tests to make sure the vhdl file produces the correct output.
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myPackage.all;
use work.all;  

entity pipeline_tb is
end pipeline_tb;

architecture testbench of pipeline_tb is

	signal tb_clk : std_logic;
	signal tb_instruct : instruc_table;
	signal tb_rgTable : reg_table;
--	signal ir1,ir2,ir3 : std_logic_vector(127 downto 0); 
--	signal insR : std_logic_vector(24 downto 0);	 
--	--- ouput
--	signal oReg : std_logic_vector(127 downto 0); 
--	
--	type inst_arr is array (0 to 63) of std_logic_vector(24 downto 0);
--	signal inst_table: inst_arr; 
	
file input_txt : text;
constant period : time := 10ns;
begin
	uut0:entity multimedia_pipeline port map(
		clk=>tb_clk,
	    instructs =>tb_instruct,
	    register_tble => tb_rgTable
		); 
--	uut1:entity InstrctionBuffer port map(
--		  clk=>tb_clk,
--	      instructs =>tb_instruct,
--        PC: in integer;
--        outp : out std_logic_vector(24 downto 0)
--		);
--	uut1:entity Register_file port map(
----		  clk : in std_logic;
--        sele: in std_logic_vector(24 downto 0);
--		rdNum : in integer;
--        write_to_reg: in std_logic;
--		registers_in : in reg_table;
--        writtenReg: in std_logic_vector(127 downto 0); 
--		registers_out :	out reg_table;
--        out1: out std_logic_vector(127 downto 0);
--        out2: out std_logic_vector(127 downto 0);
--        out3: out std_logic_vector(127 downto 0)
--		);
--	uut2:entity aluIO port map(
--		inReg1 => ir1,
--		inReg2 => ir2,
--		inReg3 => ir3,	
--		insReg => insR,
--		outReg => oReg
--		);
--	uut2:entity dataFowarding port map(
----		dataIn: in std_logic_vector(127 downto 0); ---- input values from 3rd stage output
--		regNumIn: in std_logic_vector(4 downto 0); ---  input from the alu output
--		regNumOut: out std_logic_vector(4 downto 0); --- register number used to compare with foward mux inputs
--		outResult: out std_logic_vector(127 downto 0) ---- output registe
--		);
	uut_test:process
			begin 	
				tb_clk <= '1';
				wait for period/2;
				tb_clk <= '0';
				wait for period/2;
			end process;
	
file_read:process
			variable read_from_input_txt : line;
			variable opcode : std_logic_vector(24 downto 0);
			variable counter : integer := 0;
		  begin
			file_open(input_txt, "tb_input.txt",  read_mode);
			while not endfile(input_txt) loop
	          readline(input_txt, read_from_input_txt);
	          read(read_from_input_txt, opcode);
			  tb_instruct(counter) <= opcode;
			  counter := counter + 1;
			end loop;
			 wait;
			 file_close(input_txt); 
		  end process;
	
end testbench;
--	ir1(127 downto 96) <= std_logic_vector(to_unsigned(2,32));
--	ir1(95 downto 64) <= std_logic_vector(to_unsigned(1,32));
--	ir1(63 downto 32) <= std_logic_vector(to_unsigned(2,32));
--	ir1(31 downto 0) <= std_logic_vector(to_unsigned(2,32)); 
--	
--	ir2(127 downto 96) <= std_logic_vector(to_unsigned(5,32));
--	ir2(95 downto 64) <= std_logic_vector(to_unsigned(2,32));
--	ir2(63 downto 32) <= std_logic_vector(to_unsigned(6,32));
--	ir2(31 downto 0) <= std_logic_vector(to_unsigned(2,32));
--	
--	ir3(127 downto 96) <= std_logic_vector(to_unsigned(2,32));
--	ir3(95 downto 64) <= std_logic_vector(to_unsigned(3,32));
--	ir3(63 downto 32) <= std_logic_vector(to_unsigned(2,32));
--	ir3(31 downto 0) <= std_logic_vector(to_unsigned(2,32));

--		for i in 0 to 7 loop   ---- loop to test the load instruction
--			insR(24) <='0';  --- 24th bit set to zero so that the ALU can expect to do a load operation
--			insR(23 downto 21) <= std_logic_vector(to_unsigned(i,3)); --- choosing which position the loaded value is being placed in
--			insR(20 downto 5) <= std_logic_vector(to_unsigned(i+1,16)); --- value that is going to be loaded into rd
--			insR(4 downto 0) <= std_logic_vector(to_unsigned(4,5));   --- choose which register is rd, in our case rd is going to be the 4th register
----			assert oReg(((i*16)+15) downto (i*16)) = std_logic_vector(to_unsigned(i,16)) report "Load failed" severity failure;  --- check that the load function was operational 
--			wait for 10ns; ---wait 20ns to clearly display waveform
--		end loop;
--		
		--for i in 0 to 7 loop	--- loop to test R4 instructions
--			insR(24 downto 23) <= "10";   --- 24th and 23rd bit set to zero so that the ALU ca expect to do R4 operations
--			insR(22 downto 20)	 <= std_logic_vector(to_unsigned(i,3));	 --- 3 bits that determine what operation is going to be performed, cycling through all operations in this loop
--			insR(19 downto 15) <= std_logic_vector(to_unsigned(3,5));   --- choose which register is rs3, in our case rd is going to be the 3rd register
--			insR(14 downto 10) <= std_logic_vector(to_unsigned(2,5));   --- choose which register is rs2, in our case rd is going to be the 2nd register
--			insR(9 downto 5) <= std_logic_vector(to_unsigned(1,5));   	 --- choose which register is rs1, in our case rd is going to be the 1st register
--			insR(5 downto 0) <= std_logic_vector(to_unsigned(4,6));     --- choose which register is rd, in our case rd is going to be the 4th register
----			assert insR((i*16)+16 downto i*16) = std_logic_vector(to_unsigned(i,15)) report "Load failed" severity error  --- check that the load function was operational 
--			wait for 10ns; ---wait 20ns to clearly display waveform
--		end loop;
		
--		for i in 0 to 15 loop	--- loop to test R3 instructions
--			insR(24 downto 23) <= "11";   --- 24th and 23rd bit set to zero so that the ALU ca expect to do R4 operations
--			insR(22 downto 15)	 <= std_logic_vector(to_unsigned(i,8));	 --- 3 bits that determine what operation is going to be performed, cycling through all operations in this loop
--			insR(14 downto 10) <= std_logic_vector(to_unsigned(2,5));   --- choose which register is rs2, in our case rd is going to be the 2nd register
--			insR(9 downto 5) <= std_logic_vector(to_unsigned(1,5));   	 --- choose which register is rs1, in our case rd is going to be the 1st register
--			insR(4 downto 0) <= std_logic_vector(to_unsigned(4,5));     --- choose which register is rd, in our case rd is going to be the 4th register
----			assert insR((i*16)+16 downto i*16) = std_logic_vector(to_unsigned(i,15)) report "Load failed" severity error  --- check that the load function was operational 
--			wait for 10ns; ---wait 20ns to clearly display waveform
--		end loop; 