/*
Name : Avijit Mandal
Roll : 18CS30010
Assignment : 2
Date : 17/09/2020
*/
#include "toylib.h"
#define DEFAULT  0;
int main(){

	int i ,choice,exit=0;
	float f;
	i = DEFAULT ;
	f = DEFAULT ;
	while(1){

		printStringUpper("\n$$$$$$$$$$$$$$$$$$ please enter your choice no: $$$$$$$$$$$$$$$$$$\n");
		printStringUpper("\n1.Read a Hex_Integer\n2.Print the hex_integer\n3.read a float\n4.print the float\n");
		readHexInteger(&choice);

		if(choice ==  1){
			if(readHexInteger(&i)==BAD)
				printStringUpper("\nbad input :(\n");
			else
				printStringUpper("\ninteger noted :)\n");
		}
		else if(choice == 2){
			printHexInteger(i);
		}
		else if(choice == 3){
			if(readFloat(&f)==BAD)
				printStringUpper("\nbad input :(\n");
			else
				printStringUpper("\nfloat noted :)\n");
		}
		else if(choice == 4){
			printFloat(f);
		}
		else printStringUpper("\nplease give a valid choice\n");

		printStringUpper("\n############## 1-->continue or 0-->exit ##############\n");
		readHexInteger(&exit);
		if(exit==0){
			printStringUpper("\nExiting...\n");
			break;
		}

	}



}