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
		outReg: out std_logic_vector(127 downto 0)--:= std_logic_vector(to_unsigned(0,128))	  ---- output register
	);
end aluIO;

architecture alu of aluIO is	 
------------------------------------------------------------------------------ procedure to do multiplication of two 16-bit inputs
 	procedure mult(signal xsign : in std_logic;
 				signal in1,in2 : in std_logic_vector(m-1 downto 0);
				variable oput : out std_logic_vector(m_long-1 downto 0)) is
	begin
		if 	xsign = '1' then	  
			oput := std_logic_vector(resize((signed(in1) * signed(in2)),32)); 
		elsif xsign = '0' then
			oput := std_logic_vector(resize((unsigned(in1) * unsigned(in2)),32));
		end if;
	end procedure;
	
------------------------------------------------------------------------------ procedure to do multiplication of two 32-bit inputs
 	procedure mult_long( signal xsign : in std_logic;
 					  signal in1,in2 : in std_logic_vector(m_long-1 downto 0);
				   	  variable oput : out std_logic_vector(63 downto 0)) is
	begin
		if 	xsign = '1' then 			  --- signed subtraction
			oput := std_logic_vector(resize((signed(in1) * signed(in2)),64)); 
		elsif xsign = '0' then 
			oput := std_logic_vector(resize((unsigned(in1) * unsigned(in2)),64));
		end if;
	end procedure;
 	
----------------------------------------------------------------------------- prodcedure to do adddition of two 32 bit inputs
	procedure add(signal xsign : in std_logic; 
				  variable in1 : in std_logic_vector(a-1 downto 0);
			      signal in2 : in std_logic_vector(a-1 downto 0);
				  variable oput : out std_logic_vector(a-1 downto 0)) is
	begin
		if 	xsign = '1' then	  
			oput := std_logic_vector(resize((signed(in1) + signed(in2)),a)); 
		elsif xsign = '0' then 
			oput := std_logic_vector(resize((unsigned(in1) + unsigned(in2)),a));
		end if;
	end procedure;
	
----------------------------------------------------------------------------- procedure to do addition of two 16 bit inputs
	procedure add_half(signal xsign : in std_logic; 
					   variable in1 : in std_logic_vector(15 downto 0);
					   signal in2 : in std_logic_vector(15 downto 0);
				       variable oput : out std_logic_vector(15 downto 0)) is
	begin
		if 	xsign = '1' then	  
			oput := std_logic_vector(resize((signed(in1) + signed(in2)),16)); 
		elsif xsign = '0' then 
			oput := std_logic_vector(resize((unsigned(in1) + unsigned(in2)),16));
		end if;
	end procedure;
	

----------------------------------------------------------------------------- prodcedure to do adddition of two 64 bit inputs
	procedure add_long( signal xsign : in std_logic;
						variable in1 : in std_logic_vector(a_long-1 downto 0);
						signal in2 : in std_logic_vector(a_long-1 downto 0);
				   		variable oput : out std_logic_vector(a_long-1 downto 0)) is
	begin
		if 	xsign = '1' then 
			oput := std_logic_vector(resize((signed(in1) + signed(in2)),a_long)); 
		elsif xsign = '0' then 
			oput := std_logic_vector(unsigned(in1) + unsigned(in2));
		end if;
	end procedure; 
-----------------------------------------------------------------------------procedure to do subtraction of two 16 bit inputs
    procedure sub_half(signal xsign : in std_logic; 
					   signal in1 : in std_logic_vector(15 downto 0);
					   variable in2 : in std_logic_vector(15 downto 0);
				       variable oput : out std_logic_vector(15 downto 0)) is
	begin
		if 	xsign = '1' then	  
			oput := std_logic_vector(resize((signed(in1) - signed(in2)),16)); 
		elsif xsign = '0' then 
			oput := std_logic_vector(resize((unsigned(in1) - unsigned(in2)),16));
		end if;
	end procedure;
----------------------------------------------------------------------------- prodcedure to do subtraction of two 32 bit inputs
	procedure sub(signal xsign : in std_logic;
				  signal in1 : in std_logic_vector(s-1 downto 0);
				  variable in2 : in std_logic_vector(s-1 downto 0);
				  variable oput : out std_logic_vector(s-1 downto 0)) is
	begin
		if 	xsign = '1' then 			  --- signed subtraction
			oput := std_logic_vector(resize((signed(in1) - signed(in2)),s)); 
		elsif xsign = '0' then 
			oput := std_logic_vector(resize((unsigned(in1) - unsigned(in2)),s));
		end if;
	end procedure;  
	
