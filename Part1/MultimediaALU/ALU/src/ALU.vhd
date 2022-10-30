----------------------------------------------------------------------------------------
---ESE 345 Porject: Pipelined SIMD multimedia unit design - Part 1	
---Authors: Nebil Oumer and Elijah Farrell
---File:ALU.vhdl
---10/30/2022 
----------------------------------------------------------------------------------------
library ieee;								  	
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.all;  

entity aluIO is   --- the three 128 bit inputs and the one 128 bit output register	
	generic (
	m : integer := 16;
	a,m_long,s:integer := 32;
	a_long,s_long:integer := 64);
	port(  
	inReg1, inReg2, inReg3: in std_logic_vector(127 downto 0);	---- input registers
	insReg: in std_logic_vector(24 downto 0); ---- instruction input
	outReg: out std_logic_vector(127 downto 0)	  ---- output register
	);
end aluIO;

architecture alu of aluIO is	 
------------------------------------------------------------------------------ procedure to do multiplication of two 16-bit inputs
 	procedure mult(signal xsign : in std_logic;
 				signal in1,in2 : in std_logic_vector(m-1 downto 0);
				signal oput : out std_logic_vector(m-1 downto 0)) is
	begin
		if 	xsign = '1' then	  
			oput <= std_logic_vector(resize((signed(in1) * signed(in2)),m)); 
		else 
			oput <= std_logic_vector(resize((unsigned(in1) * unsigned(in2)),m));
		end if;
	end procedure;
	
------------------------------------------------------------------------------ procedure to do multiplication of two 32-bit inputs
 	procedure mult_long( signal xsign : in std_logic;
 					  signal in1,in2 : in std_logic_vector(m_long-1 downto 0);
				   	  signal oput : out std_logic_vector(m_long-1 downto 0)) is
	begin
		if 	xsign = '1' then 			  --- signed subtraction
			oput <= std_logic_vector(resize((signed(in1) - signed(in2)),m_long)); 
		else 
			oput <= std_logic_vector(resize((unsigned(in1) - unsigned(in2)),m_long));
		end if;
	end procedure;
 	
----------------------------------------------------------------------------- prodcedure to do adddition of two 32 bit inputs
	procedure add(signal xsign : in std_logic; 
				  signal in1,in2 : in std_logic_vector(a-1 downto 0);
				  signal oput : out std_logic_vector(a-1 downto 0)) is
	begin
		if 	xsign = '1' then	  
			oput <= std_logic_vector(resize((signed(in1) + signed(in2)),a)); 
		else 
			oput <= std_logic_vector(resize((unsigned(in1) + unsigned(in2)),a));
		end if;
	end procedure;
	
----------------------------------------------------------------------------- procedure to do addition of two 16 bit inputs
	procedure add_half(signal xsign : in std_logic; 
				  signal in1,in2 : in std_logic_vector(15 downto 0);
				  signal oput : out std_logic_vector(15 downto 0)) is
	begin
		if 	xsign = '1' then	  
			oput <= std_logic_vector(resize((signed(in1) + signed(in2)),16)); 
		else 
			oput <= std_logic_vector(resize((unsigned(in1) + unsigned(in2)),16));
		end if;
	end procedure;	
----------------------------------------------------------------------------- prodcedure to do adddition of two 64 bit inputs
	procedure add_long( signal xsign : in std_logic;
				   signal in1,in2 : in std_logic_vector(a_long-1 downto 0);
				   signal oput : out std_logic_vector(a_long-1 downto 0)) is
	begin
		if 	xsign = '1' then 
			oput <= std_logic_vector(resize((signed(in1) + signed(in2)),a_long)); 
		else 
			oput <= std_logic_vector(resize((unsigned(in1) + unsigned(in2)),a_long));
		end if;
	end procedure; 
	
