/*
Name: Avijit Mandal
Roll : 18CS30010
Date : 10/10/2020
Asignment4: Parser For tinyC Language
*/

#include <stdio.h>
#include "y.tab.h"
extern char* yytext;
extern int yyparse();


int main() {
	int token;
	yyparse();
	return 0;  
}
