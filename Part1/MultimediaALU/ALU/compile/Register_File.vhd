-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : ALU
-- Author      : nebil.oumer@stonybrook.edu
-- Company     : none
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\seene\Desktop\Stony Brook\Fall 2022\ESE 345\Project\Pipelined-SIMD-multimedia-unit-design\Part1\MultimediaALU\ALU\compile\Register_File.vhd
-- Generated   : Tue Nov 29 13:37:38 2022
-- From        : C:\Users\seene\Desktop\Stony Brook\Fall 2022\ESE 345\Project\Pipelined-SIMD-multimedia-unit-design\Part1\MultimediaALU\ALU\src\code2graphics\Register_File.bde
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity Register_File is
  port(
       clk : in STD_LOGIC;
       sele : in STD_LOGIC_VECTOR(24 downto 0);
       registers_in : in reg_table;
       rdNum : in STD_LOGIC_VECTOR(4 downto 0);
       write_to_reg : in STD_LOGIC;
       writtenReg : in STD_LOGIC_VECTOR(127 downto 0);
       registers_out : out reg_table;
       r1Num : out STD_LOGIC_VECTOR(4 downto 0);
       r2Num : out STD_LOGIC_VECTOR(4 downto 0);
       r3Num : out STD_LOGIC_VECTOR(4 downto 0);
       rdNumOut : out STD_LOGIC_VECTOR(4 downto 0);
       out1 : out STD_LOGIC_VECTOR(127 downto 0);
       out2 : out STD_LOGIC_VECTOR(127 downto 0);
       out3 : out STD_LOGIC_VECTOR(127 downto 0)
  );
end Register_File;

architecture behavioral of Register_File is

---- Signal declarations used on the diagram ----

signal r1NumT : STD_LOGIC_VECTOR(4 downto 0);
signal r2NumT : STD_LOGIC_VECTOR(4 downto 0);
signal r3NumT : STD_LOGIC_VECTOR(4 downto 0);

begin

---- Processes ----

process (clk)
                         variable r1 : integer;
                         variable r2 : integer;
                         variable r3 : integer;
                       begin
                         if rising_edge(clk) then
                            if sele(24 downto 23) = "11" then
                               r1 := to_integer(unsigned(sele(9 downto 5)));
                               r1Num <= std_logic_vector(to_unsigned(r1,5));
                               out1 <= registers_in(r1);
                               r2 := to_integer(unsigned(sele(14 downto 10)));
                               r2NumT <= std_logic_vector(to_unsigned(r2,5));
                               r2Num <= r2NumT;
                               out2 <= registers_in(r2)(127 downto 0);
                               rdNumOut <= sele(4 downto 0);
                            elsif sele(24 downto 23) = "10" then
                               r1 := to_integer(unsigned(sele(9 downto 5)));
                               r1NumT <= std_logic_vector(to_unsigned(r1,5));
                               r1Num <= r1NumT;
                               out1 <= registers_in(r1)(127 downto 0);
                               r2 := to_integer(unsigned(sele(14 downto 10)));
                               r2NumT <= std_logic_vector(to_unsigned(r2,5));
                               r2Num <= r2NumT;
                               out2 <= registers_in(r2)(127 downto 0);
                               r3 := to_integer(unsigned(sele(19 downto 15)));
                               r3NumT <= std_logic_vector(to_unsigned(r3,5));
                               r3Num <= r3NumT;
                               out3 <= registers_in(r3)(127 downto 0);
                               rdNumOut <= sele(4 downto 0);
                            elsif sele(24) = '0' then
                               r1 := 1;
                               r1NumT <= std_logic_vector(to_unsigned(r1,5));
                               r1Num <= r1NumT;
                               r2 := 2;
                               r2NumT <= std_logic_vector(to_unsigned(r2,5));
                               r2Num <= r2NumT;
                               r3 := 3;
                               r3NumT <= std_logic_vector(to_unsigned(r3,5));
                               r3Num <= r3NumT;
                               rdNumOut <= sele(4 downto 0);
                               out1 <= registers_in(r1)(127 downto 0);
                               out2 <= registers_in(r2)(127 downto 0);
                               out3 <= registers_in(r3)(127 downto 0);
                            end if;
                            if write_to_reg = '1' then
                               registers_out <= registers_in;
                               registers_out(to_integer(unsigned(rdNum))) <= writtenReg;
                            end if;
                         end if;
                       end process;
                      

end behavioral;
