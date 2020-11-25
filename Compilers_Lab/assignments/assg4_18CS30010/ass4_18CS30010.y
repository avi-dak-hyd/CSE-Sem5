/*
Name: Avijit Mandal
Roll : 18CS30010
Date : 10/10/2020
Asignment4: Parser For tinyC Language
*/


%{ 
	#include <string.h>
	#include <stdio.h>
	extern int yylex();
	void yyerror(char *s);
%}

%union { int intval; }

// Punctuators and operators
%token NOT EXCLAMATION HASH PERCENTAGE XOR AND MULTIPLY OPENROUNDBRACKET CLOSEROUNDBRACKET MINUS DECREMENT EQUAL EQUALEQUAL PLUS INCREMENT OPENCURLYBRACKET CLOSECURLYBRACKET OPENSQUAREBRACKET CLOSESQUAREBRACKET OR COLON SEMICOLON COMMA LESSTHAN LEFTSHIFT DOT GREATERTHAN RIGHTSHIFT QUESTIONMARK DIVIDE LESSTHANEQUAL GREATERTHANEQUAL NOTEQUAL POINTER MULTIPLYASSIGN ELLIPSIS DIVIDEASSIGN MODASSIGN ADDASSIGN LEFTSHIFTASSIGN RIGHTSHIFTASSIGN SUBTRACTASSIGN ANDASSIGN XORASSIGN ORASSIGN

// Keywords
%token SIZEOF EXTERN STATIC  VOID CHAR SHORT INT LONG FLOAT DOUBLE CONST RESTRICT VOLATILE INLINE CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN STRUCT UNION TYPEDEF

// Extras 
%token INT_CONSTANT FLOAT_CONSTANT CHARACTER_CONSTANT IDENTIFIER STRING_LITERAL CONSTANT


%start translation_unit

%%

constant : 	
			INT_CONSTANT 
			| FLOAT_CONSTANT  
			| CHARACTER_CONSTANT ;

primary_expression : 
			IDENTIFIER 
			| constant 
			| STRING_LITERAL 
			| OPENROUNDBRACKET expression CLOSEROUNDBRACKET 
			{printf("EXPRESSIONS : PRIMARY_EXPRESSION\n");};

postfix_expression :
			primary_expression 
			| postfix_expression OPENSQUAREBRACKET expression CLOSESQUAREBRACKET 
			| postfix_expression OPENROUNDBRACKET CLOSEROUNDBRACKET 
			| postfix_expression OPENROUNDBRACKET argument_expression_list CLOSEROUNDBRACKET
			| postfix_expression OPENROUNDBRACKET  
			| postfix_expression DOT IDENTIFIER 
			| postfix_expression POINTER IDENTIFIER 
			| postfix_expression INCREMENT 
			| postfix_expression DECREMENT 
			| OPENROUNDBRACKET type_name CLOSEROUNDBRACKET OPENCURLYBRACKET initializer_list CLOSECURLYBRACKET 
			| OPENROUNDBRACKET type_name CLOSEROUNDBRACKET OPENCURLYBRACKET initializer_list COMMA CLOSECURLYBRACKET 
			{printf("EXPRESSIONS : POSTFIX_EXPRESSION\n");};

argument_expression_list :
			assignment_expression 
			| argument_expression_list COMMA assignment_expression 
			{printf("EXPRESSIONS : ARGUMENT_EXPRESSION_LIST\n");};

unary_expression :
			postfix_expression 
			| INCREMENT unary_expression 
			| DECREMENT unary_expression
			| unary_operator cast_expression 
			| SIZEOF unary_expression 
			| SIZEOF OPENROUNDBRACKET type_name CLOSEROUNDBRACKET
			{printf("EXPRESSIONS : UNARY_EXPRESSION\n");};

unary_operator: AND 
			| MULTIPLY 
			| PLUS 
			| MINUS 
			| NOT 
			| EXCLAMATION 
			{printf("EXPRESSIONS : UNARY_OPERATOR\n");};

cast_expression : unary_expression 
			| OPENROUNDBRACKET type_name CLOSEROUNDBRACKET cast_expression 
			{printf("EXPRESSIONS : CAST_EXPRESSION\n");};

