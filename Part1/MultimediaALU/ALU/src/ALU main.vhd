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
	generic (m : integer := 16);
	generic(a,m_long,s:integer :=32);
	generic(a_long,s_long:integer :=64);
	port(  
	inReg1, inReg2, inReg3: in std_logic_vector(127 downto 0);	---- input registers
	insReg: in std_logic_vector(24 downto 0); ---- instruction input
	outReg: out std_logic_vector(127 downto 0)	  ---- output register
	);
end aluIO;

architecture alu of aluIO is	 
-------------------------------------------------------------------------
 ----- procedure to do multiplication of two n-bit inputs
	procedure mult(signal in1,in2 : in std_logic_vector(m-1 downto 0);
				   signal oput : out std_logic_vector(m-1 downto 0)) is
	begin
		if 
			oput <= std_logic_vector(resize((signed(in1) * signed(in2)),m)); 
		end if;
	end procedure;	 		
------------------------------------------------------------------------- 
	
-------------------------------------------------------------------------  
	---- prodcedure to do  adddition of two n bit inputs
	procedure add(signal in1,in2 : in std_logic_vector(a-1 downto 0);
				   signal oput : out std_logic_vector(a-1 downto 0)) is
	begin
		if
			oput <= std_logic_vector(resize((signed(in1) + signed(in2)),a)); 
		end if;
	end procedure; 
-------------------------------------------------------------------------
-------------------------------------------------------------------------
	---- prodcedure to do  subtraction of two n bit inputs
	procedure sub(signal in1,in2 : in std_logic_vector(s-1 downto 0);
				   signal oput : out std_logic_vector(s-1 downto 0)) is
	begin
		if 			  --- signed subtraction
			oput <= std_logic_vector(resize((signed(in1) - signed(in2)),s)); 
		end if;
	end procedure;
-------------------------------------------------------------------------
 ----- procedure to do long multiplication of two 32-bit inputs
	procedure mult_long(signal in1,in2 : in std_logic_vector(m_long-1 downto 0);
				   signal oput : out std_logic_vector(m_long-1 downto 0)) is
	begin
		if 
			oput <= std_logic_vector(resize((signed(in1) * signed(in2)),m_long)); 
		end if;
	end procedure;
------------------------------------------------------------------------- 
-------------------------------------------------------------------------  
	---- prodcedure to do long adddition of two n bit inputs
	procedure add(signal in1,in2 : in std_logic_vector(a_long-1 downto 0);
				   signal oput : out std_logic_vector(a_long-1 downto 0)) is
	begin
		if
			oput <= std_logic_vector(resize((signed(in1) + signed(in2)),64)); 
		end if;
	end procedure;
-------------------------------------------------------------------------
-------------------------------------------------------------------------
	---- prodcedure to do  subtraction of two n bit inputs
	procedure sub(signal in1,in2 : in std_logic_vector(s_long-1 downto 0);
				   signal oput : out std_logic_vector(s_long-1 downto 0)) is
	begin
		if 			  --- signed subtraction
			oput <= std_logic_vector(resize((signed(in1) - signed(in2)),s_long)); 
		end if;
	end procedure;
---------------------------------------------------------------------------
---------------------------------------------------------------------------
	procedure Load(signal instruc:in std_logic_vector(24 downto 0);) is
	begin
		if instruc(25)='0' then
			load
		else if instruc(22 downto 20) = '000' then

			signed Integer Multiply-add with saturation

	end procedure;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
	procedure R3(signal instruc:in std_logic_vector(24 downto 0);) is
	begin
		if instruc(25)='0' then
			load
		else if instruc(22 downto 20) = '000' then

			signed Integer Multiply-add with saturation

	end procedure;
