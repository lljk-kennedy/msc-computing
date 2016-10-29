friend(john, mary).
friend(mary, paul).
friend(mary, karl).
friend(karl, mark).
friend(karl, joe).
friend(joe, alan).
friend(joe, martha).

foaf(X, Y) :- friend(X, Y).
foaf(X, Y) :- friend(X, Z), foaf(Z, Y).