multiplicative_expression :
			cast_expression 
			| multiplicative_expression MULTIPLY cast_expression
			| multiplicative_expression DIVIDE cast_expression 
			| multiplicative_expression PERCENTAGE cast_expression
			{printf("EXPRESSIONS : MULTIPLICATIVE_EXPRESSION\n");};

additive_expression : 
			multiplicative_expression 
			| additive_expression PLUS multiplicative_expression 
			| additive_expression MINUS multiplicative_expression 
			{printf("EXPRESSIONS : ADDITIVE_EXPRESSION\n");};

shift_expression :
			additive_expression 
			| shift_expression LEFTSHIFT additive_expression 
			| shift_expression RIGHTSHIFT additive_expression 
			{printf("EXPRESSIONS : SHIFT_EXPRESSION\n");};

relational_expression : 
			shift_expression 
			| relational_expression LESSTHAN shift_expression 
			| relational_expression GREATERTHAN shift_expression 
			| relational_expression LESSTHANEQUAL shift_expression 
			| relational_expression GREATERTHANEQUAL shift_expression 
			{printf("EXPRESSIONS : RELATIONAL_EXPRESSION\n");};

equality_expression :
			relational_expression 
			| equality_expression EQUALEQUAL relational_expression 
			| equality_expression NOTEQUAL relational_expression 
			{printf("EXPRESSIONS : EQUALITY_EXPRESSION\n");};

AND_expression :
			equality_expression 
			| AND_expression AND equality_expression 
			{printf("EXPRESSIONS : AND_EXPRESSION\n");};

exclusive_OR_expression :
			AND_expression 
			| exclusive_OR_expression XOR AND_expression 
			{printf("EXPRESSIONS : EXCLUSIVE_OR_EXPRESSION \n");}; 

inclusive_OR_expression :
			exclusive_OR_expression 
			| inclusive_OR_expression '|' exclusive_OR_expression 
			{printf("EXPRESSIONS : INCLUSIVE_OR_EXPRESSION\n");};

logical_AND_expression : 
			inclusive_OR_expression 
			| logical_AND_expression AND inclusive_OR_expression 
			{printf("EXPRESSIONS : LOGICAL_AND_EXPRESSION\n");};

logical_OR_expression :
			logical_AND_expression 
			| logical_OR_expression OR logical_AND_expression 
			{printf("EXPRESSIONS : LOGICAL_OR_EXPRESSION \n");};

conditional_expression :
			logical_OR_expression 
			| logical_OR_expression QUESTIONMARK expression COLON conditional_expression 
			{printf("EXPRESSIONS : CONDITIONAL_EXPRESSION\n");};

assignment_expression :
			conditional_expression 
			| unary_expression assignment_operator assignment_expression 
			{printf("EXPRESSIONS : ASSIGNMENT_EXPRESSION\n");};

assignment_operator : 
			EQUAL 
			| MULTIPLYASSIGN 
			| DIVIDEASSIGN 
			| MODASSIGN 
			| ADDASSIGN 
			| SUBTRACTASSIGN 
			| LEFTSHIFTASSIGN 
			| RIGHTSHIFTASSIGN 
			| ANDASSIGN 
			| XORASSIGN 
			| ORASSIGN 
			{printf("EXPRESSIONS : ASSIGNMENT_OPERATOR\n");};

expression :
			assignment_expression 
			| expression COMMA assignment_expression 
			{printf("EXPRESSIONS : EXPRESSION\n");};

constant_expression :
			conditional_expression 
			{printf("EXPRESSIONS : CONSTANT_EXPRESSION\n");};

declaration :
			declaration_specifiers SEMICOLON 
			| declaration_specifiers init_declarator_list SEMICOLON 
			{printf("DECLARATIONS : DECLARATION\n");};

declaration_specifiers : 
			storage_class_specifier 
			| storage_class_specifier declaration_specifiers 
			| type_specifier 
			| type_specifier declaration_specifiers 
			| type_qualifier 
			| type_qualifier declaration_specifiers 
			| function_specifier  
			| function_specifier declaration_specifiers 
			{printf("DECLARATIONS : DECLARATION_SPECIFIERS\n");};