----------------------------------------------------------------------------- prodcedure to do subtraction of two 32 bit inputs
	procedure sub(signal xsign : in std_logic;
				  signal in1,in2 : in std_logic_vector(s-1 downto 0);
				  signal oput : out std_logic_vector(s-1 downto 0)) is
	begin
		if 	xsign = '1' then 			  --- signed subtraction
			oput <= std_logic_vector(resize((signed(in1) - signed(in2)),s)); 
		else 
			oput <= std_logic_vector(resize((unsigned(in1) - unsigned(in2)),s));
		end if;
	end procedure;  
	
----------------------------------------------------------------------------- procedure to do subtraction of two 64 bit inputs
	procedure sub_long( signal xsign : in std_logic;
				   signal in1,in2 : in std_logic_vector(s_long-1 downto 0);
				   signal oput : out std_logic_vector(s_long-1 downto 0)) is
	begin 
		if 	xsign = '1' then
			oput <= std_logic_vector(resize((signed(in1) - signed(in2)),s_long)); 
		else 
			oput <= std_logic_vector(resize((unsigned(in1) - unsigned(in2)),s_long));
		end if;
	end procedure;
	
---------------------------------------------------------------------------	
 	procedure sat_half(signal input:in std_logic_vector(15 downto 0);
			   	   			signal output:out std_logic_vector(15 downto 0)) is	
	begin
		if(input > x"7FFF") then
			output <= x"7FFF";
		elsif (input < x"8000") then
			output <= x"8000";
		end if;
	end procedure;
	
---------------------------------------------------------------------------
 	procedure sat_int(signal input:in std_logic_vector(31 downto 0);
			   	   signal output:out std_logic_vector(31 downto 0)) is	
	begin
		if(input > x"7FFFFFFF") then
			output <= x"7FFFFFFF";
		elsif (input < x"80000000") then
			output <= x"80000000";
		end if;
	end procedure;
	
---------------------------------------------------------------------------
	procedure sat_long(signal input:in std_logic_vector(63 downto 0);
			   	   		   signal output:out std_logic_vector(63 downto 0)) is	
	begin
		if(input > x"7FFFFFFFFFFFFFFF") then
			output <= x"7FFFFFFFFFFFFFFF";
		elsif (input < x"8000000000000000") then
			output <= x"8000000000000000";
		end if;
	end procedure;
	
---------------------------------------------------------------------------
	procedure load(signal instruc:in std_logic_vector(24 downto 0);
			   	   signal output:out std_logic_vector(127 downto 0)) is	
			   variable position : integer;
	begin
		position := to_integer(unsigned(instruc(23 downto 21)));
		output((position*16)-15 downto (position*16)) <= instruc(20 downto 5);
	end procedure;
	
---------------------------------------------------------------------------------
	procedure clzw(signal input:in std_logic_vector(31 downto 0);
			   	   signal output:out std_logic_vector(31 downto 0)) is	
			   variable i : integer := 31;
			   variable counter : integer := 0;
	begin 
		while input(i) = '0' loop
			counter := counter + 1;
			i := i-1;
		end loop;
		output <= std_logic_vector(to_unsigned(counter,32));
	end procedure;

--------------------------------------------------------------------------
	procedure maxws(signal input1,input2:in std_logic_vector(31 downto 0);
					signal output:out std_logic_vector(31 downto 0)) is
	begin 
		if( input1 > input2) then
			output <= input1;
		elsif (input1 < input2) then
			output <= input2;
		end if;
	end procedure;

--------------------------------------------------------------------------
	procedure minws(signal input1,input2:in std_logic_vector(31 downto 0);
					signal output:out std_logic_vector(31 downto 0)) is
	begin 
		if( input1 > input2) then
			output <= input2;
		elsif (input1 < input2) then
			output <= input1;
		end if;
	end procedure;
	
------------------------------------------------------------------------------
	signal tempOut_half : std_logic_vector(16 downto 0);
	signal Tempout: std_logic_vector(31 downto 0);
	signal Tempout_L: std_logic_vector(63 downto 0);
	signal signOp : std_logic := '1';
	signal noSignOp : std_logic := '0';
	
