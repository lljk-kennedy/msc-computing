brother(X,Y) :- parents(X, A, B), parents(Y, A, B), male(Y).

mother(Y, X) :- parents(X, Y, _).

uncle(X, Y) :- ( brother(A, Y) ; brother(B, Y) ), parents(X, B, A).