init_declarator_list : 
			init_declarator 
			| init_declarator_list COMMA init_declarator 
			{printf("DECLARATIONS : INIT_DECLARATOR_LIST\n");};

init_declarator : 
			declarator 
			| declarator EQUAL initializer 
			{printf("DECLARATIONS : INIT_DECLARATOR\n");};

storage_class_specifier :
			EXTERN 
			| STATIC 
			{printf("DECLARATIONS : STORAGE_CLASS_SPECIFIER\n");};

type_specifier :
			VOID 
			| CHAR 
			| SHORT 
			| INT 
			| LONG 
			| FLOAT 
			| DOUBLE 
			{printf("DECLARATIONS : TYPE_SPECIFIER\n");};

specifier_qualifier_list : 
			type_specifier 
			| type_specifier specifier_qualifier_list 
			| type_qualifier 
			| type_qualifier specifier_qualifier_list 
			{printf("DECLARATIONS : SPECIFIER_QUALIFIER_LIST\n");};


type_qualifier :
			CONST 
			| VOLATILE 
			| RESTRICT 
			{printf("DECLARATIONS : TYPE_QUAIFIER \n");};

function_specifier : 
			INLINE 
			{printf("DECLARATIONS : FUNCTION_SPECIFIER\n");};

declarator : pointer direct_declarator 
			| direct_declarator 
			{printf("DECLARATIONS : DECLARATOR\n");};

direct_declarator : 
			IDENTIFIER 
			| OPENROUNDBRACKET declarator CLOSEROUNDBRACKET 
			| direct_declarator OPENSQUAREBRACKET  type_qualifier_list assignment_expression CLOSESQUAREBRACKET 
			| direct_declarator OPENSQUAREBRACKET  assignment_expression CLOSESQUAREBRACKET 
			| direct_declarator OPENSQUAREBRACKET  type_qualifier_list  CLOSESQUAREBRACKET 
			| direct_declarator OPENSQUAREBRACKET  CLOSESQUAREBRACKET 

			| direct_declarator OPENSQUAREBRACKET STATIC type_qualifier_list assignment_expression CLOSESQUAREBRACKET 
			| direct_declarator OPENSQUAREBRACKET STATIC assignment_expression CLOSESQUAREBRACKET 

			| direct_declarator OPENSQUAREBRACKET type_qualifier_list STATIC assignment_expression MULTIPLY CLOSESQUAREBRACKET 
			| direct_declarator OPENSQUAREBRACKET type_qualifier_list MULTIPLY CLOSESQUAREBRACKET
			| direct_declarator OPENSQUAREBRACKET MULTIPLY CLOSESQUAREBRACKET
			| direct_declarator OPENROUNDBRACKET parameter_type_list CLOSEROUNDBRACKET 
			| direct_declarator OPENROUNDBRACKET identifier_list CLOSEROUNDBRACKET 
			| direct_declarator OPENROUNDBRACKET CLOSEROUNDBRACKET 
			{printf("DECLARATIONS : DIRECT_DECLARATOR\n");};

pointer : 	
			MULTIPLY 
			| MULTIPLY type_qualifier_list 
			| MULTIPLY pointer 
			| MULTIPLY type_qualifier_list pointer 
			{printf("DECLARATIONS : POINTER\n");};

type_qualifier_list :
			type_qualifier 
			| type_qualifier_list type_qualifier 
			{printf("DECLARATIONS : TYPE_QUALIFIER_LIST\n");};

parameter_type_list : 
			parameter_list 
			| parameter_list COMMA ELLIPSIS 
			{printf("DECLARATIONS : PARAMETER_TYPE_LIST\n");};

parameter_list : 
			parameter_declaration 
			| parameter_list COMMA parameter_declaration 
			{printf("DECLARATIONS : PARAMETER_LIST\n");};

parameter_declaration : 
			declaration_specifiers declarator 
			| declaration_specifiers 
			{printf("DECLARATIONS : PARAMETER_DECLARATION\n");};

identifier_list: IDENTIFIER 
			| identifier_list COMMA IDENTIFIER 
			{printf("DECLARATIONS : IDENTIFIER_LIST\n");};

type_name : 
			specifier_qualifier_list 
			{printf("DECLARATIONS : TYPE_NAME\n");};

