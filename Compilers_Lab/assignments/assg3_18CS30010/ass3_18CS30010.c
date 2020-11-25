/*
Name: Avijit Mandal
Roll : 18CS30010
Date : 25/09/2020
Asignment3: Lexer For tinyC Language
*/

#include <stdio.h>

extern char* yytext;

int main() {

  int token;
  while(1){
  	// printf("Please Enter stream of CHARACTER(s):\n");
  	token = yylex();
  	if(!token){
  		printf("EXITING.....\n");
  		break;
  	}
  	if(token == KEYWORD)
  		printf("< KEYWORD , %s >\n", yytext);
  	else if(token == IDENTIFIER)
  		printf("< IDENTIFIER , %s >\n", yytext);
  	else if(token == CONSTANT)
  		printf("< CONSTANT , %s >\n",yytext );
  	else if(token == STRING_LITERAL)
  		printf("< STRING LITERAL , %s >\n",yytext);
  	else if(token == PUNCTUATOR)
  		printf("< PUNCTUATOR , %s >\n", yytext);
  	else if(token == COMMENT)
  		printf("< COMMENT , %s >\n", yytext);
  	else if(token == COMMENT_ERROR)
  		printf("< ERROR >\n");
  	else if(token == ESCAPE_SEQUENCE)
  		printf("< ESCAPE_SEQUENCE , %s >\n", yytext);
  	else printf("UNDEFINED LANGUAGE\n");
  }
  
}
