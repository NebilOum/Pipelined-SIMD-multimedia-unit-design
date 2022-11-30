-------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : ALU
-- Author      : nebil.oumer@stonybrook.edu
-- Company     : none
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\seene\Desktop\Stony Brook\Fall 2022\ESE 345\Project\Pipelined-SIMD-multimedia-unit-design\Part1\MultimediaALU\ALU\compile\aluIO.vhd
-- Generated   : Tue Nov 29 20:36:12 2022
-- From        : C:\Users\seene\Desktop\Stony Brook\Fall 2022\ESE 345\Project\Pipelined-SIMD-multimedia-unit-design\Part1\MultimediaALU\ALU\src\code2graphics\aluIO.bde
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

entity aluIO is
  generic(
       m : integer := 16;
       a : integer := 32;
       m_long : integer := 32;
       s : integer := 32;
       a_long : integer := 64;
       s_long : integer := 64
  );
  port(
       inReg1 : in STD_LOGIC_VECTOR(127 downto 0);
       inReg2 : in STD_LOGIC_VECTOR(127 downto 0);
       inReg3 : in STD_LOGIC_VECTOR(127 downto 0);
       insReg : in STD_LOGIC_VECTOR(24 downto 0);
       writeToReg : out STD_LOGIC;
       outReg : out STD_LOGIC_VECTOR(127 downto 0)
  );
end aluIO;

architecture alu of aluIO is

---- Architecture declarations -----
procedure mult (signal xsign : IN std_logic;signal in1 : IN std_logic_vector(m - 1 downto 0);signal in2 : IN std_logic_vector(m - 1 downto 0);variable oput : OUT std_logic_vector(m_long - 1 downto 0)) is 
                     begin
                       if xsign = '1' then
                          oput := std_logic_vector(resize((signed(in1) * signed(in2)),32));
                       elsif xsign = '0' then
                          oput := std_logic_vector(resize((unsigned(in1) * unsigned(in2)),32));
                       end if;
                     end procedure mult;
procedure mult_long (signal xsign : IN std_logic;signal in1 : IN std_logic_vector(m_long - 1 downto 0);signal in2 : IN std_logic_vector(m_long - 1 downto 0);variable oput : OUT std_logic_vector(63 downto 0)) is 
                     begin
                       if xsign = '1' then
                          oput := std_logic_vector(resize((signed(in1) * signed(in2)),64));
                       elsif xsign = '0' then
                          oput := std_logic_vector(resize((unsigned(in1) * unsigned(in2)),64));
                       end if;
                     end procedure mult_long;
procedure add (signal xsign : IN std_logic;variable in1 : IN std_logic_vector(a - 1 downto 0);signal in2 : IN std_logic_vector(a - 1 downto 0);variable oput : OUT std_logic_vector(a - 1 downto 0)) is 
                     begin
                       if xsign = '1' then
                          oput := std_logic_vector(resize((signed(in1) + signed(in2)),a));
                       elsif xsign = '0' then
                          oput := std_logic_vector(resize((unsigned(in1) + unsigned(in2)),a));
                       end if;
                     end procedure add;
procedure add_half (signal xsign : IN std_logic;variable in1 : IN std_logic_vector(15 downto 0);signal in2 : IN std_logic_vector(15 downto 0);variable oput : OUT std_logic_vector(15 downto 0)) is 
                     begin
                       if xsign = '1' then
                          oput := std_logic_vector(resize((signed(in1) + signed(in2)),16));
                       elsif xsign = '0' then
                          oput := std_logic_vector(resize((unsigned(in1) + unsigned(in2)),16));
                       end if;
                     end procedure add_half;
procedure add_long (signal xsign : IN std_logic;variable in1 : IN std_logic_vector(a_long - 1 downto 0);signal in2 : IN std_logic_vector(a_long - 1 downto 0);variable oput : OUT std_logic_vector(a_long - 1 downto 0)) is 
                     begin
                       if xsign = '1' then
                          oput := std_logic_vector(resize((signed(in1) + signed(in2)),a_long));
                       elsif xsign = '0' then
                          oput := std_logic_vector(unsigned(in1) + unsigned(in2));
                       end if;
                     end procedure add_long;
