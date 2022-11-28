-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : ALU
-- Author      : nebil.oumer@stonybrook.edu
-- Company     : none
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\seene\Desktop\Stony Brook\Fall 2022\ESE 345\Project\Pipelined-SIMD-multimedia-unit-design\Part1\MultimediaALU\ALU\compile\dataFowarding.vhd
-- Generated   : Sun Nov 27 20:45:31 2022
-- From        : C:\Users\seene\Desktop\Stony Brook\Fall 2022\ESE 345\Project\Pipelined-SIMD-multimedia-unit-design\Part1\MultimediaALU\ALU\src\code2graphics\dataFowarding.bde
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

entity dataFowarding is
  port(
       dataIn : in STD_LOGIC_VECTOR(127 downto 0);
       regNumIn : in STD_LOGIC_VECTOR(4 downto 0);
       regNumOut : out STD_LOGIC_VECTOR(4 downto 0);
       outResult : out STD_LOGIC_VECTOR(127 downto 0)
  );
end dataFowarding;

architecture fowarding of dataFowarding is

begin

---- User Signal Assignments ----
outResult <= dataIn;
regNumOut <= regNumIn;

end fowarding;
