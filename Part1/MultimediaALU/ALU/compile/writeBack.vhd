-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : ALU
-- Author      : nebil.oumer@stonybrook.edu
-- Company     : none
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\seene\Desktop\Stony Brook\Fall 2022\ESE 345\Project\Pipelined-SIMD-multimedia-unit-design\Part1\MultimediaALU\ALU\compile\writeBack.vhd
-- Generated   : Sun Nov 27 20:45:38 2022
-- From        : C:\Users\seene\Desktop\Stony Brook\Fall 2022\ESE 345\Project\Pipelined-SIMD-multimedia-unit-design\Part1\MultimediaALU\ALU\src\code2graphics\writeBack.bde
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

entity writeBack is
  port(
       aluOut : in STD_LOGIC_VECTOR(127 downto 0);
       outReg : out STD_LOGIC_VECTOR(127 downto 0)
  );
end writeBack;

architecture wb of writeBack is

begin

---- User Signal Assignments ----
outReg <= aluOut;

end wb;
