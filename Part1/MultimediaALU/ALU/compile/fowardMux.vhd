-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : ALU
-- Author      : nebil.oumer@stonybrook.edu
-- Company     : none
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\seene\Desktop\Stony Brook\Fall 2022\ESE 345\Project\Pipelined-SIMD-multimedia-unit-design\Part1\MultimediaALU\ALU\compile\fowardMux.vhd
-- Generated   : Thu Dec  1 14:16:09 2022
-- From        : C:\Users\seene\Desktop\Stony Brook\Fall 2022\ESE 345\Project\Pipelined-SIMD-multimedia-unit-design\Part1\MultimediaALU\ALU\src\code2graphics\fowardMux.bde
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

entity fowardMux is
  port(
       selSignal : in STD_LOGIC_VECTOR(2 downto 0);
       dataIn1 : in STD_LOGIC_VECTOR(127 downto 0);
       dataIn2 : in STD_LOGIC_VECTOR(127 downto 0);
       dataIn3 : in STD_LOGIC_VECTOR(127 downto 0);
       dataIn4 : in STD_LOGIC_VECTOR(127 downto 0);
       outReg1 : out STD_LOGIC_VECTOR(127 downto 0);
       outReg2 : out STD_LOGIC_VECTOR(127 downto 0);
       outReg3 : out STD_LOGIC_VECTOR(127 downto 0)
  );
end fowardMux;

architecture fmux of fowardMux is

begin

---- User Signal Assignments ----
outReg1 <= dataIn4 when selSignal(2) = '1' else dataIn1;
outReg2 <= dataIn4 when selSignal(1) = '1' else dataIn2;
outReg3 <= dataIn4 when selSignal(0) = '1' else dataIn3;

end fmux;
