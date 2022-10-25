----------------------------------------------------------------------------------------
---ESE 345 Porject: Pipelined SIMD multimedia unit design - Part 1	
---Authors: Nebil Oumer and Elijah Farrell
---File:ALU.vhdl
---10/30/2022 
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------multiplication of n bits 
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.all; 

entity multiplication	is 
	generic (m : integer := 16); --- generic used so we can do operation on multiple bit lengths
	port(
	clk, xsign : in std_logic;---- xsign used to do either unsigned or signed operations
	input1,input2 :in std_logic_vector(m-1 downto 0); --input values
	output: out std_logic_vector(m-1 downto 0) --- output values
	);
end multiplication; 

architecture multAlu of multiplication is 	   
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
begin 
	process(input1,input2)
	begin
		if rising_edge(clk)	then
			 mult(input1,input2,xsign,output);
		end if;
	end process;
end architecture multAlu;---- behavioral archtitecure for multiplication
---------------------------------------------------------------------------------------- 
----------------------------------------------------------------------------------------addition of n bits	  
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.all; 

entity addition	is 
	generic (a : integer := 16); --- generic used so we can do operation on multiple bit lengths
	port(
	clk, xsign : in std_logic;---- xsign used to do either unsigned or signed operations
	input1,input2 :in std_logic_vector(a-1 downto 0); --input values
	output: out std_logic_vector(a-1 downto 0) --- output values
	);
end addition; 

architecture addAlu of addition is
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
begin 
	process(input1,input2)
	begin
		if rising_edge(clk)	then
			 add(input1,input2,xsign,output);
		end if;
	end process;
end architecture addAlu;	--- behavioral archtitecure for addition
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------subtraction of n bits	
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.all; 

entity subtraction	is 
	generic (s : integer := 16);
	port(
	clk, xsign : in std_logic;
	input1,input2 :in std_logic_vector(s-1 downto 0); --input values
	output: out std_logic_vector(s-1 downto 0) --- output values
	);
end subtraction; 

architecture subAlu of subtraction is 
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
begin 
	process(clk)
	begin
		if rising_edge(clk)	then
			 sub(input1,input2,xsign,output);
		end if;
	end process;
end architecture subAlu; --- behavioral archtitecure for subtraction
-----------------------------------------------------------------------------------------
library ieee;								  	
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use work.all;  

entity aluIO is   --- the three 128 bit inputs and the one 128 bit output register
	port(
	clk: in std_logic;
	inReg1, inReg2, inReg3: in std_logic_vector(127 downto 0);	---- input registers
	insReg3,insReg4 : in std_logic_vector(24 downto 0); ---- instruction input
	outReg: out std_logic_vector(127 downto 0)	  ---- output register
	);
end aluIO;

architecture alu of aluIO is

begin 	   
	process(clk)   --- every clock cycle read from 3 registers and wrtie to 1 register
	begin	  
		if rising_edge(clk) then 
			---u1:
			---u2:
			---u3:
			---u4:
		end if;
	end process;
	
end architecture alu;