----------------------------------------------------------------------------- procedure to do subtraction of two 64 bit inputs
	procedure sub_long( signal xsign : in std_logic;
						signal in1 : in std_logic_vector(s_long-1 downto 0);
				   		variable in2 : in std_logic_vector(s_long-1 downto 0);
				   		variable oput : out std_logic_vector(s_long-1 downto 0)) is
	begin 
		if 	xsign = '1' then
			oput := std_logic_vector(resize((signed(in1) - signed(in2)),s_long)); 
		elsif xsign = '0' then 
			oput := std_logic_vector(resize((unsigned(in1) - unsigned(in2)),s_long));
		end if;
	end procedure;
	
---------------------------------------------------------------------------	
 	procedure sat_half(signal input:in std_logic_vector(15 downto 0);
			   	   	   variable output:out std_logic_vector(15 downto 0)) is	
	begin
		if(signed(input) > signed(x"7FFF")) then
			output := x"7FFF";
		elsif (signed(input) < signed(x"8000")) then
			output := x"8000";
		end if;
	end procedure;
	
---------------------------------------------------------------------------
 	procedure sat_int(signal input:in std_logic_vector(31 downto 0);
			   	      variable output:out std_logic_vector(31 downto 0)) is	
	begin
		if(signed(input) > signed(x"7FFFFFFF")) then
			output := x"7FFFFFFF";
		elsif (signed(input) < signed(x"80000000")) then
			output := x"80000000";
		end if;
	end procedure;
	
---------------------------------------------------------------------------
	procedure sat_long(signal input:in std_logic_vector(63 downto 0);
			   	   	   variable output:out std_logic_vector(63 downto 0)) is	
	begin
		if(signed(input) > signed(x"7FFFFFFFFFFFFFFF")) then
			output := x"7FFFFFFFFFFFFFFF";
		elsif (signed(input) < signed(x"8000000000000000")) then
			output := x"8000000000000000";
		end if;
	end procedure;
	
---------------------------------------------------------------------------	load procedure
	procedure load(signal instruc:in std_logic_vector(24 downto 0);
			   	   signal output:out std_logic_vector(127 downto 0)) is	
			   variable position : integer;
	begin
		position := to_integer(unsigned(instruc(23 downto 21)));
		if position = 0 then
			output(15 downto 0) <= instruc(20 downto 5);
		elsif position = 1 then
			output(31 downto 16) <= instruc(20 downto 5);
		elsif position = 2 then
			output(47 downto 32) <= instruc(20 downto 5);
		elsif position = 3 then
			output(63 downto 48) <= instruc(20 downto 5);
		elsif position = 4 then
			output(79 downto 64) <= instruc(20 downto 5);
		elsif position = 5 then
			output(95 downto 80) <= instruc(20 downto 5);
		elsif position = 6 then
			output(111 downto 96) <= instruc(20 downto 5);
		elsif position = 7 then
			output(127 downto 112) <= instruc(20 downto 5);
		end if;
	end procedure;
	
---------------------------------------------------------------------------------
	procedure clzw(signal input:in std_logic_vector(31 downto 0);
			   	   signal output:out std_logic_vector(31 downto 0)) is	
			   variable i : integer := 31;
			   variable counter : integer := 0;
	begin 
		while input(i) = '0' loop
			counter := counter + 1;
			i:= i-1;
			if (i < 0) then 
				i := 0;
			end if;
		end loop;
		output <= std_logic_vector(to_unsigned(counter,32));
	end procedure;

--------------------------------------------------------------------------
	procedure maxws(signal input1,input2:in std_logic_vector(31 downto 0);
					signal output:out std_logic_vector(31 downto 0)) is
	begin 
		if( signed(input1) > signed(input2)) then
			output <= input1;
		elsif (signed(input1) < signed(input2)) then
			output <= input2;
		elsif (signed(input1) = signed(input2)) then
			output <= input1;
		end if;
	end procedure;

--------------------------------------------------------------------------
	procedure minws(signal input1,input2:in std_logic_vector(31 downto 0);
					signal output:out std_logic_vector(31 downto 0)) is
	begin 
		if(signed(input1) > signed(input2)) then
			output <= input2;
		elsif (signed(input1) < signed(input2)) then
			output <= input1;
		elsif (signed(input1) = signed(input2)) then
			output <= input1;
		end if;
	end procedure; 
	
------------------------------------------------------------------------------
--MLHCU: multiply low by constant unsigned: the 16 rightmost bits of each of the four 32-bit slots in register rs1 are multiplied 
--by a 5-bit value in the rs2 field of the instruction, treating both operands as unsigned. The four 32-bit products are placed into the 
--corresponding slots of register rd . (Comments: 4 separate 32-bit values in each 128-bit register)
  procedure MLHCU(signal xsign : in std_logic;
  				  signal in1 : in std_logic_vector(m-1 downto 0);
  			      signal in2 : in std_logic_vector(4 downto 0);
				  variable oput : out std_logic_vector(m_long-1 downto 0)) is
	begin
		if 	xsign = '1' then	  
			oput := std_logic_vector(resize((signed(in1) * signed(in2)),m_long)); 
		else 
			oput := std_logic_vector(resize((unsigned(in1) * unsigned(in2)),m_long));
		end if;
	end procedure;

