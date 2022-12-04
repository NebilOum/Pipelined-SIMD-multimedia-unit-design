#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <bitset>
#include <sstream>
using namespace std;
int l = 0;
vector<string> splitStrings(string str, char dl)
{
    string word = "";
    int num = 0;
    str = str + dl;

    l = (int)str.size();
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
    ofstream exp("expected_output.txt");
    string Fword, LI, opcode, reg1, reg2, reg3, immediate, regdes;


    //string in;
    //int i = 0;
    stringstream s;
    int convert;
    int z = 0;
    vector<string> splitt;
    vector<string> instructionArray;
    string end;
    int n, newVal = 0;
    do {
        
        getline(myfile, end);
        //cout << end;
        //outp << end << endl;
        splitt = splitStrings(end, ' ');
        Fword = splitt[0];
        for (int i = 0; i < Fword.size(); i++) {
            Fword[i] = tolower(Fword[i]);
        }

        if (Fword == "li") {
            n = 0;
            convert = 0;

            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = (int)(splitt[1][i])-48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == (splitt[1].size()) - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == (splitt[2].size()) - 1) LI = bitset<3>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == (splitt[3].size()) - 1) immediate = bitset<16>(convert).to_string();
            }
            opcode = "0" + LI + immediate + regdes;
            outp << opcode << endl;
        }// end of li instructions
        //start of r4 instructions
        if (Fword == "simals") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg3 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[4].size(); i++) {
                if (isdigit(splitt[4][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[4][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[4].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "10000" + reg3 + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "simahs") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg3 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[4].size(); i++) {
                if (isdigit(splitt[4][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[4][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[4].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "10001" + reg3 + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "simsls") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg3 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[4].size(); i++) {
                if (isdigit(splitt[4][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[4][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[4].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "10010" + reg3 + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "simshs") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg3 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[4].size(); i++) {
                if (isdigit(splitt[4][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[4][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[4].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "10011" + reg3 + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "slmals") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg3 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[4].size(); i++) {
                if (isdigit(splitt[4][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[4][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[4].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "10100" + reg3 + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "slmahs") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg3 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[4].size(); i++) {
                if (isdigit(splitt[4][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[4][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[4].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "10101" + reg3 + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "slmsls") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg3 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[4].size(); i++) {
                if (isdigit(splitt[4][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[4][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[4].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "10110" + reg3 + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "slmshs") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg3 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[4].size(); i++) {
                if (isdigit(splitt[4][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[4][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[4].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "10111" + reg3 + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        ////////////////////////////////// end of r4 instructions 
        //start of r3 instructions 
        if (Fword == "nop") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "1111110000" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "clzw") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "1111110001" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "au") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "1111110010" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "ahu") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "1111110011" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "ahs") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "1111110100" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "and") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "1111110101" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "bcw") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "1111110110" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "maxws") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "1111110111" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "minws") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "1111111000" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "mlhu") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "1111111001" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "mlhcu") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "1111111010" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "or") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "1111111011" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "pcntw") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "1111111100" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }

        if (Fword == "rotw") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "1111111101" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }


        if (Fword == "sfwu") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "1111111110" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        if (Fword == "sfhs") {
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[1].size(); i++) {
                if (isdigit(splitt[1][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[1][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[1].size() - 1) regdes = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[2].size(); i++) {
                if (isdigit(splitt[2][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[2][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[2].size() - 1) reg2 = bitset<5>(convert).to_string();
            }
            n = 0;
            convert = 0;
            for (int i = 0; i < splitt[3].size(); i++) {
                if (isdigit(splitt[3][i])) {
                    if (n > 0) convert = convert * 10;
                    newVal = int(splitt[3][i]) - 48;
                    convert = newVal + convert;
                    n++;
                }
                if (i == splitt[3].size() - 1) reg1 = bitset<5>(convert).to_string();
            }
            opcode = "1111111111" + reg2 + reg1 + regdes;
            outp << opcode << endl;
        }
        ///////////////////////////////////////// end if r3 instructons
        instructionArray.push_back(opcode);
        
    } while (!myfile.eof());
    int counter=1;
    for (int t = 0; t < 63; t++) { /// all possible cycles
        exp << "Cycle " << z << ": " << endl; 
        for (int u = t-1; u < t+3; u++) { /// printing 4 cycle group
            if (u <= t and u >= 0) {
                exp << "Instruction at Stage" << counter << ": " << instructionArray[u] << endl;
                counter++;
            }
            else if (u < 0) {
                exp << "Instruction at Stage" << counter << ": " << "UUUUUUUUUUUUUUUUUUUUUUUUU" << endl;
                counter++;
            }
            else if (u > t) {
                exp << "Instruction at Stage" << counter << ": " << "UUUUUUUUUUUUUUUUUUUUUUUUU" << endl;
                counter++;
            }
        }
        z++;
        counter = 1;
        exp << "----------------------------------------------------------" << endl;
    }

} 