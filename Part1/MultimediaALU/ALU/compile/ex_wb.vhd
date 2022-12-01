-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : ALU
-- Author      : nebil.oumer@stonybrook.edu
-- Company     : none
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\seene\Desktop\Stony Brook\Fall 2022\ESE 345\Project\Pipelined-SIMD-multimedia-unit-design\Part1\MultimediaALU\ALU\compile\ex_wb.vhd
-- Generated   : Thu Dec  1 14:16:09 2022
-- From        : C:\Users\seene\Desktop\Stony Brook\Fall 2022\ESE 345\Project\Pipelined-SIMD-multimedia-unit-design\Part1\MultimediaALU\ALU\src\code2graphics\ex_wb.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity ex_wb is
  port(
       clk : in STD_LOGIC;
       regWrite_in : in STD_LOGIC_VECTOR(4 downto 0);
       dataIn : in STD_LOGIC_VECTOR(127 downto 0);
       regWrite_out : out STD_LOGIC_VECTOR(4 downto 0);
       outResult : out STD_LOGIC_VECTOR(127 downto 0)
  );
end ex_wb;

architecture exWB of ex_wb is

---- Signal declarations used on the diagram ----

signal rdTemp : STD_LOGIC_VECTOR(4 downto 0);
signal temp : STD_LOGIC_VECTOR(127 downto 0);

begin

---- Processes ----

process (clk)
                       begin
                         if rising_edge(clk) then
                            outResult <= dataIn;
                            regWrite_out <= regWrite_in;
                         end if;
                       end process;
                      

end exWB;
