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
	signal stages : instructions_at_stages;
	file input_txt : text;
	file resultFile: text open write_mode is "result.txt";
	constant period : time := 10ns;
begin
	uut:entity multimedia_pipeline port map(
		clk=>tb_clk,
	    instructs =>tb_instruct,
	    register_tble => tb_rgTable,
		stages => stages
		); 
		
	process(stages)
		variable write_to_result : line;
		variable cycleCounter: integer := 0;
	begin
			--file_open(resultFile, "result.txt",  write_mode);
			write(write_to_result, string'("Cycle "));
			write(write_to_result, cycleCounter); 
			write(write_to_result, string'(":")); 
			writeline(resultFile, write_to_result);
			
			write(write_to_result, string'("Instruction at Stage 1: "));
			write(write_to_result, stages(1));
			writeline(resultFile, write_to_result);
			write(write_to_result, string'("Instruction at Stage 2: "));
			write(write_to_result, stages(2));
			writeline(resultFile, write_to_result);
			write(write_to_result, string'("Instruction at Stage 3: "));
			write(write_to_result, stages(3));
			writeline(resultFile, write_to_result);
			write(write_to_result, string'("Instruction at Stage 4: "));
			write(write_to_result, stages(4));
	        writeline(resultFile, write_to_result);
			
			write(write_to_result, 
			string'("-------------------------------------------------------------------------------"));
	        writeline(resultFile, write_to_result);
			cycleCounter := cycleCounter + 1;
			--file_close(resultFile);
			--if cycleCounter = 63 then
--		end if;
		--wait;
		
	end process;

	uut_test:process
			begin 	
				tb_clk <= '0'; 
				wait for period/2;
				tb_clk <= '1'; 
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
--------------------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myPackage.all;
use work.all;  

entity alu_tb is  
end alu_tb;	

architecture testbench of alu_tb is
	-- input
	signal ir1,ir2,ir3 : std_logic_vector(127 downto 0); 
	signal insR : std_logic_vector(24 downto 0);	 
	--- output
	signal oReg : std_logic_vector(127 downto 0);
begin
	ir1(127 downto 96) <= std_logic_vector(to_unsigned(2,32));
	ir1(95 downto 64) <= std_logic_vector(to_unsigned(1,32));
	ir1(63 downto 32) <= std_logic_vector(to_unsigned(2,32));
	ir1(31 downto 0) <= std_logic_vector(to_unsigned(2,32)); 
	
	ir2(127 downto 96) <= std_logic_vector(to_unsigned(5,32));
	ir2(95 downto 64) <= std_logic_vector(to_unsigned(2,32));
	ir2(63 downto 32) <= std_logic_vector(to_unsigned(6,32));
	ir2(31 downto 0) <= std_logic_vector(to_unsigned(2,32));
	
	ir3(127 downto 96) <= std_logic_vector(to_unsigned(2,32));
	ir3(95 downto 64) <= std_logic_vector(to_unsigned(3,32));
	ir3(63 downto 32) <= std_logic_vector(to_unsigned(2,32));
	ir3(31 downto 0) <= std_logic_vector(to_unsigned(2,32));  
	
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
			insR(20 downto 5) <= std_logic_vector(to_unsigned(i+1,16)); --- value that is going to be loaded into rd
			insR(4 downto 0) <= std_logic_vector(to_unsigned(4,5));   --- choose which register is rd, in our case rd is going to be the 4th register
--			assert oReg(((i*16)+15) downto (i*16)) = std_logic_vector(to_unsigned(i,16)) report "Load failed" severity failure;  --- check that the load function was operational 
			wait for 10ns; ---wait 20ns to clearly display waveform
		end loop;
		
		for i in 0 to 7 loop	--- loop to test R4 instructions
			insR(24 downto 23) <= "10";   --- 24th and 23rd bit set to zero so that the ALU ca expect to do R4 operations
			insR(22 downto 20)	 <= std_logic_vector(to_unsigned(i,3));	 --- 3 bits that determine what operation is going to be performed, cycling through all operations in this loop
			insR(19 downto 15) <= std_logic_vector(to_unsigned(3,5));   --- choose which register is rs3, in our case rd is going to be the 3rd register
			insR(14 downto 10) <= std_logic_vector(to_unsigned(2,5));   --- choose which register is rs2, in our case rd is going to be the 2nd register
			insR(9 downto 5) <= std_logic_vector(to_unsigned(1,5));   	 --- choose which register is rs1, in our case rd is going to be the 1st register
			insR(5 downto 0) <= std_logic_vector(to_unsigned(4,6));     --- choose which register is rd, in our case rd is going to be the 4th register
--			assert insR((i*16)+16 downto i*16) = std_logic_vector(to_unsigned(i,15)) report "Load failed" severity error  --- check that the load function was operational 
			wait for 10ns; ---wait 20ns to clearly display waveform
		end loop;
		
		for i in 0 to 15 loop	--- loop to test R3 instructions
			insR(24 downto 23) <= "11";   --- 24th and 23rd bit set to zero so that the ALU ca expect to do R4 operations
			insR(22 downto 15)	 <= std_logic_vector(to_unsigned(i,8));	 --- 8 bits that determine what operation is going to be performed, cycling through all operations in this loop
			insR(14 downto 10) <= std_logic_vector(to_unsigned(2,5));   --- choose which register is rs2, in our case rd is going to be the 2nd register
			insR(9 downto 5) <= std_logic_vector(to_unsigned(1,5));   	 --- choose which register is rs1, in our case rd is going to be the 1st register
			insR(4 downto 0) <= std_logic_vector(to_unsigned(4,5));     --- choose which register is rd, in our case rd is going to be the 4th register
--			assert insR((i*16)+16 downto i*16) = std_logic_vector(to_unsigned(i,15)) report "Load failed" severity error  --- check that the load function was operational 
			wait for 10ns; ---wait 20ns to clearly display waveform
		end loop;
		wait;
		end process	;
end architecture testbench ; 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------	 
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myPackage.all;
use work.all;  

entity instructionBuffer_tb is
end instructionBuffer_tb; 

architecture testbench of instructionBuffer_tb is 
	signal tb_clk : std_logic;
	signal tb_instruct : instruc_table;	
	signal pc : integer := 0; 
	signal outp : std_logic_vector(24 downto 0);
	constant period : time := 10ns;
begin
	uut1:entity InstrctionBuffer port map(
		  clk=>tb_clk,
	      inst =>tb_instruct,
          PC => pc,
          outp => outp
	);
	process 
	begin 
		for i in 0 to 63 loop 
			tb_instruct(i) <= std_logic_vector(to_unsigned(i,25));
		end loop;
		wait;
	end process;
	
	uut_clock:process
			  begin 	
				tb_clk <= '0';
				wait for period/2;
				pc <= pc+1;
				tb_clk <= '1';	  
				wait for period/2;
			  end process;
			
end architecture testbench;
------------------------------------------------------------------------------------------------------------------------------------------------------------- 
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myPackage.all;
use work.all;  

entity registerFile_tb is
end registerFile_tb; 

architecture testbench of registerFile_tb is 
	signal tb_clk,writeToReg,f_writeToReg : std_logic;
	signal tb_instruct : instruc_table;
	signal tb_rgTable : reg_table;	
	signal rdNumI,rdNumO  : std_logic_vector(4 downto 0);
	signal tlb_instruction : std_logic_vector(24 downto 0);--:= "1010010000100001000010001";
	signal data_write :std_logic_vector(127 downto 0):= x"00000000000000000000000000000000";
	signal rs1,rs2,rs3 :std_logic_vector(127 downto 0);
	constant period : time := 10ns;
begin
	uut:entity Register_File port map(
		clk => tb_clk,
        sele => tlb_instruction,
		rdNum => rdNumI,
        write_to_reg => writeToReg,
		registers_in => tb_rgTable,
        writtenReg => data_write, 
		--registers_out => tb_rgTable,
		f_write_to_reg=>f_writeToReg,
        out1 => rs1,
        out2 => rs2,
        out3 => rs3,
		rdNumOut => rdNumO 
	);
	uut_instWrite:process 
		--variable tempInst : std_logic_vector(24 downto 0);
	begin 
		for i in 0 to 7 loop 
			tb_instruct(i)(24) <= '0';											      --- load instructions
			tb_instruct(i)(23 downto 21) <= std_logic_vector(to_unsigned(i,3)); 
			tb_instruct(i)(20 downto 5) <= std_logic_vector(to_unsigned(i+1,16));
			tb_instruct(i)(4 downto 0) <= std_logic_vector(to_unsigned(i,5));         --- choose which register is rd
			--tlb_instruction <= tb_instruct(i);
		end loop;
		for i in 8 to 15 loop 
			tb_instruct(i)(24 downto 23) <= "10"; 									   --- r4 instructions
			tb_instruct(i)(22 downto 20) <= std_logic_vector(to_unsigned(i-8,3));	   --- 3 bits that determine what operation is going to be performed, cycling through all operations in this loop
			tb_instruct(i)(19 downto 15) <= std_logic_vector(to_unsigned(i-4,5));      --- choose which register is rs3
			tb_instruct(i)(14 downto 10) <= std_logic_vector(to_unsigned(i-3,5));      --- choose which register is rs2
			tb_instruct(i)(9 downto 5) <= std_logic_vector(to_unsigned(i-2,5));        --- choose which register is rs1
			tb_instruct(i)(5 downto 0) <= std_logic_vector(to_unsigned(i,6));          --- choose which register is rd
		end loop;
		for i in 16 to 31 loop 					  
			tb_instruct(i)(24 downto 23) <= "11";   								   --- r3 instructions
			tb_instruct(i)(22 downto 15) <= std_logic_vector(to_unsigned(i-16,8));	   --- 8 bits that determine what operation is going to be performed, cycling through all operations in this loop
			tb_instruct(i)(14 downto 10) <= std_logic_vector(to_unsigned(7,5));        --- choose which register is rs2
			tb_instruct(i)(9 downto 5) <= std_logic_vector(to_unsigned(5,5));   	   --- choose which register is rs1
			tb_instruct(i)(4 downto 0) <= std_logic_vector(to_unsigned(i,5));          --- choose which register is rd
		end loop;
		wait;
	end process;
	
	uut_clock:process
				variable i : integer := -1;
			  begin 	
				tb_clk <= '0';
				wait for period/2;
				tb_clk <= '1';
				i:=i+1;
				if (i >= 63) then
					tlb_instruction <= tb_instruct(63);
				else 
					tlb_instruction <= tb_instruct(i);
				end if;
				data_write <= std_logic_vector(to_unsigned(i+1,128));
				rdNumI <= std_logic_vector(to_unsigned(i+1,5));
				if (f_writeToReg = '0') then
					writeToReg <= '0';
				elsif (f_writeToReg = '1')then
					writeToReg <= '1';
				end if;
				
				wait for period/2;
			end process;
end architecture testbench;
-----------------------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myPackage.all;
use work.all;  

entity dataFoward_tb is
end dataFoward_tb; 

architecture testbench of dataFoward_tb is 
	signal dIn,dOut : std_logic_vector(127 downto 0);
	signal rDin,rDout : std_logic_vector(4 downto 0);
	constant period : time := 10ns;
begin
	uut:entity dataFowarding port map(
			dataIn => dIn,
			regNumIn => rDin,
			regNumOut => rDout,
			outResult => dOut
	);
	process
		--variable i: integer := 0;
	begin 
		for i in 0 to 31 loop 
			dIn <= std_logic_vector(to_unsigned(i,128));
			rDin <= std_logic_vector(to_unsigned(i,5));
			wait for period/2;
		end loop;
	--wait;
	end process; 
end architecture testbench;
-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myPackage.all;
use work.all;  

entity fmux_tb is
end fmux_tb; 

architecture testbench of fmux_tb is 
	signal dIn1,dIn2,dIn3,dIn4,dOut1,dOut2,dOut3 : std_logic_vector(127 downto 0);
	signal select_signal : std_logic_vector(2 downto 0);
	constant period : time := 10ns;
begin
	uut:entity fowardMux port map(
			selSignal => select_signal,
			dataIn1 => dIn1,
			dataIn2 => dIn2,
			dataIn3 => dIn3,
			dataIn4 => dIn4,
			outReg1 => dOut1,
			outReg2 => dOut2,
			outReg3 => dOut3
	);
	dIn1 <= std_logic_vector(to_unsigned(1,128));
	dIn2 <= std_logic_vector(to_unsigned(2,128)); 
	dIn3 <= std_logic_vector(to_unsigned(3,128));
	dIn4 <= std_logic_vector(to_unsigned(4,128));
	process
		--variable i: integer := 0;
	begin 
		for i in 0 to 7 loop
			select_signal <= std_logic_vector(to_unsigned(i,3));
			wait for period/2;
		end loop;
	--wait;
	end process; 
end architecture testbench;
-------------------------------------------------------------------------




