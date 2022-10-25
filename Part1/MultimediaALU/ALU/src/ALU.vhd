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
	generic (m,a,s : integer := 16);
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
				   signal sign : in std_logic;
				   signal oput : out std_logic_vector(m-1 downto 0)) is
	begin
		if xsign = '0'then 	--- unsigned multiplicatin
			oput <= std_logic_vector(resize(unsigned(in1) * unsigned(in2),m));
		else 				--- signed multiplication
			oput <= std_logic_vector(resize((signed(in1) * signed(in2)),m)); 
		end if;
	end procedure;	 	
	------------------------------------------------------------------------- 
	
	
	-------------------------------------------------------------------------  
	---- prodcedure to do  adddition of two n bit inputs
	procedure add(signal in1,in2 : in std_logic_vector(a-1 downto 0);
				   signal sign : in std_logic;
				   signal oput : out std_logic_vector(a-1 downto 0)) is
	begin
		if xsign = '0'then 	  ---- unsigned addition
			oput <= std_logic_vector(resize(unsigned(in1) + unsigned(in2),a));
		else 				  ---- signed addition
			oput <= std_logic_vector(resize((signed(in1) + signed(in2)),a)); 
		end if;
	end procedure; 
	-------------------------------------------------------------------------
	
	-------------------------------------------------------------------------
	---- prodcedure to do  subtraction of two n bit inputs
	procedure sub(signal in1,in2 : in std_logic_vector(s-1 downto 0);
				   signal sign : in std_logic;
				   signal oput : out std_logic_vector(s-1 downto 0)) is
	begin
		if xsign = '0'then 	  --- unsigned subtraction
			oput <= std_logic_vector(resize(unsigned(in1) - unsigned(in2),s));
		else 				  --- signed subtraction
			oput <= std_logic_vector(resize((signed(in1) - signed(in2)),s)); 
		end if;
	end procedure;
	---------------------------------------------------------------------------
begin 	   
	process(input1,input2)
	begin
		if rising_edge(clk)	then
--			mult(input1,input2,xsign,output); 
--			add(input1,input2,xsign,output);
--			sub(input1,input2,xsign,output);
		end if;
	end process;	  
end architecture alu;