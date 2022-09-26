%{  
   #include <stdio.h>
   #include <stdlib.h>
   #include <string.h>
   #include <errno.h> 
   #include "cgen.h"
   #include  "myparser.tab.h"

   extern int yylex();
   int lineNum = 1;
   
%}

%option yylineno


/* definitions */


%x C_COMMENT

Identifiers [A-Za-z][A-Za-z0-9_]*
Integers [0-9][1-9]*
Floats {Integers}+("."{Integers}+)?([eE][+-]?{Integers})?
DBL_QUOTE ["]?

/* rules */

%%

"/*"            { BEGIN(C_COMMENT); }
<C_COMMENT>"*/" { BEGIN(INITIAL); }
<C_COMMENT>"/*"[\n.]*"*/"

"WHILE"         { printf("WHILE"); return PR_WHILE;}
"IF"		{ printf("IF"); return PR_IF;}
"RETURN"        { printf("RETURN"); return PR_RETURN;}
"BREAK"		{ printf("BREAK"); return PR_BREAK;}
"CONTINUE" 	{ printf("CONTINUE"); return PR_CONT;}
"FOR" 		{ printf("FOR"); return PR_FOR;}
"CHARACTER"	{ printf("CHARACTER"); return PR_CHAR;}
"END"    	{ printf("END"); return PR_END;}
"BEGIN"		{ printf("BEGIN"); return PR_BEGIN;}
"PROGRAM"	{ printf("PROGRAM"); return PROGRAM;}
"FUNCTION" 	{ printf("FUNCTION"); return FUNCTION;}
"VARS" 		{ printf("VARS"); return VARS;}
"STARTMAIN" 	{ printf("STARTMAIN"); return PR_STARTMAIN;}
"ENDMAIN"	{ printf("ENDMAIN"); return PR_ENDMAIN;}
"ENDWHILE" 	{ printf("ENDWHILE"); return PR_ENDWHILE;}
"ENDFOR"     	{ printf("ENDFOR"); return PR_ENDFOR;}
"ENDIF"    	{ printf("ENDIF"); return PR_ENDIF;}
"ELSEIF"	{ printf("ELSEIF"); return PR_ELSEIF;}
"ELSE"		{ printf("ELSE"); return PR_ELSE;}
"THEN" 		{ printf("THEN"); return PR_THEN;}
"CASE"      	{ printf("CASE"); return PR_CASE;}
"DEFAULT"   	{ printf("DEFAULT"); return PR_DEFAULT;}
"SWITCH"    	{ printf("SWITCH"); return PR_SWITCH;}
"ENDSWITCH"   	{ printf("ENDSWITCH"); return PR_ENDSWITCH;}
"END_FUNCTION" 	{ printf("END_FUNCTION"); return END_FUNCTION;}
"PRINT" 	{ printf("PRINT"); return PR_PRINT;}
"TO" 		{ printf("TO"); return PR_TO;}
"STEP" 		{ printf("STEP"); return PR_STEP;}
"STRUCT"   	{ printf("STRUCT"); return STRUCT;}
"ENDSTRUCT"   	{ printf("ENDSTRUCT"); return ENDSTRUCT;}
"TYPEDEF"   	{ printf("TYPEDEF"); return TYPEDEF;}
"INTEGER"       { printf("INTEGER"); return INTEGER;}
"CHAR"    	{ printf("CHAR"); return CHAR;}


"+"		{ printf("+"); return PLUS;}
"-"		{ printf("-"); return SUB;}
"*"		{ printf("*"); return MUL;}
"/"		{ printf("/"); return DIV;}

"=="	        { printf("=="); return DBL_EQUAL;}
">="	        { printf(">="); return GREQUAL;}
"<="		{ printf("<="); return LSEQUAL;}
">"		{ printf(">"); return GRTHAN;}
"<"		{ printf("<"); return LSTHAN;}
"!="		{ printf("!="); return INEQ;}

"and"		{ printf("and"); return AND;}
"&&"		{ printf("&&"); return S_AND;}
"or"		{ printf("or"); return OR;}
"||"		{ printf("||"); return S_OR;}
"not"		{ printf("not"); return NOT;}
"!"		{ printf("!"); return S_NOT;}

";"		{ printf(";"); return SEMICLN;}
"("		{ printf("("); return OPEN_PAR;}
")"		{ printf(")"); return CLOSE_PAR;}
","       	{ printf(","); return COMMA;}
"["       	{ printf("["); return OPEN_BR;}
"]"       	{ printf("]"); return CLOSE_BR;}
":"	        { printf(":"); return CLN;}
"="	        { printf("="); return EQUAL;}
"{"       	{ printf("{"); return OPEN_HK;}
"}"       	{ printf("}"); return CLOSE_HK;}
[\t]            {}
\n              lineNum++;

{Identifiers} { printf("%s \n", yytext); return IDENTIFIERS;}
{Integers} { printf("%s \n", yytext); return INTEGERS;}
{Floats} { printf("%s \n", yytext); return FLOATS;}
["]? { printf("%s \n", yytext); return DBL_QUOTE;}

[ \r\t]+			/* skip whitespace */
.           { printf("Line %d Lexical Error: Unrecognized literal %s\n", lineNum, yytext); }

%%

int yywrap(){
    return 1;
}