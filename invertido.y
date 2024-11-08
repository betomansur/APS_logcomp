%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char* s);

extern FILE *yyin;
%}

%union {
    int inteiro;
    char* identificador;
}

%token DECLARACAO_VAR VOID SE SENAO ENQUANTO IMPRIMIR RETORNO
%token IGUAL DIFERENTE MAIOR MENOR MAIOR_IGUAL MENOR_IGUAL
%token SOMA SUB MULT DIV ATRIBUI
%token ABRE_PAR FECHA_PAR ABRE_CHAVE FECHA_CHAVE PONTO_VIRGULA VIRGULA
%token <inteiro> NUMERO
%token <identificador> IDENTIFICADOR STRING
%type <inteiro> expressao termo fator

%start programa

%%

programa:
    lista_declaracoes
    ;

lista_declaracoes:
    /* vazio */
    | lista_declaracoes declaracao
    ;

declaracao:
    variavel
    | atribuicao
    | condicional
    | loop
    | impressao
    | funcao
    | retorno
    | chamada_funcao PONTO_VIRGULA
    ;

variavel:
    DECLARACAO_VAR IDENTIFICADOR PONTO_VIRGULA { printf("Declaracao de variavel: %s\n", $2); }
    ;

atribuicao:
    IDENTIFICADOR ATRIBUI expressao PONTO_VIRGULA { printf("Atribuicao de valor a %s.\n", $1); }
    ;

condicional:
    SE ABRE_PAR expressao condicao expressao FECHA_PAR ABRE_CHAVE programa FECHA_CHAVE { printf("Condicional (if) sem else.\n"); }
    | SE ABRE_PAR expressao condicao expressao FECHA_PAR ABRE_CHAVE programa FECHA_CHAVE SENAO ABRE_CHAVE programa FECHA_CHAVE { printf("Condicional (if-else).\n"); }
    ;

loop:
    ENQUANTO ABRE_PAR expressao condicao expressao FECHA_PAR ABRE_CHAVE programa FECHA_CHAVE { printf("Loop (while).\n"); }
    ;

impressao:
    IMPRIMIR ABRE_PAR expressao FECHA_PAR PONTO_VIRGULA { printf("Impressao (print).\n"); }
    ;

funcao:
    DECLARACAO_VAR IDENTIFICADOR ABRE_PAR parametros FECHA_PAR ABRE_CHAVE programa FECHA_CHAVE { printf("Definicao de funcao %s.\n", $2); }
    ;

parametros:
    /* vazio */
    | parametros_lista
    ;

parametros_lista:
    DECLARACAO_VAR IDENTIFICADOR
    | parametros_lista VIRGULA DECLARACAO_VAR IDENTIFICADOR
    ;

retorno:
    RETORNO expressao PONTO_VIRGULA { printf("Retorno de funcao.\n"); }
    ;

chamada_funcao:
    IDENTIFICADOR ABRE_PAR argumentos FECHA_PAR { printf("Chamada de funcao %s.\n", $1); }
    ;

argumentos:
    /* vazio */
    | argumentos_lista
    ;

argumentos_lista:
    expressao
    | argumentos_lista VIRGULA expressao
    ;

expressao:
    termo
    | expressao SOMA termo { $$ = $1 + $3; printf("Resultado da soma: %d\n", $$); }
    | expressao SUB termo { $$ = $1 - $3; printf("Resultado da subtracao: %d\n", $$); }
    ;

termo:
    fator
    | termo MULT fator { $$ = $1 * $3; printf("Resultado da multiplicacao: %d\n", $$); }
    | termo DIV fator { $$ = $1 / $3; printf("Resultado da divisao: %d\n", $$); }
    ;

fator:
    NUMERO             { $$ = $1; printf("Numero: %d\n", $$); }
    | IDENTIFICADOR    { $$ = 0; printf("Identificador: %s\n", $1); }
    | ABRE_PAR expressao FECHA_PAR { $$ = $2; printf("Expressao entre parenteses.\n"); }
    | chamada_funcao   { $$ = 0; printf("Chamada de funcao em expressao.\n"); }
    ;

condicao:
    IGUAL              { printf("Condicao: igual.\n"); }
    | DIFERENTE        { printf("Condicao: diferente.\n"); }
    | MAIOR            { printf("Condicao: maior.\n"); }
    | MENOR            { printf("Condicao: menor.\n"); }
    | MAIOR_IGUAL      { printf("Condicao: maior ou igual.\n"); }
    | MENOR_IGUAL      { printf("Condicao: menor ou igual.\n"); }
    ;

%%

int main(int argc, char **argv) {
    FILE *file = stdin; // Entrada padrão por padrão
    if (argc > 1) {
        file = fopen(argv[1], "r");
        if (!file) {
            perror("Nao foi possivel abrir o arquivo");
            return 1;
        }
    }
    yyin = file;
    printf("Inicio da analise do programa.\n");
    int resultado = yyparse();
    if (file != stdin) {
        fclose(file);
    }
    return resultado;
}

void yyerror(const char* s) {
    fprintf(stderr, "Erro: %s\n", s);
}
