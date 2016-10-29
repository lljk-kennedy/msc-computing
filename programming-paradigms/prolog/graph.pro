edge(a, b).
edge(a, c).
edge(a, d).
edge(b, e).
edge(c, e).
edge(c, f).
edge(d, f).
edge(f, g).
edge(g, e).
%edge(e, a).

/* no cycle */

path(X,Y) :- edge(X,Y).
path(X,Z) :- edge(X,Y), path(Y,Z).

path(X,Y,1) :- edge(X,Y).
path(X,Z,D) :- edge(X,Y), path(Y,Z,D1), D is D1 + 1.


len_list([], 0).
len_list([_|T], R) :- len_list(T,N), R is N + 1.

print_list([]).
print_list([H|T]) :- writeln(H), print_list(T).

num_paths(A,B,N) :- findall(D, path(A,B,D), R), len_list(R,N).


%show_path displays the path between node X and node Y
show_path(X, Y, [X,Y]) :- edge(X,Y).
show_path(X, Z, [X|T]) :- edge(X,Y), show_path(Y,Z, T).

%list all paths from a to e
% findall((X,Y,C), show_path(X,Y,C), R). print_list(R)

% if cycles are there, this will check if a path exists
pathcyc(A,B) :- walk(A,B,[]).

walk(A,B,V) :- edge(A,B), not(member(B,V)).
walk(A,B,V) :- edge(A,X), not(member(X,V), walk(X,B,[A|V])).