procedure sub_half (signal xsign : IN std_logic;signal in1 : IN std_logic_vector(15 downto 0);variable in2 : IN std_logic_vector(15 downto 0);variable oput : OUT std_logic_vector(15 downto 0)) is 
                     begin
                       if xsign = '1' then
                          oput := std_logic_vector(resize((signed(in1) - signed(in2)),16));
                       elsif xsign = '0' then
                          oput := std_logic_vector(resize((unsigned(in1) - unsigned(in2)),16));
                       end if;
                     end procedure sub_half;
procedure sub (signal xsign : IN std_logic;signal in1 : IN std_logic_vector(s - 1 downto 0);variable in2 : IN std_logic_vector(s - 1 downto 0);variable oput : OUT std_logic_vector(s - 1 downto 0)) is 
                     begin
                       if xsign = '1' then
                          oput := std_logic_vector(resize((signed(in1) - signed(in2)),s));
                       elsif xsign = '0' then
                          oput := std_logic_vector(resize((unsigned(in1) - unsigned(in2)),s));
                       end if;
                     end procedure sub;
procedure sub_long (signal xsign : IN std_logic;signal in1 : IN std_logic_vector(s_long - 1 downto 0);variable in2 : IN std_logic_vector(s_long - 1 downto 0);variable oput : OUT std_logic_vector(s_long - 1 downto 0)) is 
                     begin
                       if xsign = '1' then
                          oput := std_logic_vector(resize((signed(in1) - signed(in2)),s_long));
                       elsif xsign = '0' then
                          oput := std_logic_vector(resize((unsigned(in1) - unsigned(in2)),s_long));
                       end if;
                     end procedure sub_long;
procedure sat_half (signal input : IN std_logic_vector(15 downto 0);variable output : OUT std_logic_vector(15 downto 0)) is 
                     begin
                       if (signed(input) > signed(x"7FFF")) then
                          output := x"7FFF";
                       elsif (signed(input) < signed(x"8000")) then
                          output := x"8000";
                       end if;
                     end procedure sat_half;
procedure sat_int (signal input : IN std_logic_vector(31 downto 0);variable output : OUT std_logic_vector(31 downto 0)) is 
                     begin
                       if (signed(input) > signed(x"7FFFFFFF")) then
                          output := x"7FFFFFFF";
                       elsif (signed(input) < signed(x"80000000")) then
                          output := x"80000000";
                       end if;
                     end procedure sat_int;
procedure sat_long (signal input : IN std_logic_vector(63 downto 0);variable output : OUT std_logic_vector(63 downto 0)) is 
                     begin
                       if (signed(input) > signed(x"7FFFFFFFFFFFFFFF")) then
                          output := x"7FFFFFFFFFFFFFFF";
                       elsif (signed(input) < signed(x"8000000000000000")) then
                          output := x"8000000000000000";
                       end if;
                     end procedure sat_long;
procedure load (signal instruc : IN std_logic_vector(24 downto 0);signal output : OUT std_logic_vector(127 downto 0)) is 
                       variable position : integer;
                     begin
                       position := to_integer(unsigned(instruc(23 downto 21)));
                       if position = 0 then
                          output(15 downto 0) <= instruc(20 downto 5);
                       elsif position = 1 then
                          output(31 downto 16) <= instruc(20 downto 5);
                       elsif position = 2 then
                          output(47 downto 32) <= instruc(20 downto 5);
                       elsif position = 3 then
                          output(63 downto 48) <= instruc(20 downto 5);
                       elsif position = 4 then
                          output(79 downto 64) <= instruc(20 downto 5);
                       elsif position = 5 then
                          output(95 downto 80) <= instruc(20 downto 5);
                       elsif position = 6 then
                          output(111 downto 96) <= instruc(20 downto 5);
                       elsif position = 7 then
                          output(127 downto 112) <= instruc(20 downto 5);
                       end if;
                     end procedure load;
procedure clzw (signal input : IN std_logic_vector(31 downto 0);signal output : OUT std_logic_vector(31 downto 0)) is 
                       variable i : integer := 31;
                       variable counter : integer := 0;
                     begin
                       while input(i) = '0' loop
                           counter := counter + 1;
                           i := i - 1;
                           if (i < 0) then
                              i := 0;
                           end if;
                       end loop;
                       output <= std_logic_vector(to_unsigned(counter,32));
                     end procedure clzw;