------------------------------------------------------------------------------
--PCNTW: count ones in words: the number of ones in each of the 4 word slots in register rs1 is computed. 
--If the word slot in register rs1 is zero, the result is also 0. 
--The results are placed into 4 corresponding slots in register rd . (Comments: 4 separate word values in each 128-bit register)
   procedure PCNTW(signal input:in std_logic_vector(31 downto 0);
			   	   signal output:out std_logic_vector(31 downto 0)) is	
			   variable i : integer := 31;
			   variable counter : integer := 0;
	begin 
		for i in 31 downto 0 loop  
			if(input(i) = '1') then
				counter := counter + 1;
			end if;
		end loop;
		output <= std_logic_vector(to_unsigned(counter,32));
	end procedure;

------------------------------------------------------------------------------
	procedure ROTW(signal in1,in2:in std_logic_vector(31 downto 0);
				   variable output:out std_logic_vector(31 downto 0)) is 
		variable rotate : integer;
		variable finalPos : std_logic_vector(31 downto 0);
	begin
		rotate := to_integer(unsigned(in2(4 downto 0)));
		finalPos := in1(31 downto 0);
		for i in 1 to rotate loop
				output := finalPos(0) & finalPos(31 downto 1);	
		end loop;
	end procedure;
	
------------------------------------------------------------------------------
	signal tempOut_half : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(0,16));
	signal Tempout,t32: std_logic_vector(31 downto 0);--:= std_logic_vector(to_unsigned(0,32));
	signal Tempout_L,t64: std_logic_vector(63 downto 0); --:= std_logic_vector(to_unsigned(0,64));
	signal tempFull : std_logic_vector(127 downto 0):= std_logic_vector(to_unsigned(0,128));
	signal signOp : std_logic := '1';
	signal noSignOp : std_logic := '0';
