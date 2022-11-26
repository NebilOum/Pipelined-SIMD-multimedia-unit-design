#include <string>
#include <vector>
#include <iostream>
#include <fstream>
using namespace std;



int main() {

	ifstream myfile;
	myfile.open("input.txt");

    string Fword, LI, opcode, reg1, reg2, reg3, immediate, regdes, end;
    

	//string in;
	

	while (!myfile.eof()) {


		getline(myfile,end,' ');
		Fword = end;
		for (int i = 0; i < Fword.size(); i++) {
			Fword[i] = tolower(Fword[i]);
		}
		if (Fword == "li") {
            opcode = "0" + LI + immediate + regdes;
		}
        if (Fword == "simals") {
            string r = strtok(nullptr, " ");
            opcode = "10000" + reg3 + reg2 + reg1 + regdes;
        }
        if (Fword == "simahs") {
            opcode = "10001" + reg3 + reg2 + reg1 + regdes;
        }

        if (Fword == "simsls") {
            opcode = "10010" + reg3 + reg2 + reg1 + regdes;
        }

        if (Fword == "simshs") {
            opcode = "10011" + reg3 + reg2 + reg1 + regdes;
        }
        if (Fword == "slimas") {
            opcode = "10100" + reg3 + reg2 + reg1 + regdes;
        }

        if (Fword == "slimahs") {
            opcode = "10101" + reg3 + reg2 + reg1 + regdes;
        }
        if (Fword == "SLIMSLS") {
            opcode = "10110" + reg3 + reg2 + reg1 + regdes;
        }
        if (Fword == "SLIMSHS") {
            opcode = "10111" + reg3 + reg2 + reg1 + regdes;
        }
        if (Fword == "nop") {
            opcode = "1111110000" + reg2 + reg1 + regdes;
        }

        if (Fword == "clzw") {
            opcode = "1111110001" + reg2 + reg1 + regdes;
        }
        if (Fword == "au") {
            opcode = "1111110010" + reg2 + reg1 + regdes;
        }

        if (Fword == "ahu") {
            opcode = "1111110011" + reg2 + reg1 + regdes;
        }

        if (Fword == "ahs") {
            opcode = "1111110100" + reg2 + reg1 + regdes;
        }

        if (Fword == "and") {
            opcode = "1111110101" + reg2 + reg1 + regdes;
        }
        if (Fword == "bcw") {
            opcode = "1111110110" + reg2 + reg1 + regdes;
        }
        if (Fword == "maxws") {
            opcode = "1111110111" + reg2 + reg1 + regdes;
        }

        if (Fword == "minws") {
            opcode = "1111111000" + reg2 + reg1 + regdes;
        }

        if (Fword == "mlhu") {
            opcode = "1111111001" + reg2 + reg1 + regdes;
        }

        if (Fword == "mlhcu") {
            opcode = "1111111010" + reg2 + reg1 + regdes;
        }
        if (Fword == "or") {
            opcode = "1111111011" + reg2 + reg1 + regdes;
        }

        if (Fword == "pcntw") {
            opcode = "1111111100" + reg2 + reg1 + regdes;
        }

        if (Fword == "rotw") {
            opcode = "1111111101" + reg2 + reg1 + regdes;
        }

        if (Fword == "sfwu") {
            opcode = "1111111110" + reg2 + reg1 + regdes;
        }
        if (Fword == "sfhs") {
            opcode = "1111111111" + reg2 + reg1 + regdes;
        }
    }




	}