-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : ALU
-- Author      : nebil.oumer@stonybrook.edu
-- Company     : none
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\seene\Desktop\Stony Brook\Fall 2022\ESE 345\Project\Pipelined-SIMD-multimedia-unit-design\Part1\MultimediaALU\ALU\compile\id_ex.vhd
-- Generated   : Sun Nov 27 20:45:32 2022
-- From        : C:\Users\seene\Desktop\Stony Brook\Fall 2022\ESE 345\Project\Pipelined-SIMD-multimedia-unit-design\Part1\MultimediaALU\ALU\src\code2graphics\id_ex.bde
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

entity id_ex is
  port(
       clk : in STD_LOGIC;
       dataIn1 : in STD_LOGIC_VECTOR(127 downto 0);
       dataIn2 : in STD_LOGIC_VECTOR(127 downto 0);
       dataIn3 : in STD_LOGIC_VECTOR(127 downto 0);
       rdNumIn : in STD_LOGIC_VECTOR(4 downto 0);
       dataOut1 : out STD_LOGIC_VECTOR(127 downto 0);
       dataOut2 : out STD_LOGIC_VECTOR(127 downto 0);
       dataOut3 : out STD_LOGIC_VECTOR(127 downto 0);
       rdNumOut : out STD_LOGIC_VECTOR(4 downto 0)
  );
end id_ex;

architecture idEX of id_ex is

begin

---- Processes ----

process (clk)
                       begin
                         if rising_edge(clk) then
                            dataOut1 <= dataIn1;
                            dataOut2 <= dataIn2;
                            dataOut3 <= dataIn3;
                            rdNumOut <= rdNumIn;
                         end if;
                       end process;
                      

end idEX;