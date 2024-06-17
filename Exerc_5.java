import java.util.ArrayList;
import java.util.List;

public class Exerc_5 {

    // Função para trocar dois elementos em um array
    private static void troca(int[] arr, int i, int j) {
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }

    // Função para gerar permutações usando backtracking
    private static void permut(int[] array, int l, int r, List<int[]> permutacoes) {
        if (l == r) {
            permutacoes.add(array.clone());
        } else {
            for (int i = l; i <= r; i++) {
                troca(array, l, i);
                permut(array, l + 1, r, permutacoes);
                troca(array, l, i); // backtrack
            }
        }
    }

    // Função para contar permutações
    private static List<int[]> gerarPermut(int n) {
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) {
            arr[i] = i + 1;
        }
        List<int[]> permutacoes = new ArrayList<>();
        permut(arr, 0, n - 1, permutacoes);
        return permutacoes;
    }

    // Função principal para encontrar o maior N
    public static void main(String[] args) {
        int n = 2;
        long iniTempo, FimTempo;
        long tempoDecorrido;

        while (true) {
            System.out.println("Testando n = " + n + "...");
            iniTempo = System.currentTimeMillis();
            gerarPermut(n);
            FimTempo = System.currentTimeMillis();
            tempoDecorrido = FimTempo - iniTempo;

            System.out.println("Tempo para n = " + n + ": " + tempoDecorrido + " ms");

            if (tempoDecorrido >= 60000) { // 1 minuto = 60000 ms
                System.out.println("Maior n para o qual as permutações podem ser calculadas em menos de 1 minuto: " + (n - 1));
                break;
            }

            n++;
        }
    }
}