initializer : 
			assignment_expression 
			| OPENCURLYBRACKET initializer_list CLOSECURLYBRACKET 
			| OPENCURLYBRACKET initializer_list COMMA CLOSECURLYBRACKET
			{printf("DECLARATIONS : INITIALIZER\n");};

initializer_list : 
			designation initializer 
			| initializer 
			| initializer_list COMMA initializer 
			| initializer_list COMMA designation initializer 
			{printf("DECLARATIONS : INITIALIZER_LIST\n");};

designation :
			designator_list EQUAL 
			{printf("DECLARATIONS : DESIGNATION\n");};

designator_list :
			designator 
			| designator_list designator 
			{printf("DECLARATIONS : DESIGNATOR_LIST\n");};

designator : 
			OPENSQUAREBRACKET constant_expression CLOSESQUAREBRACKET 
			| DOT IDENTIFIER 
			{printf("DECLARATIONS : DESIGNATOR\n");};

statement : 
			labeled_statement 
			| compound_statement 
			| expression_statement 
			| selection_statement 
			| iteration_statement 
			| jump_statement 
			{printf("STATEMENTS : STATEMENT\n");} ;

labeled_statement : 
			IDENTIFIER COLON statement 
			| CASE constant_expression COLON statement 
			| DEFAULT COLON statement 
			{printf("STATEMENTS : LABELED_STATMENT\n");};

compound_statement : 
			OPENCURLYBRACKET CLOSECURLYBRACKET 
			| OPENCURLYBRACKET block_item_list CLOSECURLYBRACKET 
			{printf("STATEMENTS : COMPOUND_STATEMENT\n");};

block_item_list : 
			block_item 
			| block_item_list block_item 
			{printf("STATEMENTS : BLOCK_ITEM_LIST\n");};

block_item : 
			declaration 
			| statement 
			{printf("STATEMENTS : BLOCK_ITEM\n");};

expression_statement : 
			expression SEMICOLON
			| SEMICOLON 
			{printf("STATEMENTS : EXPRESSION_STATEMENT\n");};

selection_statement : 
IF OPENROUNDBRACKET expression CLOSEROUNDBRACKET statement 
			| IF OPENROUNDBRACKET expression CLOSEROUNDBRACKET statement ELSE statement 
			| SWITCH OPENROUNDBRACKET expression CLOSEROUNDBRACKET statement 
			{printf("STATEMENTS : SELECTION_STATEMENT\n");};

iteration_statement : 
			WHILE OPENROUNDBRACKET expression CLOSEROUNDBRACKET statement 
			| DO statement WHILE OPENROUNDBRACKET expression CLOSEROUNDBRACKET SEMICOLON 
			| FOR OPENROUNDBRACKET expression_statement expression_statement CLOSEROUNDBRACKET statement 
			| FOR OPENROUNDBRACKET expression_statement expression_statement expression CLOSEROUNDBRACKET statement 
			{printf("STATEMENTS : ITERATION_STATEMENT\n");};

jump_statement :
			GOTO IDENTIFIER SEMICOLON 
			| CONTINUE SEMICOLON 
			| BREAK SEMICOLON 
			| RETURN SEMICOLON 
			| RETURN expression SEMICOLON 
			{printf("STATEMENTS : JUMP_STATEMENT\n");} ;

translation_unit : 
			external_declaration 
			| translation_unit external_declaration 
			{printf("EXTERNAL DEFINITIONS : TRANSLATION_UNIT\n");};

external_declaration : 
			function_definition 
			| declaration 
			{printf("EXTERNAL DEFINITIONS : EXTERNAL_DECLARATION\n");};

function_definition : 
			declaration_specifiers declarator declaration_list compound_statement 
			| declaration_specifiers declarator compound_statement 
			| declarator declaration_list compound_statement 
			| declarator compound_statement 
			{printf("EXTERNAL DEFINITIONS : FUNCTION_DEFINITION\n");};

declaration_list : 
			declaration 
			| declaration_list declaration 
			{printf("EXTERNAL DEFINITIONS : DECLARATION LIST\n");};

%%

void yyerror(char *s) {
	printf ("ERROR IS : %s",s);
}
