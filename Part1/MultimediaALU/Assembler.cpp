#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <bitset>
#include <sstream>
using namespace std;

vector<string> splitStrings(string str, char dl)
{
    string word = "";
    int num = 0;
    str = str + dl;

    int l = str.size();
    vector<string> substr_list;
    for (int i = 0; i < l; i++) {

        if (str[i] != dl)
            word = word + str[i];

        else {

            if ((int)word.size() != 0)
                substr_list.push_back(word);

            word = "";
        }
    }
    return substr_list;
}

int main() {
    ifstream myfile("input.txt");

ofstream outp("tb_input.txt");
string Fword, LI, opcode, reg1, reg2, reg3, immediate, regdes;


//string in;
//int i = 0;
stringstream s;
int convert;
while (!myfile.eof()) {
    vector<string> splitt;
    string end;
    int n,newVal;
    getline(myfile, end);
    //cout << end;
    //outp << end << endl;
    splitt=splitStrings(end,' ');
    Fword = splitt[0];
    for (int i = 0; i < Fword.size(); i++) {
        	Fword[i] = tolower(Fword[i]);
        }
       
        if (Fword == "li") {
            n=0;
            convert = 0;
  
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                     if(n > 0) convert = convert * 10;
                     newVal = int(splitt[1][i]);
                     convert = newVal + convert;
                     n++;      
                }
                if(i = splitt[1].size()-1) regdes = bitset<5>(convert).to_string();
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    immediate = bitset<16>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    LI = bitset<3>(convert).to_string();
                }
            }
            opcode = "0" + LI + immediate + regdes;
            outp << opcode << endl;
        }
        if (Fword == "simals") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    reg3 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[4].size(); i++) {
                if (isdigit(splitt[4][i])) {
                    convert = int(splitt[4][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            opcode = "10000" + reg3 + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "simahs") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    reg3 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[4].size(); i++) {
                if (isdigit(splitt[4][i])) {
                    convert = int(splitt[4][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            opcode = "10001" + reg3 + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "simsls") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    reg3 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[4].size(); i++) {
                if (isdigit(splitt[4][i])) {
                    convert = int(splitt[4][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            opcode = "10010" + reg3 + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "simshs") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    reg3 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[4].size(); i++) {
                if (isdigit(splitt[4][i])) {
                    convert = int(splitt[4][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            opcode = "10011" + reg3 + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "slmals") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    reg3 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[4].size(); i++) {
                if (isdigit(splitt[4][i])) {
                    convert = int(splitt[4][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            opcode = "10100" + reg3 + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "slmahs") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    reg3 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[4].size(); i++) {
                if (isdigit(splitt[4][i])) {
                    convert = int(splitt[4][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            opcode = "10101" + reg3 + reg2 + reg1 + regdes; 
            outp << opcode << endl;
        }
        if (Fword == "slmsls") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    reg3 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[4].size(); i++) {
                if (isdigit(splitt[4][i])) {
                    convert = int(splitt[4][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            opcode = "10110" + reg3 + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "slmshs") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    reg3 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[4].size(); i++) {
                if (isdigit(splitt[4][i])) {
                    convert = int(splitt[4][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            opcode = "10111" + reg3 + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "nop") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            opcode = "1111110000" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "clzw") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            opcode = "1111110001" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "au") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            opcode = "1111110010" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "ahu") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            opcode = "1111110011" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "ahs") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            opcode = "1111110100" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "and") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            opcode = "1111110101" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "bcw") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            opcode = "1111110110" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "maxws") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            opcode = "1111110111" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "minws") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            opcode = "1111111000" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "mlhu") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            opcode = "1111111001" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "mlhcu") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            opcode = "1111111010" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "or") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            opcode = "1111111011" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "pcntw") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            opcode = "1111111100" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "rotw") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            opcode = "1111111101" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "sfwu") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            opcode = "1111111110" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "sfhs") {
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    convert = int(splitt[1][i]);
                    regdes = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    convert = int(splitt[2][i]);
                    reg2 = bitset<5>(convert).to_string();
                }
            }
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    convert = int(splitt[3][i]);
                    reg1 = bitset<5>(convert).to_string();
                }
            }
            opcode = "1111111111" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
}
    
	
return 0;
	}