begin 
	process(insReg)
	variable t_half,oT_half : std_logic_vector(15 downto 0);
	variable t,oT : std_logic_vector(31 downto 0);
	variable t_long,oT_long : std_logic_vector(63 downto 0);
	
	
	variable oT_full : std_logic_vector(127 downto 0);
	begin		
		load:if(insReg(24) = '0') then --check insReg is a load instruction				   			
			load(insReg,outReg); 
		end if load;
		--a=32, m=16--
		r4:if(insReg(24 downto 23) = "10") then --check if inReg is a r4 instruction 
			if insReg(22 downto 20)= "000" then	 --signed integer multiply-add low with saturation
				mult(signOp,inReg3(15 downto 0),inReg2(15 downto 0),t); 
				t32 <= t;
				add(signOp,t,inReg1(a-1 downto 0),oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(31 downto 0) <= oT;	 
				
				mult(signOp,inReg3(47 downto 32),inReg2(47 downto 32),t); 
				t32 <= t;
				add(signOp,t,inReg1(63 downto 32),oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(63 downto 32) <= oT;
				
				mult(signOp,inReg3(79 downto 64),inReg2(79 downto 64),t); 
				t32 <= t;
				add(signOp,t,inReg1(95 downto 64),oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(95 downto 64) <= oT;
				
				mult(signOp,inReg3(111 downto 96),inReg2(111 downto 96),t); 
				t32 <= t;
				add(signOp,t,inReg1(127 downto 96),oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(127 downto 96) <= oT;
				
			elsif insReg(22 downto 20) = "001" then--signed integer multiply-add high with saturation
				mult(signOp,inReg3(a-1 downto m),inReg2(a-1 downto m),t); 
				t32 <= t;
				add(signOp,t,inReg1(a-1 downto 0),oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(31 downto 0) <= oT;	 
				
				mult(signOp,inReg3(63 downto 48),inReg2(63 downto 48),t); 
				t32 <= t;
				add(signOp,t,inReg1(63 downto 32),oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(63 downto 32) <= oT;
				
				mult(signOp,inReg3(95 downto 80),inReg2(95 downto 80),t); 
				t32 <= t;
				add(signOp,t,inReg1(95 downto 64),oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(95 downto 64) <= oT;
				
				mult(signOp,inReg3(127 downto 96),inReg2(127 downto 96),t); 
				t32 <= t;
				add(signOp,t,inReg1(127 downto 96),oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(127 downto 96) <= oT;
				
			elsif insReg(22 downto 20)="010" then--signed integer multiply-subtract low with saturation
				mult(signOp,inReg3(15 downto 0),inReg2(15 downto 0),t); 
				t32 <= t;
				sub(signOp,inReg1(a-1 downto 0),t,oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(31 downto 0) <= oT;	 
				
				mult(signOp,inReg3(47 downto 32),inReg2(47 downto 32),t); 
				t32 <= t;
				sub(signOp,inReg1(63 downto 32),t,oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(63 downto 32) <= oT;
				
				mult(signOp,inReg3(79 downto 64),inReg2(79 downto 64),t); 
				t32 <= t;
				sub(signOp,inReg1(95 downto 64),t,oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(95 downto 64) <= oT;
				
				mult(signOp,inReg3(111 downto 96),inReg2(111 downto 96),t); 
				t32 <= t;
				sub(signOp,inReg1(127 downto 96),t,oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(127 downto 96) <= oT; 
				
			elsif insReg(22 downto 20)="011" then --signed integer multiply-subtract high with saturation
				
				mult(signOp,inReg3(a-1 downto m),inReg2(a-1 downto m),t); 
				t32 <= t;
				sub(signOp,inReg1(a-1 downto 0),t,oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(31 downto 0) <= oT;	 
				
				mult(signOp,inReg3(63 downto 48),inReg2(63 downto 48),t); 
				t32 <= t;
				sub(signOp,inReg1(63 downto 32),t,oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(63 downto 32) <= oT;
				
				mult(signOp,inReg3(95 downto 80),inReg2(95 downto 80),t); 
				t32 <= t;
				sub(signOp,inReg1(95 downto 64),t,oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(95 downto 64) <= oT;
				
				mult(signOp,inReg3(127 downto 96),inReg2(127 downto 96),t); 
				t32 <= t;
				sub(signOp,inReg1(127 downto 96),t,oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(127 downto 96) <= oT;
				
			elsif insReg(22 downto 20)="100" then  --signed long multiply-add low with saturation
				mult_long(signOp,inReg3(31 downto 0),inReg2(31 downto 0),t_long); 
				t64 <= t_long;
				add_long(signOp,t_long,inReg1(63 downto 0),oT_long);
				Tempout_L <= oT_long;	
				sat_long(Tempout_L,oT_long);
				outreg(63 downto 0) <= oT_long;	 
				
				mult_long(signOp,inReg3(95 downto 64),inReg2(95 downto 64),t_long); 
				t64 <= t_long;
				add_long(signOp,t_long,inReg1(127 downto 64),oT_long);
				Tempout_L <= oT_long;	
				sat_long(Tempout_L,oT_long);
				outreg(127 downto 64) <= oT_long;
					
			elsif insReg(22 downto 20)="101" then  --signed long multiply-add high with saturation
				mult_long(signOp,inReg3(63 downto 31),inReg2(63 downto 31),t_long); 
				t64 <= t_long;
				sub_long(signOp,inReg1(63 downto 0),t_long,oT_long);
				Tempout_L <= oT_long;	
				sat_long(Tempout_L,oT_long);
				outreg(63 downto 0) <= oT_long;	 
				
				mult_long(signOp,inReg3(127 downto 96),inReg2(127 downto 96),t_long); 
				t64 <= t_long;
				sub_long(signOp,inReg1(127 downto 64),t_long,oT_long);
				Tempout_L <= oT_long;	
				sat_long(Tempout_L,oT_long);
				outreg(127 downto 64) <= oT_long;
				
			elsif insReg(22 downto 20)="110" then --signed long multiply-subtract low with saturation
				mult_long(signOp,inReg3(31 downto 0),inReg2(31 downto 0),t_long); 
				t64 <= t_long;
				sub_long(signOp,inReg1(63 downto 0),t_long,oT_long);
				Tempout_L <= oT_long;	
				sat_long(Tempout_L,oT_long);
				outreg(63 downto 0) <= oT_long;	 
				
				mult_long(signOp,inReg3(a-1 downto m),inReg2(a-1 downto m),t_long); 
				t64 <= t_long;
				sub_long(signOp,inReg1(127 downto 64),t_long,oT_long);
				Tempout_L <= oT_long;	
				sat_long(Tempout_L,oT_long);
				outreg(127 downto 64) <= oT_long;
				
			elsif insReg(22 downto 20)="111" then --signed long multiply-subtract high with saturation
				mult_long(signOp,inReg3(63 downto 31),inReg2(63 downto 31),t_long); 
				t64 <= t_long;
				sub_long(signOp,inReg1(63 downto 0),t_long,oT_long);
				Tempout_L <= oT_long;	
				sat_long(Tempout_L,oT_long);
				outreg(63 downto 0) <= oT_long;	 
				
				mult_long(signOp,inReg3(127 downto 96),inReg2(127 downto 96),t_long); 
				t64 <= t_long;
				sub_long(signOp,inReg1(127 downto 64),t_long,oT_long);
				Tempout_L <= oT_long;	
				sat_long(Tempout_L,oT_long);
				outreg(127 downto 64) <= oT_long; 
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
				t := inReg1(31 downto 0);
				add(noSignOp,t,inReg2(31 downto 0),oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(31 downto 0) <= oT;
				
				t := inReg1(63 downto 32);
				add(noSignOp,t,inReg2(63 downto 32),oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(63 downto 32) <= oT;
				
				t := inReg1(95 downto 64);
				add(noSignOp,t,inReg2(95 downto 64),oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(95 downto 64) <= oT;
				
				t := inReg1(127 downto 96);
				add(noSignOp,t,inReg2(127 downto 96),oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(127 downto 96) <= oT;

			elsif (insReg(18 downto 15) = "0011") then	---AHU operation
				t_half := inReg1(15 downto 0);
				add_half(noSignOp,t_half,inReg2(15 downto 0),oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(15 downto 0) <= oT_half;
				
				t_half := inReg1(31 downto 16);
				add_half(noSignOp,t_half,inReg2(31 downto 16),oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(31 downto 16) <= oT_half;
				
				t_half := inReg1(47 downto 32);
				add_half(noSignOp,t_half,inReg2(47 downto 32),oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(47 downto 32) <= oT_half;
				
				t_half := inReg1(63 downto 48);
				add_half(noSignOp,t_half,inReg2(63 downto 48),oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(63 downto 48) <= oT_half;
				
				t_half := inReg1(79 downto 64);
				add_half(noSignOp,t_half,inReg2(79 downto 64),oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(79 downto 64) <= oT_half; 
				
				t_half := inReg1(95 downto 80);
				add_half(noSignOp,t_half,inReg2(95 downto 80),oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(95 downto 80) <= oT_half;
				
				t_half := inReg1(111 downto 96);
				add_half(noSignOp,t_half,inReg2(111 downto 96),oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(111 downto 96) <= oT_half;
				
				t_half := inReg1(127 downto 112);
				add_half(noSignOp,t_half,inReg2(127 downto 112),oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(127 downto 112) <= oT_half; 

			elsif (insReg(18 downto 15) = "0100") then ---AHS operation
				t_half := inReg1(15 downto 0);
				add_half(signOp,t_half,inReg2(15 downto 0),oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(15 downto 0) <= oT_half;
				
				t_half := inReg1(31 downto 16);
				add_half(signOp,t_half,inReg2(31 downto 16),oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(31 downto 16) <= oT_half;
				
				t_half := inReg1(47 downto 32);
				add_half(signOp,t_half,inReg2(47 downto 32),oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(47 downto 32) <= oT_half;
				
				t_half := inReg1(63 downto 48);
				add_half(signOp,t_half,inReg2(63 downto 48),oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(63 downto 48) <= oT_half;
				
				t_half := inReg1(79 downto 64);
				add_half(signOp,t_half,inReg2(79 downto 64),oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(79 downto 64) <= oT_half; 
				
				t_half := inReg1(95 downto 80);
				add_half(signOp,t_half,inReg2(95 downto 80),oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(95 downto 80) <= oT_half;
				
				t_half := inReg1(111 downto 96);
				add_half(signOp,t_half,inReg2(111 downto 96),oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(111 downto 96) <= oT_half;
				
				t_half := inReg1(127 downto 112);
				add_half(signOp,t_half,inReg2(127 downto 112),oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(127 downto 112) <= oT_half;

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
				 
			elsif (insReg(18 downto 15) = "1001") then 		--MLHU Operation 
				mult(noSignOp,inReg1(15 downto 0),inReg2(15 downto 0),oT); 
				outreg(31 downto 0) <= oT;
				
				mult(noSignOp,inReg1(47 downto 32),inReg2(47 downto 32),oT); 
				outreg(63 downto 32) <= oT;	 
				
				mult(noSignOp,inReg1(79 downto 64),inReg2(79 downto 64),oT); 
				outreg(95 downto 64) <= oT;	
				
				mult(noSignOp,inReg1(111 downto 96),inReg2(111 downto 96),oT); 
				outreg(127 downto 96) <= oT; 
				 
	        elsif (insReg(18 downto 15) = "1010") then	--MLHCU operation
				MLHCU(noSignOp,inReg1(m-1 downto 0),insReg(14 downto 10),oT); 
				outreg(31 downto 0) <= oT;
				MLHCU(noSignOp,inReg1(47 downto a),insReg(14 downto 10),oT);
				outreg(63 downto 32) <= oT;
				MLHCU(noSignOp,inReg1(79 downto 64),insReg(14 downto 10),oT);
				outreg(95 downto 64) <= oT;
				MLHCU(noSignOp,inReg1(111 downto 96),insReg(14 downto 10),oT);
				outreg(127 downto 96) <= oT;	 
				 
			elsif (insReg(18 downto 15) = "1011") then	 --OR operation
				outReg <= inReg1 or inReg2;	   
				 
			elsif (insReg(18 downto 15) = "1100") then --- PCNTW
				PCNTW(inReg1(31 downto 0),outReg(31 downto 0));
				PCNTW(inReg1(63 downto 32),outReg(63 downto 32));
				PCNTW(inReg1(95 downto 64),outReg(95 downto 64));
				PCNTW(inReg1(127 downto 96),outReg(127 downto 96));
				 
			elsif (insReg(18 downto 15) = "1101") then	--ROTW
				ROTW(inReg1(31 downto 0),inReg2(31 downto 0),oT);
				outReg(31 downto 0) <= oT; 
				ROTW(inReg1(63 downto 32),inReg2(63 downto 32),oT);
				outReg(63 downto 32) <= oT;
				ROTW(inReg1(95 downto 64),inReg2(95 downto 64),oT);
				outReg(95 downto 64) <= oT;
				ROTW(inReg1(127 downto 96),inReg2(127 downto 96),oT);
				outReg(127 downto 96) <= oT; 
				 
				
--				rotate := to_integer(unsigned(inReg2(36 downto 32)));
--				rT := inReg1(63 downto 32);
--				for i in 1 to rotate loop
--					rT := rT(0) & rT(31 downto 1);	
--				end loop;
--				outReg(63 downto 32) <= rt;
--				
--				rotate := to_integer(unsigned(inReg2(68 downto 64)));
--				rT := inReg1(95 downto 64);
--				for i in 1 to rotate loop
--					rT := rT(0) & rT(31 downto 1);	
--				end loop;
--				outReg(95 downto 64) <= rt;
--				
--				rotate := to_integer(unsigned(inReg2(100 downto 96)));
--				rT := inReg1(127 downto 96);
--				for i in 1 to rotate loop
--					rT := rT(0) & rT(31 downto 1);	
--				end loop;
--				outReg(127 downto 96) <= rt;
				
			elsif (insReg(18 downto 15) = "1110") then	--SFWU
				t := inReg1(31 downto 0);
				sub(noSignOp,inReg2(31 downto 0),t,oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(31 downto 0) <= oT;
				
				t := inReg1(63 downto 32);
				sub(noSignOp,inReg2(63 downto 32),t,oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(63 downto 32) <= oT;
				
				t := inReg1(95 downto 64);
				sub(noSignOp,inReg2(95 downto 64),t,oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(95 downto 64) <= oT;
				
				t := inReg1(127 downto 96);
				sub(noSignOp,inReg2(127 downto 96),t,oT);
				Tempout <= oT;	
				sat_int(Tempout,oT);
				outreg(127 downto 96) <= oT;
				 
		
			elsif (insReg(18 downto 15) = "1111") then  --SFHS
				t_half := inReg1(15 downto 0);
				sub_half(signOp,inReg2(15 downto 0),t_half,oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(15 downto 0) <= oT_half;
				
				t_half := inReg1(31 downto 16);
				sub_half(signOp,inReg2(31 downto 16),t_half,oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(31 downto 16) <= oT_half;
				
				t_half := inReg1(47 downto 32);
				sub_half(signOp,inReg2(47 downto 32),t_half,oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(47 downto 32) <= oT_half;
				
				t_half := inReg1(63 downto 48);
				sub_half(signOp,inReg2(63 downto 48),t_half,oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(63 downto 48) <= oT_half;
				
				t_half := inReg1(79 downto 64);
				sub_half(signOp,inReg2(79 downto 64),t_half,oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(79 downto 64) <= oT_half; 
				
				t_half := inReg1(95 downto 80);
				sub_half(signOp,inReg2(95 downto 80),t_half,oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(95 downto 80) <= oT_half;
				
				t_half := inReg1(111 downto 96);
				sub_half(signOp,inReg2(111 downto 96),t_half,oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				outreg(111 downto 96) <= oT_half;
				
				t_half := inReg1(127 downto 112);
				sub_half(signOp,inReg2(127 downto 112),t_half,oT_half);
				tempout_half <= oT_half;	
				sat_half(tempout_half,oT_half);
				 
		  	end if ;
		end if r3;
	end process;
end architecture alu;  
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
library ieee;								  	
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.all; 

entity id_ex is
	port( 
		clk : in std_logic;
		dataIn1,dataIn2,dataIn3: in std_logic_vector(127 downto 0); ---- input values from 2nd stage output
		rdNumIn: in std_logic_vector(4 downto 0);
		dataOut1,dataOut2,dataOut3: out std_logic_vector(127 downto 0); ---- input values from 2nd stage output
		rdNumOut: out std_logic_vector(4 downto 0) ---- output rd number
	);
end id_ex; 

architecture idEX of id_ex is
	signal temp1,temp2,temp3:std_logic_vector(127 downto 0); 
	signal rdTemp :std_logic_vector (4 downto 0);
begin
	 process(clk)
        begin
            if rising_edge(clk) then 
               dataOut1 <= dataIn1;--temp1;
			   dataOut2 <= dataIn2;--temp2;
			   dataOut3 <= dataIn3;--temp3;
--			   temp1 <= dataIn1;
--			   temp2 <= dataIn2;
--			   temp3 <= dataIn3;
			   rdNumOut <= rdNumIn;--rdTemp;
--			   rdTemp <= rdNumIn;
            end if;
     end process;
end architecture idEX;
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
library ieee;								  	
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.all;

entity fowardMux is
	port( 
		selSignal : in std_logic_vector(2 downto 0); --- Mux control signal
		dataIn1,dataIn2,dataIn3,dataIn4: in std_logic_vector(127 downto 0); ---- input values from register file
		outReg1,outReg2,outReg3: out std_logic_vector(127 downto 0) ---- output registers
	);
end fowardMux;	 

architecture fmux of fowardMux is
begin
	outReg1 <= dataIn4 when selSignal(2) = '1' else dataIn1;
	outReg2 <= dataIn4 when selSignal(1) = '1' else dataIn2;
	outReg3 <= dataIn4 when selSignal(0) = '1' else dataIn3;
end architecture fmux;
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------ 
library ieee;								  	
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.all;  

entity dataFowarding is
	port(  
		dataIn: in std_logic_vector(127 downto 0); ---- input values from 3rd stage output
		regNumIn: in std_logic_vector(4 downto 0); ---  input from the alu output
		regNumOut: out std_logic_vector(4 downto 0); --- register number used to compare with foward mux inputs
		outResult: out std_logic_vector(127 downto 0) ---- output register
	);
end dataFowarding;	 

architecture fowarding of dataFowarding is
begin 
	outResult <= dataIn;
	regNumOut <= regNumIn;
end architecture fowarding;
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
library ieee;								  	
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.all; 

entity ex_wb is
	port( 
		clk : in std_logic;
		regWrite_in: in std_logic_vector(4 downto 0);	---- input register number
		dataIn: in std_logic_vector(127 downto 0); ---- input values from 3rd stage output
		regWrite_out: out std_logic_vector(4 downto 0);	---- output register number
		outResult: out std_logic_vector(127 downto 0) ---- output register value
	);
end ex_wb; 

architecture exWB of ex_wb is 
	signal temp :std_logic_vector(127 downto 0); 
	signal rdTemp :std_logic_vector (4 downto 0);
begin
	
	 process(clk)
        begin
            if rising_edge(clk) then 
               outResult <= dataIn;
			   regWrite_out <= regWrite_in;
--			   temp <= dataIn;
--			   rdTemp <= regWrite_in;
--	 			
            end if;
     end process;
end architecture exWB;
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------	
library ieee;								  	
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.all;  	 

entity writeBack is
	port(  
		aluOut: in std_logic_vector(127 downto 0); ---- input values from 3rd stage output
		outReg : out std_logic_vector(127 downto 0) ---- output register
	);
end writeBack;

architecture wb of writeBack is
begin
	outReg <= aluOut;
end architecture wb;
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myPackage.all;
use work.all;  

entity writeResult is 
	port(
		clk : in std_logic;
		stages : in instructions_at_stages
	);
end writeResult; 		 

architecture write_toResultFile of writeResult is
	file resultFile : text;
begin
	process(clk)
		variable write_to_result : line;
		variable cycleCounter: integer := 0;
	begin
		file_open(resultFile, "result.txt",  write_mode);
		if(rising_edge(clk)) then
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
			--if cycleCounter = 63 then
				
			end if;
--		end if;
		file_close(resultFile);
	end process;
end architecture write_toResultFile;	
----------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------- 
library ieee;							  	
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myPackage.all;
use work.all;

entity multimedia_pipeline is
	port(clk: in std_logic;
	instructs : in instruc_table;
	register_tble :inout reg_table
	);
end multimedia_pipeline;

architecture structural of multimedia_pipeline is
	type pipeline_ctrl is record
         inst : std_logic_vector(24 downto 0);
        --fMux_cntrl : std_logic_vector(2 downto 0);
		 writeReg : std_logic;
		 reg1Num,reg2Num,reg3Num,rdNum: std_logic_vector(4 downto 0);
    end record; 

    type control_arr is array (1 to 4) of pipeline_ctrl;
	signal control_table: control_arr;
    signal inst_if,inst_id : std_logic_vector(24 downto 0);

    signal outWB,outEXWB,outALU,outDF: std_logic_vector (127 downto 0);
	signal wrToRg,tempWRG : std_logic;
    signal rs1,rs2,rs3,rd,muxRS1,muxRS2,muxRS3	: std_logic_vector (127 downto 0);
	signal rs1ID,rs2ID,rs3ID: std_logic_vector (127 downto 0);
    signal rs1Num,rs2Num,rs3Num : std_logic_vector (4 downto 0);
    signal rdNumIn,rdNum,rdNum_DFOut,rdNum_RFOut : std_logic_vector (4 downto 0); 
    signal fowardingCntrl : std_logic_vector(0 to 2);
	signal pc : integer := 0;
	signal writeInstToFile : instructions_at_stages;
	--signal rdNum_in_rF : integer;
	file resultFile : text;
begin 	  
	
	instfetch: entity InstrctionBuffer port map(clk => clk,inst =>instructs,PC => pc,outp => inst_if);
	--stages(1) <= inst_if;	
	if_id: entity IFStage port map(clk=>clk,Instruction=> inst_if,OutIns=>inst_id); 
	control_table(1).inst <= inst_if;
	control_table(2).inst <= inst_id;
	
	
	id: entity Register_File port map (clk => clk,sele => inst_id,registers_in => register_tble,rdNum => control_table(4).rdNUm ,write_to_reg => control_table(4).writeReg,
	writtenReg => outWB,r1Num => control_table(2).reg1Num,r2Num => control_table(2).reg2Num,r3Num => control_table(2).reg3Num,rdNumOut => control_table(2).rdNum,
	f_write_to_reg => control_table(2).writeReg ,out1 => rs1 ,out2 => rs2 ,out3 => rs3);
	
	id_ex: entity id_ex port map(clk=>clk,dataIn1 => rs1,dataIn2 => rs2,dataIn3 => rs3,rdNumIn => control_table(3).rdNum,
		                         dataOut1 => rs1ID , dataOut2 => rs2ID,dataOut3 => rs3ID,rdNumOut => rdNum); 
	
	fowardingCntrl(2) <= '1' when control_table(3).reg1Num = control_table(4).rdNUm else '0';
	fowardingCntrl(1) <= '1' when control_table(3).reg2Num = control_table(4).rdNUm else '0';
	fowardingCntrl(0) <= '1' when control_table(3).reg3Num = control_table(4).rdNUm else '0';
	fmux: entity fowardMux port map(selSignal=>fowardingCntrl,dataIn1=>rs1ID,dataIn2=>rs2ID,dataIn3=>rs3ID,dataIn4=>outDF,outReg1=>muxRS1,outReg2=>muxRS2,outReg3=>muxRS3);		  
		
	alu :entity aluIO port map(inReg1=>muxRS1,inReg2=>muxRS2,inReg3=>muxRS3,insReg=>control_table(3).inst, outReg=>outALU);
	--wrToRg <= tempWRG;
		
	ex_wb: entity ex_wb port map(clk=>clk,regWrite_in=>rdNum,dataIn=>outALU, regWrite_out =>rdNum,outResult=>outEXWB);	
		
	df: entity dataFowarding port map(dataIn=>outEXWB,regNumIn=>rdNum,regNumOut=>rdNum_DFOut,outResult=>outDF);	 
		
	wb : entity writeBack port map(aluOut=>outEXWB,outReg=>outWB);
	
	--wr:  entity writeResult port map(clk=>clk,stages=>writeInstToFile);
		
--	process
--		variable write_to_result : line;
--		variable cycleCounter: integer := 0;
--	begin
--		--if(rising_edge(clk)) then
--			file_open(resultFile, "die.txt",  write_mode);
--			write(write_to_result, string'("Cycle "));
--			write(write_to_result, cycleCounter); 
--			write(write_to_result, string'(":")); 
--			writeline(resultFile, write_to_result);
--			
--			write(write_to_result, string'("Instruction at Stage 1: "));
--			write(write_to_result, writeInstToFile(1));
--			write(write_to_result, string'(" | Instruction at Stage 2: "));
--			write(write_to_result, writeInstToFile(2));
--			write(write_to_result, string'(" | Instruction at Stage 3: "));
--			write(write_to_result, writeInstToFile(3));
--			write(write_to_result, string'(" | Instruction at Stage 4: "));
--			write(write_to_result, writeInstToFile(4));
--	        writeline(resultFile, write_to_result);
--			
--			cycleCounter := cycleCounter + 1;
--			--if cycleCounter = 63 then
--				
--			--end if;
----		end if;
--		file_close(resultFile);
--	    wait;
--	end process;
	
	process(clk)
		variable pcInc:integer := 0;
	begin
		if (rising_edge(clk)) then
			pc <= pcInc;
			control_table(4) <= control_table(3); 
			control_table(3) <= control_table(2);
--			control_table(2) <= control_table(1);
--			writeInstToFile(4) <= writeInstToFile(3);
--			writeInstToFile(3) <= writeInstToFile(2);
--			writeInstToFile(2) <= writeInstToFile(1);
			--control_table(1).inst <= instructs(pcInc);
			--writeInstToFile(1) <= instructs(pcInc);
			pcInc := pcInc + 1;
			
			--control_table(1).writeReg <= control_table(4).writeReg;
		end if;
	end process; 
	
end architecture structural;
-----------------------------------------------------------------------------------------------------