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
-------------------------------------------------------------------------
 ----- procedure to do multiplication of two 16-bit inputs
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
------------------------------------------------------------------------- 
	
-------------------------------------------------------------------------  
	---- prodcedure to do  adddition of two 32 bit inputs
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
------------------- 
-------------------------------------------------------------------------
-------------------------------------------------------------------------
	---- prodcedure to do  subtraction of two 32 bit inputs
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
-------------------------------------------------------------------------
 ----- procedure to do long multiplication of two 32-bit inputs
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
------------------------------------------------------------------------- 
-------------------------------------------------------------------------  
	---- prodcedure to do long adddition of two 64 bit inputs
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
-------------------------------------------------------------------------
-------------------------------------------------------------------------
	---- procedure to do  subtraction of two 64 bit inputs
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
---------------------------------------------------------------------------
	procedure load(signal instruc:in std_logic_vector(24 downto 0);
			   	   signal output:out std_logic_vector(127 downto 0)) is	
			   variable position : integer;
	begin
		position := to_integer(unsigned(instruc(23 downto 21)));
		output((position*16)-15 downto (position*16)) <= instruc(20 downto 5);
	end procedure;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--	procedure R3(signal instruc:in std_logic_vector(24 downto 0);) is
--	begin
--		if instruc(25)='0' then
--			load
--		else if instruc(22 downto 20) = '000' then
--
--			signed Integer Multiply-add with saturation
--
--	end procedure;
------------------------------------------------------------------------------
------------------------------------------------------------------------------
	signal Tempout: std_logic_vector(31 downto 0);
	signal Tempout_L: std_logic_vector(63 downto 0);
	signal signOp : std_logic := '1';
	signal notSignOp : std_logic := '0';
	
begin  
	process(insReg)
	begin					--a=32, m=16--
	if(insReg(24 downto 23) = "10") then 
		if insReg(22 downto 20)= "000" then
			
			mult(signOp,inReg3(m-1 downto 0),inReg2(m-1 downto 0),Tempout);
			add(signOp,Tempout,inReg1(a-1 downto 0),outReg(a-1 downto 0));
			
			mult(signOp,inReg3(47 downto a),inReg2(47 downto a),Tempout);
			add(signOp,Tempout,inReg1(64-1 downto a),outReg(64-1 downto a));
			
			mult(signOp,inReg3(79 downto 64),inReg2(79 downto 64),Tempout);
			add(signOp,Tempout,inReg1(95 downto 64),outReg(95 downto 64));
			
			mult(signOp,inReg3(111 downto 96),inReg2(111 downto 96),Tempout);
			add(signOp,Tempout,inReg1(127 downto 96),outReg(127 downto 96));
			
		elsif insReg(22 downto 20) = "001" then
			
			mult(signOp,inReg3(a-1 downto m),inReg2(a-1 downto m),Tempout);
			add(signOp,Tempout,inReg1(a-1 downto 0),outReg(a-1 downto 0));
			
			mult(signOp,inReg3(63 downto 48),inReg2(63 downto 48),Tempout);
			add(signOp,Tempout,inReg1(64-1 downto a),outReg(64-1 downto a));
			
			mult(signOp,inReg3(95 downto 80),inReg2(95 downto 80),Tempout);
			add(signOp,Tempout,inReg1(95 downto 64),outReg(95 downto 64));
			
			mult(signOp,inReg3(127 downto 112),inReg2(127 downto 112),Tempout);
			add(signOp,Tempout,inReg1(127 downto 96),outReg(127 downto 96));
			
		elsif insReg(22 downto 20)="010" then
			
			mult(signOp,inReg3(a-1 downto m),inReg2(a-1 downto m),Tempout);
			sub(signOp,inReg1(a-1 downto 0),Tempout,outReg(a-1 downto 0));
			
			mult(signOp,inReg3(63 downto 48),inReg2(63 downto 48),Tempout);
			sub(signOp,inReg1(64-1 downto a),Tempout,outReg(64-1 downto a));
			
			mult(signOp,inReg3(95 downto 80),inReg2(95 downto 80),Tempout);
			sub(signOp,inReg1(95 downto 64),Tempout,outReg(95 downto 64));
			
			mult(signOp,inReg3(127 downto 112),inReg2(127 downto 112),Tempout);
			sub(signOp,inReg1(127 downto 96),Tempout,outReg(127 downto 96));
			
		elsif insReg(22 downto 20)="011" then
			
			mult(signOp,inReg3(a-1 downto m),inReg2(a-1 downto m),Tempout);
			sub(signOp,inReg1(a-1 downto 0),Tempout,outReg(a-1 downto 0));
			
			mult(signOp,inReg3(63 downto 48),inReg2(63 downto 48),Tempout);
			sub(signOp,inReg1(64-1 downto a),Tempout,outReg(64-1 downto a));
			
			mult(signOp,inReg3(95 downto 80),inReg2(95 downto 80),Tempout);
			sub(signOp,inReg1(95 downto 64),Tempout,outReg(95 downto 64));
			
			mult(signOp,inReg3(127 downto 112),inReg2(127 downto 112),Tempout);
			sub(signOp,inReg1(127 downto 96),Tempout,outReg(127 downto 96));
			
		elsif insReg(22 downto 20)="100" then
			
			mult_long(signOp,inReg3(m_long-1 downto 0),inReg2(m_long-1 downto 0),Tempout_L);
			add_long(signOp,Tempout_L,inReg1(a_long-1 downto 0),outReg(a_long-1 downto 0));
			
			mult_long(signOp,inReg3(95 downto 64),inReg2(95 downto 64),Tempout_L);
			add_long(signOp,Tempout_L,inReg1(127 downto 96),outReg(127 downto 96));
			
			
		elsif insReg(22 downto 20)="101" then
			
			mult_long(signOp,inReg3(a_long-1 downto a),inReg2(a_long-1 downto a),Tempout_L);
			add_long(signOp,Tempout_L,inReg1(a_long-1 downto 0),outReg(a_long-1 downto 0));
			
			mult_long(signOp,inReg3(127 downto 96),inReg2(127 downto 96),Tempout_L);
			add_long(signOp,Tempout_L,inReg1(127 downto 64),outReg(127 downto 64));
			
		elsif insReg(22 downto 20)="110" then
			
			mult_long(signOp,inReg3(m_long-1 downto 0),inReg2(m_long-1 downto 0),Tempout_L);
			sub_long(signOp,inReg1(a_long-1 downto 0),Tempout_L,outReg(a_long-1 downto 0));
			
			mult_long(signOp,inReg3(95 downto 64),inReg2(95 downto 64),Tempout_L);
			sub_long(signOp,inReg1(127 downto 96),Tempout_L,outReg(127 downto 96));
			
		elsif insReg(22 downto 20)="111" then
			mult_long(signOp,inReg3(a_long-1 downto a),inReg2(a_long-1 downto a),Tempout_L);
			sub_long(signOp,inReg1(a_long-1 downto 0),Tempout_L,outReg(a_long-1 downto 0));
			
			mult_long(signOp,inReg3(127 downto 96),inReg2(127 downto 96),Tempout_L);
			sub_long(signOp,inReg1(127 downto 64),Tempout_L,outReg(127 downto 64));
		end if;	
		
		if(insReg(24) = "0") then
				load(instruc,oput);
		end if;
--
--		if(insReg(24 downto 23) = "11") then
--		end if;

-- mult(input1,input2,xsign,output);
-- add(input1,input2,xsign,output);
-- sub(input1,input2,xsign,output);
		end if;
	end process;  
end architecture alu;