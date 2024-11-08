%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char* s);
%}

%union {
    int inteiro;
    char* identificador;
}

%token DECLARACAO_VAR VOID SE SENAO ENQUANTO IMPRIMIR RETORNO
%token IGUAL DIFERENTE MAIOR MENOR MAIOR_IGUAL MENOR_IGUAL
%token SOMA SUB MULT DIV ATRIBUI
%token ABRE_PAR FECHA_PAR ABRE_CHAVE FECHA_CHAVE PONTO_VIRGULA
%token <inteiro> NUMERO
%token <identificador> IDENTIFICADOR
%type <inteiro> expressao termo fator

%start programa

%%


programa:
    { printf("Início da análise do programa.\n"); }
    | programa declaracao
    ;

declaracao:
    atribuicao
    | condicional
    | loop
    | impressao
    | variavel
    | funcao
    | chamada_funcao PONTO_VIRGULA
    ;

variavel:
    DECLARACAO_VAR IDENTIFICADOR PONTO_VIRGULA { printf("Declaração de variável: %s\n", $2); }
    ;

atribuicao:
    IDENTIFICADOR ATRIBUI expressao PONTO_VIRGULA { printf("Atribuição de valor a %s.\n", $1); }
    ;

condicional:
    SE ABRE_PAR expressao condicao expressao FECHA_PAR ABRE_CHAVE programa FECHA_CHAVE { printf("Condicional (if) sem else.\n"); }
    | SE ABRE_PAR expressao condicao expressao FECHA_PAR ABRE_CHAVE programa FECHA_CHAVE SENAO ABRE_CHAVE programa FECHA_CHAVE { printf("Condicional (if-else).\n"); }
    ;

loop:
    ENQUANTO ABRE_PAR expressao condicao expressao FECHA_PAR ABRE_CHAVE programa FECHA_CHAVE { printf("Loop (while).\n"); }
    ;

impressao:
    IMPRIMIR ABRE_PAR expressao FECHA_PAR PONTO_VIRGULA { printf("Impressão (print).\n"); }
    ;

funcao:
    DECLARACAO_VAR IDENTIFICADOR ABRE_PAR DECLARACAO_VAR IDENTIFICADOR FECHA_PAR ABRE_CHAVE programa retorno FECHA_CHAVE { printf("Definição de função %s.\n", $2); }
    ;

retorno:
    RETORNO expressao PONTO_VIRGULA { printf("Retorno de função com valor: %d\n", $2); }
    ;

chamada_funcao:
    IDENTIFICADOR ABRE_PAR expressao FECHA_PAR { printf("Chamada de função %s.\n", $1); }
    ;

expressao:
    termo  
    | expressao SOMA termo { printf("Soma.\n"); }
    | expressao SUB termo { printf("Subtração.\n"); }
    ;

termo:
    fator
    | termo MULT fator { printf("Multiplicação.\n"); }
    | termo DIV fator { printf("Divisão.\n"); }
    ;

fator:
    NUMERO             { printf("Número: %d\n", $1); $$ = $1; }
    | IDENTIFICADOR    { printf("Identificador: %s\n", $1); $$ = 0; }
    | ABRE_PAR expressao FECHA_PAR { printf("Expressão entre parênteses.\n"); $$ = $2; }
    ;

condicao:
    IGUAL              { printf("Condição: igual.\n"); }
    | DIFERENTE        { printf("Condição: diferente.\n"); }
    | MAIOR            { printf("Condição: maior.\n"); }
    | MENOR            { printf("Condição: menor.\n"); }
    | MAIOR_IGUAL      { printf("Condição: maior ou igual.\n"); }
    | MENOR_IGUAL      { printf("Condição: menor ou igual.\n"); }
    ;

%%


int main() {
    return yyparse();
}

void yyerror(const char* s) {
    fprintf(stderr, "Erro: %s\n", s);
}
