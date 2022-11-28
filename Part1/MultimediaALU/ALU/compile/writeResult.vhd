-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : ALU
-- Author      : nebil.oumer@stonybrook.edu
-- Company     : none
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\seene\Desktop\Stony Brook\Fall 2022\ESE 345\Project\Pipelined-SIMD-multimedia-unit-design\Part1\MultimediaALU\ALU\compile\writeResult.vhd
-- Generated   : Sun Nov 27 20:45:38 2022
-- From        : C:\Users\seene\Desktop\Stony Brook\Fall 2022\ESE 345\Project\Pipelined-SIMD-multimedia-unit-design\Part1\MultimediaALU\ALU\src\code2graphics\writeResult.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library alu;
use alu.myPackage.all;
use std.TEXTIO.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;
use ieee.STD_LOGIC_TEXTIO.all;

entity writeResult is
  port(
       cycleCounter : in INTEGER;
       stages : in instructions_at_stages
  );
end writeResult;

architecture write_toResultFile of writeResult is

---- Architecture declarations -----
file resultFile : text;



begin

---- Processes ----

process (cycleCounter)
                         variable write_to_result : line;
                       begin
                         FILE_OPEN(resultFile,"result.txt",write_mode);
                         WRITE(write_to_result,string'("Cycle "));
                         WRITE(write_to_result,cycleCounter);
                         WRITE(write_to_result,string'(":"));
                         WRITELINE(resultFile,write_to_result);
                         WRITE(write_to_result,string'("Stage 1: "));
                         WRITE(write_to_result,stages(1));
                         WRITE(write_to_result,string'("Stage 2: "));
                         WRITE(write_to_result,stages(2));
                         WRITE(write_to_result,string'("Stage 3: "));
                         WRITE(write_to_result,stages(3));
                         WRITE(write_to_result,string'("Stage 4: "));
                         WRITE(write_to_result,stages(4));
                         WRITELINE(resultFile,write_to_result);
                       end process;
                      

end write_toResultFile;