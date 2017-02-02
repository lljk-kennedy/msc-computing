mystery([X], [X]).

mystery([H|T], U) :- not(member(H, T)), mystery(T,L), append([H], L, U).
mystery([H|T], L) :- member(H, T), mystery(T,L).

% mystery([5,3,6,3,7,4,3,5], L)