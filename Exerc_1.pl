:- use_module(library(clpfd)).
:- use_module(library(statistics)).

% Função principal que encontra e exibe o maior tamanho de permutação que pode ser calculado em menos de 1 minuto
main :-
    find_max_n(4, 20000, MaxN),
    format('Maior tamanho de permutação calculado em menos de 1 minuto: ~d~n', [MaxN]),
    halt.

% Encontra o maior tamanho N de permutação que pode ser resolvido em menos de 1 minuto
find_max_n(Lower, Upper, MaxN) :-
    find_max_n_helper(Lower, Upper, -1, MaxN).

find_max_n_helper(Current, Upper, MaxSoFar, MaxN) :-
    Current =< Upper,  % Garante que não ultrapasse o limite superior
    ( test_permutation(Current) ->
        format('Permutação de tamanho ~d calculada com sucesso~n', [Current]),
        NewMaxSoFar is Current
    ;
        NewMaxSoFar = MaxSoFar
    ),
    Next is Current + 1,
    ( call_with_time_limit(60, find_max_n_helper(Next, Upper, NewMaxSoFar, MaxN))
    ;   MaxN = MaxSoFar
    ).

% Testa a resolução de uma permutação de tamanho N
test_permutation(N) :-
    solve_permutation(N).

% Resolve uma permutação de tamanho N
solve_permutation(N) :-
    findall(X, between(1, N, X), List),
    perm(List, _).

% Predicado para gerar permutações
perm([], []).
perm(L, [H|T]) :-
    select(H, L, R),
    perm(R, T).

% Entry point
:- initialization(main).
