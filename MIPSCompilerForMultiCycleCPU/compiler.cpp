#include <iostream>
#include <bitset>
#include <stdio.h>
#include <string>
#include <fstream>
#include <sstream>
using namespace std;

const string ADD_OP = "000000";
const string SUB_OP = "000001";
const string ADDI_OP = "000010";
const string OR_OP = "010000";
const string AND_OP = "010001";
const string ORI_OP = "010010";
const string SLL_OP = "011000";
const string SLT_OP = "100110";
const string SLTIU_OP = "100111";
const string SW_OP = "110000";
const string LW_OP = "110001";
const string BEQ_OP = "110100";
const string BLTZ_OP = "110110";
const string J_OP = "111000";
const string JR_OP = "111001";
const string JAL_OP = "111010";
const string HALT_OP = "111111";

string readIns(const char *insC_Str) {
	char opC_Str[8];
	// read the opeation
	sscanf(insC_Str, "%s", opC_Str);
	int rs, rt, rd, immediate, sa, addr;
	string outputStrBin;
	string opStr(opC_Str);
	// 1 2 4 5 8
	if (opStr == "add" || opStr == "sub" || opStr == "or" || opStr == "and" || opStr == "slt") {
		sscanf(insC_Str, "%s $%d, $%d, $%d", opC_Str, &rd, &rs, &rt);
		printf("%s %d %d %d\n", opC_Str, rd, rs, rt);

		if (opStr == "add")
			outputStrBin = ADD_OP;
		else if (opStr == "sub")
			outputStrBin = SUB_OP;
		else if (opStr == "or")
			outputStrBin = OR_OP;
		else if (opStr == "and")
			outputStrBin = AND_OP;
		else if (opStr == "slt")
			outputStrBin = SLT_OP;

		outputStrBin += bitset<5>(rs).to_string() 
					  + bitset<5>(rt).to_string()
					  + bitset<5>(rd).to_string()
					  + bitset<11>(0).to_string();	
	}
	// 3 6 9
	else if (opStr == "addi" || opStr == "ori" || opStr == "sltiu") {
		sscanf(insC_Str, "%s $%d, $%d, %d", opC_Str, &rt, &rs, &immediate);
		printf("%s %d %d %d\n", opC_Str, rt, rs, immediate);
		
		if (opStr == "addi")
			outputStrBin = ADDI_OP;
		else if (opStr == "ori")
			outputStrBin = ORI_OP;
		else if (opStr == "sltiu")
			outputStrBin = SLTIU_OP;

		outputStrBin += bitset<5>(rs).to_string() 
				      + bitset<5>(rt).to_string()
				      + bitset<16>(immediate).to_string();		
	}		
	// 7
	else if (opStr == "sll") {
		sscanf(insC_Str, "%s $%d, $%d, %d", opC_Str, &rd, &rt, &sa);
		printf("%s %d %d %d\n", opC_Str, rd, rt, sa);
		outputStrBin += SLL_OP 
				  + bitset<5>(0).to_string() 
				  + bitset<5>(rt).to_string()
				  + bitset<5>(rd).to_string()
				  + bitset<5>(sa).to_string()
				  + bitset<6>(0).to_string();
	}
	// 10 11
	else if (opStr == "sw" || opStr == "lw") {
		sscanf(insC_Str, "%s $%d, %d($%d)", opC_Str, &rt, &immediate, &rs);
		printf("%s %d %d %d\n", opC_Str, rt, immediate, rs);
		outputStrBin += (opStr == "sw") ? SW_OP : LW_OP;
		outputStrBin +=	bitset<5>(rs).to_string() 
				  	  + bitset<5>(rt).to_string()
				      + bitset<16>(immediate).to_string();
	}
	// 12
	else if (opStr == "beq") {
		sscanf(insC_Str, "%s $%d, $%d, %d", opC_Str, &rs, &rt, &immediate);
		printf("%s %d %d %d\n", opC_Str, rs, rt, immediate);
		outputStrBin += BEQ_OP 
				  + bitset<5>(rs).to_string() 
				  + bitset<5>(rt).to_string()
				  + bitset<16>(immediate).to_string();		
	}
	// 13
	else if (opStr == "bltz") {
		sscanf(insC_Str, "%s $%d, %d", opC_Str, &rs, &immediate);
		printf("%s %d %d\n", opC_Str, rs, immediate);
		outputStrBin += BLTZ_OP 
				  + bitset<5>(rs).to_string() 
				  + bitset<5>(0).to_string()
				  + bitset<16>(immediate).to_string();		
	}
	// 14 16
	else if (opStr == "j" || opStr == "jal") {
		sscanf(insC_Str, "%s %x", opC_Str, &addr);
		printf("%s %x\n", opC_Str, addr);
		outputStrBin = (opStr == "j") ? J_OP : JAL_OP;
		outputStrBin += bitset<26>(addr >> 2).to_string();		
	}
	// 15
	else if (opStr == "jr") {
		sscanf(insC_Str, "%s $%d", opC_Str, &rs);
		printf("%s %d\n", opC_Str, rs);
		outputStrBin += JR_OP 
				  + bitset<5>(rs).to_string() 
				  + bitset<21>(0).to_string();	
	}
	// 17
	else if (opStr == "halt") {
		sscanf(insC_Str, "%s", opC_Str);
		printf("%s\n", opC_Str);
		outputStrBin += HALT_OP 
				  + bitset<26>(0).to_string();	
	}
	else {
		cout << "Complie Error: " << opStr << endl;
	}
	return outputStrBin;
}

void printIns(ostream &out, const string outputStrBin) {
	// output Bin
	for (int i = 0; i < outputStrBin.size(); ++i) {
		out << outputStrBin[i];
		if (i != 0 && (i + 1) % 8 == 0)
		//if (i == 5 || i == 10 || i == 15 || i == 19 || i == 23 || i == 27 || i == 31)
			out << " ";
	}
	// output Hex
	unsigned temp = bitset<32>(outputStrBin).to_ulong();
	char outputStrHex_cStr[10];
	sprintf(outputStrHex_cStr, "%08X", temp);
	out << outputStrHex_cStr << endl;
}

int main(int argc, char const *argv[])
{
	int errCount = 0;
	string ins;
	ifstream fin("instructions.asm");
	ifstream finAssert("insAssert.txt");
	ofstream fout("instructionsBin.txt");

	while (getline(fin, ins)) {
		string assertStr, readStr;
		getline(finAssert, readStr);
		stringstream ss(readStr);
		for (int i = 0; i < 7; ++i) {
			ss >> readStr;
			assertStr += readStr;
		}
		string myStr = readIns(ins.c_str());
		if (myStr != assertStr)
			errCount++;
		printIns(fout, myStr);
	}

	cout << "errCount: " << errCount << endl;
	finAssert.close();
	fout.close();
	fin.close();
	return 0;
}