begin  
	process(insReg)	 
		variable counter :integer := 0;
	begin		
		load:if(insReg(24) = '0') then --check insReg is a load instruction
				load(insReg,outReg);
		end if load;
		--a=32, m=16--
		r4:if(insReg(24 downto 23) = "10") then --check if inReg is a r3 instruction
			if insReg(22 downto 20)= "000" then	 --signed integer multiply-add low with saturation
				mult(signOp,inReg3(m-1 downto 0),inReg2(m-1 downto 0),Tempout); 
				add(signOp,Tempout,inReg1(a-1 downto 0),Tempout);
				sat_int(Tempout,outReg(a-1 downto 0));
				
				mult(signOp,inReg3(47 downto a),inReg2(47 downto a),Tempout);
				add(signOp,Tempout,inReg1(63 downto a),Tempout);
				sat_int(Tempout,outReg(63 downto a));
				
				mult(signOp,inReg3(79 downto 64),inReg2(79 downto 64),Tempout);
				add(signOp,Tempout,inReg1(95 downto 64),Tempout);
				sat_int(Tempout,outReg(95 downto 64));
				
				mult(signOp,inReg3(111 downto 96),inReg2(111 downto 96),Tempout);
				add(signOp,Tempout,inReg1(127 downto 96),Tempout);
				sat_int(Tempout,outReg(127 downto 96));
				
			elsif insReg(22 downto 20) = "001" then--signed integer multiply-add high with saturation
				
				mult(signOp,inReg3(a-1 downto m),inReg2(a-1 downto m),Tempout);
				add(signOp,Tempout,inReg1(a-1 downto 0),Tempout);
				sat_int(Tempout,outReg(a-1 downto 0));
				
				mult(signOp,inReg3(63 downto 48),inReg2(63 downto 48),Tempout);
				add(signOp,Tempout,inReg1(63 downto a),Tempout);
				sat_int(Tempout,outReg(63 downto a));
				
				mult(signOp,inReg3(95 downto 80),inReg2(95 downto 80),Tempout);
				add(signOp,Tempout,inReg1(95 downto 64),Tempout);
				sat_int(Tempout,outReg(95 downto 64));
				
				mult(signOp,inReg3(127 downto 112),inReg2(127 downto 112),Tempout);
				add(signOp,Tempout,inReg1(127 downto 96),Tempout);
				sat_int(Tempout,outReg(127 downto 96));
				
			elsif insReg(22 downto 20)="010" then--signed integer multiply-subtract low with saturation
				
				mult(signOp,inReg3(a-1 downto m),inReg2(a-1 downto m),Tempout);
				sub(signOp,inReg1(a-1 downto 0),Tempout,Tempout);
				sat_int(Tempout,outReg(a-1 downto 0));
				
				mult(signOp,inReg3(63 downto 48),inReg2(63 downto 48),Tempout);
				sub(signOp,inReg1(63 downto a),Tempout,Tempout);
				sat_int(Tempout,outReg(63 downto a));
				
				mult(signOp,inReg3(95 downto 80),inReg2(95 downto 80),Tempout);
				sub(signOp,inReg1(95 downto 64),Tempout,Tempout);
				sat_int(Tempout,outReg(95 downto 64));
				
				mult(signOp,inReg3(127 downto 112),inReg2(127 downto 112),Tempout);
				sub(signOp,inReg1(127 downto 96),Tempout,Tempout);
				sat_int(Tempout,outReg(127 downto 96));
				
			elsif insReg(22 downto 20)="011" then --signed integer multiply-subtract high with saturation
				
				mult(signOp,inReg3(a-1 downto m),inReg2(a-1 downto m),Tempout);
				sub(signOp,inReg1(a-1 downto 0),Tempout,Tempout);
				sat_int(Tempout,outReg(a-1 downto 0));
				
				mult(signOp,inReg3(63 downto 48),inReg2(63 downto 48),Tempout);
				sub(signOp,inReg1(63 downto a),Tempout,Tempout);
				sat_int(Tempout,outReg(63 downto a));
				
				mult(signOp,inReg3(95 downto 80),inReg2(95 downto 80),Tempout);
				sub(signOp,inReg1(95 downto 64),Tempout,Tempout); 
				sat_int(Tempout,outReg(95 downto 64));
				
				mult(signOp,inReg3(127 downto 112),inReg2(127 downto 112),Tempout);
				sub(signOp,inReg1(127 downto 96),Tempout,Tempout);
				sat_int(Tempout,outReg(127 downto 96));
				
			elsif insReg(22 downto 20)="100" then  --signed long multiply-add low with saturation
				
				mult_long(signOp,inReg3(m_long-1 downto 0),inReg2(m_long-1 downto 0),Tempout_L);
				add_long(signOp,Tempout_L,inReg1(a_long-1 downto 0),Tempout_L);
				sat_long(Tempout_L,outReg(a_long-1 downto 0));
				
				mult_long(signOp,inReg3(95 downto 64),inReg2(95 downto 64),Tempout_L);
				add_long(signOp,Tempout_L,inReg1(127 downto 64),Tempout_L);
				sat_long(Tempout_L,outReg(127 downto 64));
				
				
			elsif insReg(22 downto 20)="101" then  --signed long multiply-add high with saturation
				
				mult_long(signOp,inReg3(a_long-1 downto a),inReg2(a_long-1 downto a),Tempout_L);
				add_long(signOp,Tempout_L,inReg1(a_long-1 downto 0),Tempout_L);
				sat_long(Tempout_L,outReg(a_long-1 downto 0));
				
				mult_long(signOp,inReg3(127 downto 96),inReg2(127 downto 96),Tempout_L);
				add_long(signOp,Tempout_L,inReg1(127 downto 64),Tempout_L);
				sat_long(Tempout_L,outReg(127 downto 64));
				
			elsif insReg(22 downto 20)="110" then --signed long multiply-subtract low with saturation
				
				mult_long(signOp,inReg3(m_long-1 downto 0),inReg2(m_long-1 downto 0),Tempout_L);
				sub_long(signOp,inReg1(a_long-1 downto 0),Tempout_L,Tempout_L);
				sat_long(Tempout_L,outReg(a_long-1 downto 0));
				
				mult_long(signOp,inReg3(95 downto 64),inReg2(95 downto 64),Tempout_L);
				sub_long(signOp,inReg1(127 downto 64),Tempout_L,Tempout_L);
				sat_long(Tempout_L,outReg(127 downto 64));
				
			elsif insReg(22 downto 20)="111" then --signed long multiply-subtract high with saturation
				mult_long(signOp,inReg3(a_long-1 downto a),inReg2(a_long-1 downto a),Tempout_L);
				sub_long(signOp,inReg1(a_long-1 downto 0),Tempout_L,Tempout_L);
				sat_long(Tempout_L,outReg(a_long-1 downto 0));
				
				mult_long(signOp,inReg3(127 downto 96),inReg2(127 downto 96),Tempout_L);
				sub_long(signOp,inReg1(127 downto 64),Tempout_L,Tempout_L);
				sat_long(Tempout_L,outReg(127 downto 64));
			end if;	--- end of if loop that goes through all possible r4 instructions
		end if r4;
			
	
	
		r3:if(insReg(24 downto 23) = "11") then	  -- checks if a r3 operation is being performed
			if(insReg(18 downto 15) = "0000" ) then	-- nop operation
				Null;
			elsif (insReg(18 downto 15) = "0001") then	---CLZW operation
				clzw(inReg1(31 downto 0),outReg(31 downto 0));
				clzw(inReg1(63 downto 32),outReg(63 downto 32));
				clzw(inReg1(95 downto 64),outReg(95 downto 64));
				clzw(inReg1(127 downto 96),outReg(127 downto 96)); 
			elsif (insReg(18 downto 15) = "0010") then  ---AU operation
				add(noSignOp,inReg1(31 downto 0),inReg2(31 downto 0),outReg(31 downto 0));
				add(noSignOp,inReg1(63 downto 32),inReg2(63 downto 32),outReg(63 downto 32));
				add(noSignOp,inReg1(95 downto 64),inReg2(95 downto 64),outReg(95 downto 64));
				add(noSignOp,inReg1(127 downto 96),inReg2(127 downto 96),outReg(127 downto 96));
			elsif (insReg(18 downto 15) = "0011") then	---AHU operation
				add_half(noSignOp,inReg1(15 downto 0),inReg2(15 downto 0),outReg(15 downto 0));
				add_half(noSignOp,inReg1(31 downto 16),inReg2(31 downto 16),outReg(31 downto 16));
				add_half(noSignOp,inReg1(47 downto 32),inReg2(47 downto 32),outReg(47 downto 32));
				add_half(noSignOp,inReg1(63 downto 48),inReg2(63 downto 48),outReg(63 downto 48));
				add_half(noSignOp,inReg1(79 downto 64),inReg2(79 downto 64),outReg(79 downto 64));
				add_half(noSignOp,inReg1(95 downto 80),inReg2(95 downto 80),outReg(95 downto 80));
				add_half(noSignOp,inReg1(111 downto 96),inReg2(111 downto 96),outReg(111 downto 96));
				add_half(noSignOp,inReg1(127 downto 112),inReg2(127 downto 112),outReg(127 downto 112));
			elsif (insReg(18 downto 15) = "0100") then ---AHS operation
				add_half(signOp,inReg1(15 downto 0),inReg2(15 downto 0),outReg(15 downto 0));
				add_half(signOp,inReg1(31 downto 16),inReg2(31 downto 16),outReg(31 downto 16));
				add_half(signOp,inReg1(47 downto 32),inReg2(47 downto 32),outReg(47 downto 32));
				add_half(signOp,inReg1(63 downto 48),inReg2(63 downto 48),outReg(63 downto 48));
				add_half(signOp,inReg1(79 downto 64),inReg2(79 downto 64),outReg(79 downto 64));
				add_half(signOp,inReg1(95 downto 80),inReg2(95 downto 80),outReg(95 downto 80));
				add_half(signOp,inReg1(111 downto 96),inReg2(111 downto 96),outReg(111 downto 96));
				add_half(signOp,inReg1(127 downto 112),inReg2(127 downto 112),outReg(127 downto 112));
			elsif (insReg(18 downto 15) = "0101") then ---AND operation
				outReg <= inReg1 and inReg2;
			elsif (insReg(18 downto 15) = "0110") then ---BCW operation
				outReg(31 downto 0) <= inReg1(31 downto 0);
				outReg(63 downto 32) <= inReg1(31 downto 0);
				outReg(95 downto 64) <= inReg1(31 downto 0);
				outReg(127 downto 96) <= inReg1(31 downto 0);
			elsif (insReg(18 downto 15) = "0111") then --- MAXWS operation
				maxws(inReg1(31 downto 0),inReg2(31 downto 0),outReg(31 downto 0));
				maxws(inReg1(63 downto 32),inReg2(63 downto 32),outReg(63 downto 32));
				maxws(inReg1(95 downto 64),inReg2(95 downto 64),outReg(95 downto 64));
				maxws(inReg1(127 downto 96),inReg2(127 downto 96),outReg(127 downto 96));
			elsif (insReg(18 downto 15) = "1000") then	--- MINWS operation
				minws(inReg1(31 downto 0),inReg2(31 downto 0),outReg(31 downto 0));
				minws(inReg1(63 downto 32),inReg2(63 downto 32),outReg(63 downto 32));
				minws(inReg1(95 downto 64),inReg2(95 downto 64),outReg(95 downto 64));
				minws(inReg1(127 downto 96),inReg2(127 downto 96),outReg(127 downto 96));
	--			elsif (insReg(18 downto 15) = "1001") then
	--			elsif (insReg(18 downto 15) = "1010") then
	--			elsif (insReg(18 downto 15) = "1011") then
	--			elsif (insReg(18 downto 15) = "1100") then
	--			elsif (insReg(18 downto 15) = "1101") then
	--			elsif (insReg(18 downto 15) = "1110") then
	--			elsif (insReg(18 downto 15) = "1111") then
		  	end if ;
		end if r3;
	end process;  
end architecture alu;