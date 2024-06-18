:- use_module(library(clpfd)).
:- use_module(library(statistics)).

% Função principal que encontra e exibe o maior tamanho de quadrado latino que pode ser calculado em menos de 1 minuto
main :-
    find_max_n(1, 30, MaxN),
    format('Maior tamanho de quadrado latino calculado em menos de 1 minuto: ~d~n', [MaxN]),
    halt.

% Encontra o maior tamanho N de quadrado latino entre Lower e Upper que pode ser resolvido em menos de 1 minuto
find_max_n(Lower, Upper, MaxN) :-
    find_max_n_helper(Lower, Upper, -1, MaxN).

find_max_n_helper(Current, Upper, MaxSoFar, MaxN) :-
    ( Current > Upper ->
        MaxN = MaxSoFar
    ; 
        ( test_latin_square(Current) ->
            format('Quadrado latino de tamanho ~d calculado com sucesso~n', [Current]),
            NewMaxSoFar is Current
        ;
            NewMaxSoFar = MaxSoFar
        ),
        Next is Current + 1,
        find_max_n_helper(Next, Upper, NewMaxSoFar, MaxN)
    ).

% Testa a resolução de um quadrado latino de tamanho N e mede o tempo de execução
test_latin_square(N) :-
    catch(call_with_time_limit(60, solve_latin_square(N)), time_limit_exceeded, fail).

% Resolve um quadrado latino de tamanho N
solve_latin_square(N) :-
    latin_square(N, Square),
    print_square(Square).

% Gera um quadrado latino de tamanho N
latin_square(N, Square) :-
    length(Square, N),
    maplist(same_length(Square), Square),
    append(Square, Vars),
    Vars ins 1..N,
    maplist(all_distinct, Square),
    transpose(Square, Columns),
    maplist(all_distinct, Columns),
    maplist(label, Square).

% Imprime o quadrado latino
print_square([]).
print_square([Row|Rows]) :-
    writeln(Row),
    print_square(Rows).

% Entry point
:- initialization(main).
