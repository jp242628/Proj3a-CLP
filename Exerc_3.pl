% Predicado para calcular o fatorial de N
factorial(1, 1).
factorial(N, M) :-
    N > 1,
    N1 is N - 1,
    factorial(N1, K),
    M is N * K.

% Predicado para calcular e mostrar os fatoriais até que se passem aproximadamente 59 segundos
calculate_and_print_fatorials :-
    get_time(StartTime), % Obtém o tempo inicial
    calculate_and_print_fatorials(1, StartTime).

% Predicado auxiliar recursivo para calcular e mostrar os fatoriais até que se passem aproximadamente 59 segundos
calculate_and_print_fatorials(N, StartTime) :-
    get_time(CurrentTime), % Obtém o tempo atual
    TimeElapsed is CurrentTime - StartTime,
    TimeElapsed < 59, % Verifica se ainda não se passaram aproximadamente 59 segundos
    (
        factorial(N, Result),
        format('Fatorial de ~d: ~d~n', [N, Result]),
        N1 is N + 1,
        calculate_and_print_fatorials(N1, StartTime)
    ;
        true
    ).

% Exemplo de uso para calcular e mostrar os fatoriais até que se passem aproximadamente 59 segundos
:- initialization(main).

main :-
    calculate_and_print_fatorials,
    halt.
