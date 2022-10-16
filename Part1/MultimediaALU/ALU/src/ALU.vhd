library ieee;
use ieee.std_logic_1164.all;
use work.all;

----------------------------------------------------------------------------------------multiplication of n bits
entity multiplication	is 
	generic (m : integer);
	port(
	input1,input2 :in std_logic_vector(m-1 downto 0); --input values
	output: in std_logic_vector(m-1 downto 0); --- output values
	);
end multiplication; 

architecture multAlu of multiplication is 
begin 
	---- when else to do either a unsigned or signed operation
	output <= std_logic_vector(resize(unsigned(input1) * unsigned(input2),m)) when xsign = '0' else std_logic_vector(resize(input1 * input2,a));
end architecture multAlu;
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------addition of n bits
entity addition	is 
	generic (a : integer);
	port(								
	xsign : in std_logic;
	input1,input2 :in std_logic_vector(a-1 downto 0); --input values
	output: in std_logic_vector(a-1 downto 0); --- output values
	);
end addition; 

architecture addAlu of addition is 
begin 
	---- when else to do either a unsigned or signed operation
   output <= std_logic_vector(resize(unsigned(input1) + unsigned(input2),a)) when xsign = '0' else std_logic_vector(resize(input1 + input2,a));
end architecture addAlu;
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------subtraction of n bits
entity subtraction	is 
	generic (s : integer);
	port(
	input1,input2 :in std_logic_vector(s-1 downto 0); --input values
	output: in std_logic_vector(s-1 downto 0); --- output values
	);
end subtraction; 

architecture subAlu of subtraction is 
begin	
   ---- when else to do either a unsigned or signed operation
   output <= std_logic_vector(resize(unsigned(input1) - unsigned(input2),s)) when xsign = '0' else std_logic_vector(resize(input1 - input2,a));
end architecture subAlu;
-----------------------------------------------------------------------------------------


entity aluIO is   --- the three 128 bit inputs and the one 128 bit output register
	port(
	clk: in std_logic;
	inReg1, inReg2, inReg3: in std_logic_vector(127 downto 0);	
	intsReg3,intsReg4 : in std_logic_vector(24 downto 0); 
	outReg: out std_logic_vector(127 downto 0);
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