/*
Name: Avijit Mandal
Roll : 18CS30010
Date : 25/09/2020
Asignment3: Lexer For tinyC Language
*/

// TEST FILE FOR LEXER //

// KEYWORDS

break
case
char
continue
default
do
double
else
extern
float
for
goto
if
int
long
return
short
sizeof

// IDENTIFIERS

avijit
mandal
test_file
compiler_lab
STU007
STU_006
a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
avijt_18CS30010_mandal

// CONSTANTS

300
30010
0.30010
10E10
10e-10
.30010
300.10

// PUNTUATORS

[ ] ( ) { } . ->
++ -- & * + - ~ !
/ % << >> < > <= >= == != ^ | && ||
? : 
= *= /= %= += -= <<= >>= &= ^= |=

// STRING LITERALS

"string literal"
"avijit mandal third year UG student IIT Kharagpur"
"Flex Specifications: 60 Main function and Makefile: 15 + 5 = 20 Test file: 20"

// THIS is DEMO test FOR short COMMENTS
/* THIS is DEMO test FOR long COMMENTS */

// Normal C Programme for factorial

int fact(int n){
	if(n<=1)
		return n;
	else return n*fact(n-1);
}

