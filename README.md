# Linguagem de Programação

**Este projeto, desenvolvido por:**

 - Alberto Mansur
 - Bruno Falcão

## Características

- As palavras-chave são invertidas.
- Suporte a variáveis, funções, condicionais, loops e operações aritméticas.
- Exemplo de palavras-chave invertidas:
  - `tni` → `int`
  - `fi` → `if`
  - `esle` → `else`
  - `ftnirp` → `printf`

## Exemplo de Código

Aqui está um exemplo de código que calcula o fatorial de um número usando a linguagem invertida:

```c
tni ralof(tni n) {
    fi (n <= 1) {
        nruter 1;
    } esle {
        nruter n * ralof(n - 1);
    }
}

tni resultado;
resultado = ralof(5);
ftnirp(resultado);
