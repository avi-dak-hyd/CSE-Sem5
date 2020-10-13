/*
Name: Avijit Mandal
Roll : 18CS30010
Date : 10/10/2020
Asignment4: Parser For tinyC Language
*/

%{
	#include "y.tab.h"
	#include <math.h>
	extern void yyerror(const char *);
	void comment (void);

%}

/*///////////////////////////////	Grammer for tinyC	//////////////////////////////*/

IDENTIFIER 					{IDENTIFIER_NONDIGIT}({IDENTIFIER_NONDIGIT}|{DIGIT})*
IDENTIFIER_NONDIGIT 		[a-zA-Z_]
DIGIT						[0-9]
NON_ZERO_DIGIT				[1-9]

CONSTANT					{INTEGER_CONSTANT}|{FLOATING_CONSTANT}|{CHARACTER_CONSTANT}
INTEGER_CONSTANT 			0|{NON_ZERO_DIGIT}{DIGIT}*
FLOATING_CONSTANT 			({FRACTIONAL_CONSTANT}{EXPONENT_PART}?)|({DIGIT}+{EXPONENT_PART})
FRACTIONAL_CONSTANT 		(({DIGIT}+)?\.{DIGIT}+)|(({DIGIT}+)\.)
EXPONENT_PART				([eE][-+]?{DIGIT}+)
CHARACTER_CONSTANT 			'({C_CHAR})+'
C_CHAR 						[^'\\\n]|{ESCAPE_SEQUENCE}
ESCAPE_SEQUENCE				\\['"?\\abfnrtv]
STRING_LITERAL 					\"({S_CHAR}+)\"
S_CHAR 						[^"\\\n]|{ESCAPE_SEQUENCE}

LONG_COMMENT_BEGIN			"/*"
SHORT_COMMENT 				"//".*
%%

{LONG_COMMENT_BEGIN}		{ comment(); }
{SHORT_COMMENT}  	   		{ /* Single line comment */}



"sizeof"        			{ return SIZEOF; }
"extern"        			{ return EXTERN; }
"static"        			{ return STATIC; }
"void"          			{ return VOID; }
"char"          			{ return CHAR; }
"short"         			{ return SHORT; }
"int"           			{ return INT; }
"long"          			{ return LONG; }
"float"         			{ return FLOAT; }
"double"        			{ return DOUBLE; }
"while"         			{ return WHILE; }
"do"            			{ return DO; }
"for"           			{ return FOR; }
"goto"          			{ return GOTO; }
"continue"      			{ return CONTINUE; }
"break"         			{ return BREAK; }
"return"        			{ return RETURN; }
"case"          			{ return CASE; }
"default"       			{ return DEFAULT; }
"if"            			{ return IF; }
"else"          			{ return ELSE; }
"switch"        			{ return SWITCH; }
"struct"					{ return STRUCT; }
"typedef"					{ return TYPEDEF; }
"union"						{ return UNION;	}


"["							{ return OPENSQUAREBRACKET; }
"]"							{ return CLOSESQUAREBRACKET; }
"{"							{ return OPENCURLYBRACKET; }
"}"							{ return CLOSECURLYBRACKET; }
"("							{ return OPENROUNDBRACKET; }
")"							{ return CLOSEROUNDBRACKET; }
"!"							{ return EXCLAMATION; }

"#"							{ return HASH; }
"%"							{ return PERCENTAGE; }
"~"							{ return NOT; }
"^"							{ return XOR; }
"&"							{ return AND; }
"&&"						{ return AND; }
"||"						{ return OR; }

"*"							{ return MULTIPLY; }
"-"							{ return MINUS; }
"+"							{ return PLUS; }
"--"						{ return DECREMENT; }
"++"						{ return INCREMENT; }
"="							{ return EQUAL; }

"=="						{ return EQUALEQUAL; }
"!="						{ return NOTEQUAL; }
"<"							{ return LESSTHAN; }
"<<"						{ return LEFTSHIFT; }
"."							{ return DOT; }
">"							{ return GREATERTHAN; }
">>"						{ return RIGHTSHIFT; }
"?"							{ return QUESTIONMARK; }
"/"							{ return DIVIDE; }
"<="						{ return LESSTHANEQUAL; }
">="						{ return GREATERTHANEQUAL; }
"->"						{ return POINTER; }
"..."						{ return ELLIPSIS; }

"*="						{ return MULTIPLYASSIGN; }
"/="						{ return DIVIDEASSIGN; }
"%="						{ return MODASSIGN; }
"+="						{ return ADDASSIGN; }
"<<="						{ return LEFTSHIFTASSIGN; }
">>="						{ return RIGHTSHIFTASSIGN; }
"-="						{ return SUBTRACTASSIGN; }
"&="						{ return ANDASSIGN; }
"^="						{ return XORASSIGN; }
"|="						{ return ORASSIGN; }

","							{ return COMMA; }
";"							{ return SEMICOLON; }
":"							{ return COLON; }



{STRING_LITERAL} 			{ return STRING_LITERAL; }

{IDENTIFIER}				{ return IDENTIFIER; }
{INTEGER_CONSTANT} 			{ return INT_CONSTANT; }
{FLOATING_CONSTANT} 		{ return FLOAT_CONSTANT; }
{CHARACTER_CONSTANT} 		{ return CHARACTER_CONSTANT; }

.							{ /* whitespace separates tokens */ }

%%

void comment(void) {
	char c;
	char prev = 0;
	while ((c = input()) != 0) {
		if (c == '/' && prev == '*') return;
		prev = c;
	}
	perror("Error in Commenting!");
}
