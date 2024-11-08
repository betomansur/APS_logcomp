%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "invertido.tab.h"

int yywrap(void) { return 1; }
%}

%%

[ \t\n]+               ;
"tni"                  { return DECLARACAO_VAR; }
"diov"                 { return VOID; }
"nruter"               { return RETORNO; }
"fi"                   { return SE; }
"esle"                 { return SENAO; }
"elihw"                { return ENQUANTO; }
"ftnirp"               { return IMPRIMIR; }
"=="                   { return IGUAL; }
"!="                   { return DIFERENTE; }
">="                   { return MAIOR_IGUAL; }
"<="                   { return MENOR_IGUAL; }
">"                    { return MAIOR; }
"<"                    { return MENOR; }
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
","                    { return VIRGULA; }
\"[^\"]*\"             { yylval.identificador = strdup(yytext); return STRING; }
[0-9]+                 { yylval.inteiro = atoi(yytext); return NUMERO; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.identificador = strdup(yytext); return IDENTIFICADOR; }

.                      { printf("Caractere não reconhecido: %s\n", yytext); }

%%
