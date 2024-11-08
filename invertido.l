%{
#include "invertido.tab.h"
int yywrap(void) { return 1; }
%}

%% 

[ \t\n]+               ;  // Ignora espaços em branco e novas linhas
"tni"                  { return DECLARACAO_VAR; } // Similar a "int"
"diov"                 { return VOID; }           // Similar a "void"
"nruter"               { return RETORNO; }        // Similar a "return"
"fi"                   { return SE; }             // Similar a "if"
"esle"                 { return SENAO; }          // Similar a "else"
"elihw"                { return ENQUANTO; }       // Similar a "while"
"ftnirp"               { return IMPRIMIR; }       // Similar a "printf"
"=="                   { return IGUAL; }
"!="                   { return DIFERENTE; }
">"                    { return MAIOR; }
"<"                    { return MENOR; }
">="                   { return MAIOR_IGUAL; }
"<="                   { return MENOR_IGUAL; }
"="                    { return ATRIBUI; }
"+"                    { return SOMA; }
"-"                    { return SUB; }
"*"                    { return MULT; }
"/"                    { return DIV; }
"("                    { return ABRE_PAR; }
")"                    { return FECHA_PAR; }
"{"                    { return ABRE_CHAVE; }
"}"                    { return FECHA_CHAVE; }
";"                    { return PONTO_VIRGULA; }
\"[^\"]*\"            { yylval.identificador = strdup(yytext); return IDENTIFICADOR; }  // Reconhece strings entre aspas duplas
[0-9]+                 { yylval.inteiro = atoi(yytext); return NUMERO; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.identificador = strdup(yytext); return IDENTIFICADOR; }

.                      { printf("Caractere não reconhecido: %s\n", yytext); }

%% 