procedure maxws (signal input1 : IN std_logic_vector(31 downto 0);signal input2 : IN std_logic_vector(31 downto 0);signal output : OUT std_logic_vector(31 downto 0)) is 
                     begin
                       if (signed(input1) > signed(input2)) then
                          output <= input1;
                       elsif (signed(input1) < signed(input2)) then
                          output <= input2;
                       elsif (signed(input1) = signed(input2)) then
                          output <= input1;
                       end if;
                     end procedure maxws;
procedure minws (signal input1 : IN std_logic_vector(31 downto 0);signal input2 : IN std_logic_vector(31 downto 0);signal output : OUT std_logic_vector(31 downto 0)) is 
                     begin
                       if (signed(input1) > signed(input2)) then
                          output <= input2;
                       elsif (signed(input1) < signed(input2)) then
                          output <= input1;
                       elsif (signed(input1) = signed(input2)) then
                          output <= input1;
                       end if;
                     end procedure minws;
procedure MLHCU (signal xsign : IN std_logic;signal in1 : IN std_logic_vector(m - 1 downto 0);signal in2 : IN std_logic_vector(4 downto 0);variable oput : OUT std_logic_vector(m_long - 1 downto 0)) is 
                     begin
                       if xsign = '1' then
                          oput := std_logic_vector(resize((signed(in1) * signed(in2)),m_long));
                       else 
                          oput := std_logic_vector(resize((unsigned(in1) * unsigned(in2)),m_long));
                       end if;
                     end procedure MLHCU;
procedure PCNTW (signal input : IN std_logic_vector(31 downto 0);signal output : OUT std_logic_vector(31 downto 0)) is 
                       variable i : integer := 31;
                       variable counter : integer := 0;
                     begin
                       for i in 31 downto 0 loop
                           if (input(i) = '1') then
                              counter := counter + 1;
                           end if;
                       end loop;
                       output <= std_logic_vector(to_unsigned(counter,32));
                     end procedure PCNTW;
procedure ROTW (signal in1 : IN std_logic_vector(31 downto 0);signal in2 : IN std_logic_vector(31 downto 0);variable output : OUT std_logic_vector(31 downto 0)) is 
                       variable rotate : integer;
                       variable finalPos : std_logic_vector(31 downto 0);
                     begin
                       rotate := to_integer(unsigned(in2(4 downto 0)));
                       finalPos := in1(31 downto 0);
                       for i in 1 to rotate loop
                           output := finalPos(0) & finalPos(31 downto 1);
                       end loop;
                     end procedure ROTW;



---- Signal declarations used on the diagram ----

signal in1 : STD_LOGIC;
signal in2 : STD_LOGIC;
signal input : STD_LOGIC;
signal input1 : STD_LOGIC;
signal input2 : STD_LOGIC;
signal instruc : STD_LOGIC;
signal noSignOp : STD_LOGIC := '0';
signal output : STD_LOGIC;
signal signOp : STD_LOGIC := '1';
signal xsign : STD_LOGIC;
signal t32 : STD_LOGIC_VECTOR(31 downto 0);
signal t64 : STD_LOGIC_VECTOR(63 downto 0);
signal tempFull : STD_LOGIC_VECTOR(127 downto 0) := std_logic_vector(to_unsigned(0,128));
signal Tempout : STD_LOGIC_VECTOR(31 downto 0);
signal tempOut_half : STD_LOGIC_VECTOR(15 downto 0) := std_logic_vector(to_unsigned(0,16));
signal Tempout_L : STD_LOGIC_VECTOR(63 downto 0);

begin

---- Processes ----

