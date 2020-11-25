/*
Name: Avijit Mandal
Roll : 18CS30010
Date : 25/09/2020
Asignment3: Lexer For tinyC Language
*/
%{
	#define KEYWORD 			1
	#define IDENTIFIER 			2
	#define CONSTANT 			3
	#define STRING_LITERAL 		4
	#define PUNCTUATOR 			5
	#define COMMENT 			6
	#define COMMENT_ERROR 		7
	#define ESCAPE_SEQUENCE 	8
%}

/*///////////////////////////////	Grammer for tinyC	//////////////////////////////*/

KEYWORD 			        "break"|"float"|"static"|"case"|"for"|"struct"|"char"|"goto"|"switch"|"continue"|"if"|"typedef"|"default"|"int"|"union"|"do"|"long"|"void"|"double"|"return"|"while"|"else"|"short"|"extern"|"sizeof"
IDENTIFIER 					{IDENTIFIER_NONDIGIT}({IDENTIFIER_NONDIGIT}|{DIGIT})*
IDENTIFIER_NONDIGIT 		[a-zA-Z_]
DIGIT						[0-9]
ZERO 						0
CONSTANT					{INTEGER_CONSTANT}|{FLOATING_CONSTANT}|{CHARACTER_CONSTANT}
INTEGER_CONSTANT 			0|{NON_ZERO_DIGIT}{DIGIT}*
NON_ZERO_DIGIT				[1-9]
FLOATING_CONSTANT 			({FRACTIONAL_CONSTANT}{EXPONENT_PART}?)|({DIGIT}+{EXPONENT_PART})
FRACTIONAL_CONSTANT 		(({DIGIT}+)?\.{DIGIT}+)|(({DIGIT}+)\.)
EXPONENT_PART				([eE][-+]?{DIGIT}+)
SIGN						[-+]
CHARACTER_CONSTANT 			'({C_CHAR})+'
C_CHAR 						[^'\\\n]|{ESCAPE_SEQUENCE}
ESCAPE_SEQUENCE				\\['"?\\abfnrtv]
STRING_LITERAL 					\"({S_CHAR}+)\"
S_CHAR 						[^"\\\n]|{ESCAPE_SEQUENCE}
PUNCTUATOR					"["|"]"|"("|")"|"{"|"}"|"."|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"|"?"|":"|";"|"..."|"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|="|","|"#"
LONG_COMMENT_BEGIN				"/*"
SHORT_COMMENT 				"//".*


%%
{KEYWORD}					{ return KEYWORD; }
{IDENTIFIER}				{ return IDENTIFIER; }
{CONSTANT}					{ return CONSTANT; }
{STRING_LITERAL} 			{ return STRING_LITERAL; }
{PUNCTUATOR}				{ return PUNCTUATOR; }
{LONG_COMMENT_BEGIN}		{ 	
								char a;
								char prev = 'a';
								while ((a = input()) != EOF) {
									if (prev == '*' && a == '/')
										return COMMENT;
									prev = a;
								}
								return COMMENT_ERROR;
							}
{SHORT_COMMENT} 	   		{ return COMMENT; }
{ESCAPE_SEQUENCE} 			{ return ESCAPE_SEQUENCE; }
.							/* ignore */
%%






