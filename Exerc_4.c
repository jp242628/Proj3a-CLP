#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Função para trocar dois elementos
void trocar(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

// Função para gerar permutações usando backtracking
void permutar(int *arr, int l, int r, unsigned long long *contagem) {
    if (l == r) {
        (*contagem)++;
    } else {
        for (int i = l; i <= r; i++) {
            trocar(&arr[l], &arr[i]);
            permutar(arr, l + 1, r, contagem);
            trocar(&arr[l], &arr[i]); // backtrack
        }
    }
}

// Função para medir o tempo de execução e contar permutações
unsigned long long contar_permutacoes(int n) {
    int *arr = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        arr[i] = i + 1;
    }
    unsigned long long contagem = 0;
    permutar(arr, 0, n - 1, &contagem);
    free(arr);
    return contagem;
}

int main() {
    int n = 2;
    clock_t inicio, fim;
    double tempo_gasto;

    while (1) {
        printf("Testando n = %d...\n", n);
        inicio = clock();
        contar_permutacoes(n);
        fim = clock();
        tempo_gasto = ((double)(fim - inicio)) / CLOCKS_PER_SEC * 1000; // tempo em ms

        printf("Tempo para n = %d: %f ms\n", n, tempo_gasto);

        if (tempo_gasto >= 60000) { // 1 minuto = 60000 ms
            printf("Máximo n para o qual as permutações podem ser calculadas em menos de 1 minuto: %d\n", n - 1);
            break;
        }

        n++;
    }

    return 0;
}
