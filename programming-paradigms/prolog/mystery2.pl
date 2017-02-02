mystery([], N, []).

mystery([H|T], N, L) :- H<N, mystery(T, N, L).
mystery([H|T], N, L) :- H >=N, mystery(T, N, L1), append([H], L1, L).