process (insReg)
                         variable t_half : std_logic_vector(15 downto 0);
                         variable oT_half : std_logic_vector(15 downto 0);
                         variable t : std_logic_vector(31 downto 0);
                         variable oT : std_logic_vector(31 downto 0);
                         variable t_long : std_logic_vector(63 downto 0);
                         variable oT_long : std_logic_vector(63 downto 0);
                         variable oT_full : std_logic_vector(127 downto 0);
                       begin
                         load : if (insReg(24) = '0') then
                            load(insReg,outReg);
                         end if load;
                         r4 : if (insReg(24 downto 23) = "10") then
                            if insReg(22 downto 20) = "000" then
                               mult(signOp,inReg3(15 downto 0),inReg2(15 downto 0),t);
                               t32 <= t;
                               add(signOp,t,inReg1(a - 1 downto 0),oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(31 downto 0) <= oT;
                               mult(signOp,inReg3(47 downto 32),inReg2(47 downto 32),t);
                               t32 <= t;
                               add(signOp,t,inReg1(63 downto 32),oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(63 downto 32) <= oT;
                               mult(signOp,inReg3(79 downto 64),inReg2(79 downto 64),t);
                               t32 <= t;
                               add(signOp,t,inReg1(95 downto 64),oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(95 downto 64) <= oT;
                               mult(signOp,inReg3(111 downto 96),inReg2(111 downto 96),t);
                               t32 <= t;
                               add(signOp,t,inReg1(127 downto 96),oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(127 downto 96) <= oT;
                               writeToReg <= '1';
                            elsif insReg(22 downto 20) = "001" then
                               mult(signOp,inReg3(a - 1 downto m),inReg2(a - 1 downto m),t);
                               t32 <= t;
                               add(signOp,t,inReg1(a - 1 downto 0),oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(31 downto 0) <= oT;
                               mult(signOp,inReg3(63 downto 48),inReg2(63 downto 48),t);
                               t32 <= t;
                               add(signOp,t,inReg1(63 downto 32),oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(63 downto 32) <= oT;
                               mult(signOp,inReg3(95 downto 80),inReg2(95 downto 80),t);
                               t32 <= t;
                               add(signOp,t,inReg1(95 downto 64),oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(95 downto 64) <= oT;
                               mult(signOp,inReg3(127 downto 96),inReg2(127 downto 96),t);
                               t32 <= t;
                               add(signOp,t,inReg1(127 downto 96),oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(127 downto 96) <= oT;
                               writeToReg <= '1';
                            elsif insReg(22 downto 20) = "010" then
                               mult(signOp,inReg3(15 downto 0),inReg2(15 downto 0),t);
                               t32 <= t;
                               sub(signOp,inReg1(a - 1 downto 0),t,oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(31 downto 0) <= oT;
                               mult(signOp,inReg3(47 downto 32),inReg2(47 downto 32),t);
                               t32 <= t;
                               sub(signOp,inReg1(63 downto 32),t,oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(63 downto 32) <= oT;
                               mult(signOp,inReg3(79 downto 64),inReg2(79 downto 64),t);
                               t32 <= t;
                               sub(signOp,inReg1(95 downto 64),t,oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(95 downto 64) <= oT;
                               mult(signOp,inReg3(111 downto 96),inReg2(111 downto 96),t);
                               t32 <= t;
                               sub(signOp,inReg1(127 downto 96),t,oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(127 downto 96) <= oT;
                               writeToReg <= '1';
                            elsif insReg(22 downto 20) = "011" then
                               mult(signOp,inReg3(a - 1 downto m),inReg2(a - 1 downto m),t);
                               t32 <= t;
                               sub(signOp,inReg1(a - 1 downto 0),t,oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(31 downto 0) <= oT;
                               mult(signOp,inReg3(63 downto 48),inReg2(63 downto 48),t);
                               t32 <= t;
                               sub(signOp,inReg1(63 downto 32),t,oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(63 downto 32) <= oT;
                               mult(signOp,inReg3(95 downto 80),inReg2(95 downto 80),t);
                               t32 <= t;
                               sub(signOp,inReg1(95 downto 64),t,oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(95 downto 64) <= oT;
                               mult(signOp,inReg3(127 downto 96),inReg2(127 downto 96),t);
                               t32 <= t;
                               sub(signOp,inReg1(127 downto 96),t,oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(127 downto 96) <= oT;
                               writeToReg <= '1';
                            elsif insReg(22 downto 20) = "100" then
                               mult_long(signOp,inReg3(31 downto 0),inReg2(31 downto 0),t_long);
                               t64 <= t_long;
                               add_long(signOp,t_long,inReg1(63 downto 0),oT_long);
                               Tempout_L <= oT_long;
                               sat_long(Tempout_L,oT_long);
                               outreg(63 downto 0) <= oT_long;
                               mult_long(signOp,inReg3(95 downto 64),inReg2(95 downto 64),t_long);
                               t64 <= t_long;
                               add_long(signOp,t_long,inReg1(127 downto 64),oT_long);
                               Tempout_L <= oT_long;
                               sat_long(Tempout_L,oT_long);
                               outreg(127 downto 64) <= oT_long;
                               writeToReg <= '1';
                            elsif insReg(22 downto 20) = "101" then
                               mult_long(signOp,inReg3(63 downto 31),inReg2(63 downto 31),t_long);
                               t64 <= t_long;
                               sub_long(signOp,inReg1(63 downto 0),t_long,oT_long);
                               Tempout_L <= oT_long;
                               sat_long(Tempout_L,oT_long);
                               outreg(63 downto 0) <= oT_long;
                               mult_long(signOp,inReg3(127 downto 96),inReg2(127 downto 96),t_long);
                               t64 <= t_long;
                               sub_long(signOp,inReg1(127 downto 64),t_long,oT_long);
                               Tempout_L <= oT_long;
                               sat_long(Tempout_L,oT_long);
                               outreg(127 downto 64) <= oT_long;
                               writeToReg <= '1';
                            elsif insReg(22 downto 20) = "110" then
                               mult_long(signOp,inReg3(31 downto 0),inReg2(31 downto 0),t_long);
                               t64 <= t_long;
                               sub_long(signOp,inReg1(63 downto 0),t_long,oT_long);
                               Tempout_L <= oT_long;
                               sat_long(Tempout_L,oT_long);
                               outreg(63 downto 0) <= oT_long;
                               mult_long(signOp,inReg3(a - 1 downto m),inReg2(a - 1 downto m),t_long);
                               t64 <= t_long;
                               sub_long(signOp,inReg1(127 downto 64),t_long,oT_long);
                               Tempout_L <= oT_long;
                               sat_long(Tempout_L,oT_long);
                               outreg(127 downto 64) <= oT_long;
                               writeToReg <= '1';
                            elsif insReg(22 downto 20) = "111" then
                               mult_long(signOp,inReg3(63 downto 31),inReg2(63 downto 31),t_long);
                               t64 <= t_long;
                               sub_long(signOp,inReg1(63 downto 0),t_long,oT_long);
                               Tempout_L <= oT_long;
                               sat_long(Tempout_L,oT_long);
                               outreg(63 downto 0) <= oT_long;
                               mult_long(signOp,inReg3(127 downto 96),inReg2(127 downto 96),t_long);
                               t64 <= t_long;
                               sub_long(signOp,inReg1(127 downto 64),t_long,oT_long);
                               Tempout_L <= oT_long;
                               sat_long(Tempout_L,oT_long);
                               outreg(127 downto 64) <= oT_long;
                               writeToReg <= '1';
                            end if;
                         end if r4;
                         r3 : if (insReg(24 downto 23) = "11") then
                            if (insReg(18 downto 15) = "0000") then
                               null;
                               writeToReg <= '0';
                            elsif (insReg(18 downto 15) = "0001") then
                               clzw(inReg1(31 downto 0),outReg(31 downto 0));
                               clzw(inReg1(63 downto 32),outReg(63 downto 32));
                               clzw(inReg1(95 downto 64),outReg(95 downto 64));
                               clzw(inReg1(127 downto 96),outReg(127 downto 96));
                               writeToReg <= '1';
                            elsif (insReg(18 downto 15) = "0010") then
                               t := inReg1(31 downto 0);
                               add(noSignOp,t,inReg2(31 downto 0),oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(31 downto 0) <= oT;
                               t := inReg1(63 downto 32);
                               add(noSignOp,t,inReg2(63 downto 32),oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(63 downto 32) <= oT;
                               t := inReg1(95 downto 64);
                               add(noSignOp,t,inReg2(95 downto 64),oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(95 downto 64) <= oT;
                               t := inReg1(127 downto 96);
                               add(noSignOp,t,inReg2(127 downto 96),oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(127 downto 96) <= oT;
                               writeToReg <= '1';
                            elsif (insReg(18 downto 15) = "0011") then
                               t_half := inReg1(15 downto 0);
                               add_half(noSignOp,t_half,inReg2(15 downto 0),oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(15 downto 0) <= oT_half;
                               t_half := inReg1(31 downto 16);
                               add_half(noSignOp,t_half,inReg2(31 downto 16),oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(31 downto 16) <= oT_half;
                               t_half := inReg1(47 downto 32);
                               add_half(noSignOp,t_half,inReg2(47 downto 32),oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(47 downto 32) <= oT_half;
                               t_half := inReg1(63 downto 48);
                               add_half(noSignOp,t_half,inReg2(63 downto 48),oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(63 downto 48) <= oT_half;
                               t_half := inReg1(79 downto 64);
                               add_half(noSignOp,t_half,inReg2(79 downto 64),oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(79 downto 64) <= oT_half;
                               t_half := inReg1(95 downto 80);
                               add_half(noSignOp,t_half,inReg2(95 downto 80),oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(95 downto 80) <= oT_half;
                               t_half := inReg1(111 downto 96);
                               add_half(noSignOp,t_half,inReg2(111 downto 96),oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(111 downto 96) <= oT_half;
                               t_half := inReg1(127 downto 112);
                               add_half(noSignOp,t_half,inReg2(127 downto 112),oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(127 downto 112) <= oT_half;
                               writeToReg <= '1';
                            elsif (insReg(18 downto 15) = "0100") then
                               t_half := inReg1(15 downto 0);
                               add_half(signOp,t_half,inReg2(15 downto 0),oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(15 downto 0) <= oT_half;
                               t_half := inReg1(31 downto 16);
                               add_half(signOp,t_half,inReg2(31 downto 16),oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(31 downto 16) <= oT_half;
                               t_half := inReg1(47 downto 32);
                               add_half(signOp,t_half,inReg2(47 downto 32),oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(47 downto 32) <= oT_half;
                               t_half := inReg1(63 downto 48);
                               add_half(signOp,t_half,inReg2(63 downto 48),oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(63 downto 48) <= oT_half;
                               t_half := inReg1(79 downto 64);
                               add_half(signOp,t_half,inReg2(79 downto 64),oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(79 downto 64) <= oT_half;
                               t_half := inReg1(95 downto 80);
                               add_half(signOp,t_half,inReg2(95 downto 80),oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(95 downto 80) <= oT_half;
                               t_half := inReg1(111 downto 96);
                               add_half(signOp,t_half,inReg2(111 downto 96),oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(111 downto 96) <= oT_half;
                               t_half := inReg1(127 downto 112);
                               add_half(signOp,t_half,inReg2(127 downto 112),oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(127 downto 112) <= oT_half;
                               writeToReg <= '1';
                            elsif (insReg(18 downto 15) = "0101") then
                               outReg <= inReg1 and inReg2;
                               writeToReg <= '1';
                            elsif (insReg(18 downto 15) = "0110") then
                               outReg(31 downto 0) <= inReg1(31 downto 0);
                               outReg(63 downto 32) <= inReg1(31 downto 0);
                               outReg(95 downto 64) <= inReg1(31 downto 0);
                               outReg(127 downto 96) <= inReg1(31 downto 0);
                               writeToReg <= '1';
                            elsif (insReg(18 downto 15) = "0111") then
                               maxws(inReg1(31 downto 0),inReg2(31 downto 0),outReg(31 downto 0));
                               maxws(inReg1(63 downto 32),inReg2(63 downto 32),outReg(63 downto 32));
                               maxws(inReg1(95 downto 64),inReg2(95 downto 64),outReg(95 downto 64));
                               maxws(inReg1(127 downto 96),inReg2(127 downto 96),outReg(127 downto 96));
                               writeToReg <= '1';
                            elsif (insReg(18 downto 15) = "1000") then
                               minws(inReg1(31 downto 0),inReg2(31 downto 0),outReg(31 downto 0));
                               minws(inReg1(63 downto 32),inReg2(63 downto 32),outReg(63 downto 32));
                               minws(inReg1(95 downto 64),inReg2(95 downto 64),outReg(95 downto 64));
                               minws(inReg1(127 downto 96),inReg2(127 downto 96),outReg(127 downto 96));
                               writeToReg <= '1';
                            elsif (insReg(18 downto 15) = "1001") then
                               mult(noSignOp,inReg1(15 downto 0),inReg2(15 downto 0),oT);
                               outreg(31 downto 0) <= oT;
                               mult(noSignOp,inReg1(47 downto 32),inReg2(47 downto 32),oT);
                               outreg(63 downto 32) <= oT;
                               mult(noSignOp,inReg1(79 downto 64),inReg2(79 downto 64),oT);
                               outreg(95 downto 64) <= oT;
                               mult(noSignOp,inReg1(111 downto 96),inReg2(111 downto 96),oT);
                               outreg(127 downto 96) <= oT;
                               writeToReg <= '1';
                            elsif (insReg(18 downto 15) = "1010") then
                               MLHCU(noSignOp,inReg1(m - 1 downto 0),insReg(14 downto 10),oT);
                               outreg(31 downto 0) <= oT;
                               MLHCU(noSignOp,inReg1(47 downto a),insReg(14 downto 10),oT);
                               outreg(63 downto 32) <= oT;
                               MLHCU(noSignOp,inReg1(79 downto 64),insReg(14 downto 10),oT);
                               outreg(95 downto 64) <= oT;
                               MLHCU(noSignOp,inReg1(111 downto 96),insReg(14 downto 10),oT);
                               outreg(127 downto 96) <= oT;
                               writeToReg <= '1';
                            elsif (insReg(18 downto 15) = "1011") then
                               outReg <= inReg1 or inReg2;
                               writeToReg <= '1';
                            elsif (insReg(18 downto 15) = "1100") then
                               PCNTW(inReg1(31 downto 0),outReg(31 downto 0));
                               PCNTW(inReg1(63 downto 32),outReg(63 downto 32));
                               PCNTW(inReg1(95 downto 64),outReg(95 downto 64));
                               PCNTW(inReg1(127 downto 96),outReg(127 downto 96));
                               writeToReg <= '1';
                            elsif (insReg(18 downto 15) = "1101") then
                               ROTW(inReg1(31 downto 0),inReg2(31 downto 0),oT);
                               outReg(31 downto 0) <= oT;
                               ROTW(inReg1(63 downto 32),inReg2(63 downto 32),oT);
                               outReg(63 downto 32) <= oT;
                               ROTW(inReg1(95 downto 64),inReg2(95 downto 64),oT);
                               outReg(95 downto 64) <= oT;
                               ROTW(inReg1(127 downto 96),inReg2(127 downto 96),oT);
                               outReg(127 downto 96) <= oT;
                               writeToReg <= '1';
                            elsif (insReg(18 downto 15) = "1110") then
                               t := inReg1(31 downto 0);
                               sub(noSignOp,inReg2(31 downto 0),t,oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(31 downto 0) <= oT;
                               t := inReg1(63 downto 32);
                               sub(noSignOp,inReg2(63 downto 32),t,oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(63 downto 32) <= oT;
                               t := inReg1(95 downto 64);
                               sub(noSignOp,inReg2(95 downto 64),t,oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(95 downto 64) <= oT;
                               t := inReg1(127 downto 96);
                               sub(noSignOp,inReg2(127 downto 96),t,oT);
                               Tempout <= oT;
                               sat_int(Tempout,oT);
                               outreg(127 downto 96) <= oT;
                               writeToReg <= '1';
                            elsif (insReg(18 downto 15) = "1111") then
                               t_half := inReg1(15 downto 0);
                               sub_half(signOp,inReg2(15 downto 0),t_half,oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(15 downto 0) <= oT_half;
                               t_half := inReg1(31 downto 16);
                               sub_half(signOp,inReg2(31 downto 16),t_half,oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(31 downto 16) <= oT_half;
                               t_half := inReg1(47 downto 32);
                               sub_half(signOp,inReg2(47 downto 32),t_half,oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(47 downto 32) <= oT_half;
                               t_half := inReg1(63 downto 48);
                               sub_half(signOp,inReg2(63 downto 48),t_half,oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(63 downto 48) <= oT_half;
                               t_half := inReg1(79 downto 64);
                               sub_half(signOp,inReg2(79 downto 64),t_half,oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(79 downto 64) <= oT_half;
                               t_half := inReg1(95 downto 80);
                               sub_half(signOp,inReg2(95 downto 80),t_half,oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(95 downto 80) <= oT_half;
                               t_half := inReg1(111 downto 96);
                               sub_half(signOp,inReg2(111 downto 96),t_half,oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               outreg(111 downto 96) <= oT_half;
                               t_half := inReg1(127 downto 112);
                               sub_half(signOp,inReg2(127 downto 112),t_half,oT_half);
                               tempout_half <= oT_half;
                               sat_half(tempout_half,oT_half);
                               writeToReg <= '1';
                            end if;
                         end if r3;
                       end process;
                      

end alu;