------------------------------------------------------------------------------
------------------------------------------------------------------------------
begin  
	signal Tempout:out std_logic_vector(31 downto 0);
	signal Tempout_L:out std_logic_vector(63 downto 0);
	process(input1,input2)
	begin					--a=32, m=16--
	if rising_edge(clk) then
		if insReg(22 down to 20)='000' then
			
			mult(inReg3(m-1 downto 0),inReg2(m-1 downto 0),Tempout);
			add(Tempout,inReg1(a-1 downto 0),outReg(a-1 downto 0));
			
			mult(inReg3(47 downto a),inReg2(47 downto a),Tempout);
			add(Tempout,inReg1(64-1 downto a),outReg(64-1 downto a));
			
			mult(inReg3(79 downto 64),inReg2(79 downto 64),Tempout);
			add(Tempout,inReg1(95 downto 64),outReg(95 downto 64));
			
			mult(inReg3(111 downto 96),inReg2(111 downto 96),Tempout);
			add(Tempout,inReg1(127 downto 96),outReg(127 downto 96));
			
		elsif insReg(22 down to 20)='001' then
			
			mult(inReg3(a-1 downto m),inReg2(a-1 downto m),Tempout);
			add(Tempout,inReg1(a-1 downto 0),outReg(a-1 downto 0));
			
			mult(inReg3(63 downto 48),inReg2(63 downto 48),Tempout);
			add(Tempout,inReg1(64-1 downto a),outReg(64-1 downto a));
			
			mult(inReg3(95 downto 80),inReg2(95 downto 80),Tempout);
			add(Tempout,inReg1(95 downto 64),outReg(95 downto 64));
			
			mult(inReg3(127 downto 112),inReg2(127 downto 112),Tempout);
			add(Tempout,inReg1(127 downto 96),outReg(127 downto 96));
			
		elsif insReg(22 down to 20)='010' then
			
			mult(inReg3(a-1 downto m),inReg2(a-1 downto m),Tempout);
			sub(inReg1(a-1 downto 0),Tempout,outReg(a-1 downto 0));
			
			mult(inReg3(63 downto 48),inReg2(63 downto 48),Tempout);
			sub(inReg1(64-1 downto a),Tempout,outReg(64-1 downto a));
			
			mult(inReg3(95 downto 80),inReg2(95 downto 80),Tempout);
			sub(inReg1(95 downto 64),Tempout,outReg(95 downto 64));
			
			mult(inReg3(127 downto 112),inReg2(127 downto 112),Tempout);
			sub(inReg1(127 downto 96),Tempout,outReg(127 downto 96));
			
		elsif insReg(22 down to 20)='011' then
			
			mult(inReg3(a-1 downto m),inReg2(a-1 downto m),Tempout);
			sub(inReg1(a-1 downto 0),Tempout,outReg(a-1 downto 0));
			
			mult(inReg3(63 downto 48),inReg2(63 downto 48),Tempout);
			sub(inReg1(64-1 downto a),Tempout,outReg(64-1 downto a));
			
			mult(inReg3(95 downto 80),inReg2(95 downto 80),Tempout);
			sub(inReg1(95 downto 64),Tempout,outReg(95 downto 64));
			
			mult(inReg3(127 downto 112),inReg2(127 downto 112),Tempout);
			sub(inReg1(127 downto 96),Tempout,outReg(127 downto 96));
			
		elsif insReg(22 down to 20)='100' then
			
			mult_long(inReg3(m_long-1 downto 0),inReg2(m_long-1 downto 0),Tempout_L);
			add_long(Tempout_L,inReg1(a_long-1 downto 0),outReg(a_long-1 downto 0));
			
			mult_long(inReg3(95 downto 64),inReg2(95 downto 64),Tempout_L);
			add_long(Tempout_L,inReg1(127 downto 96),outReg(127 downto 96));
			
			
		elsif insReg(22 down to 20)='101' then
			
			mult_long(inReg3(a_long-1 downto a),inReg2(a_long-1 downto a),Tempout_L);
			add_long(Tempout_L,inReg1(a_long-1 downto 0),outReg(a_long-1 downto 0));
			
			mult_long(inReg3(127 downto 96),inReg2(127 downto 96),Tempout_L);
			add_long(Tempout_L,inReg1(127 downto 64),outReg(127 downto 64));
			
		elsif insReg(22 down to 20)='110' then
			
			mult_long(inReg3(m_long-1 downto 0),inReg2(m_long-1 downto 0),Tempout_L);
			sub_long(inReg1(a_long-1 downto 0),Tempout_L,outReg(a_long-1 downto 0));
			
			mult_long(inReg3(95 downto 64),inReg2(95 downto 64),Tempout_L);
			sub_long(inReg1(127 downto 96),Tempout_L,outReg(127 downto 96));
			
		elsif insReg(22 down to 20)='111' then
			mult_long(inReg3(a_long-1 downto a),inReg2(a_long-1 downto a),Tempout_L);
			sub_long(inReg1(a_long-1 downto 0),Tempout_L,outReg(a_long-1 downto 0));
			
			mult_long(inReg3(127 downto 96),inReg2(127 downto 96),Tempout_L);
			sub_long(inReg1(127 downto 64),Tempout_L,outReg(127 downto 64));

-- mult(input1,input2,xsign,output);
-- add(input1,input2,xsign,output);
-- sub(input1,input2,xsign,output);
			end if;
		end process;  
end architecture alu;

