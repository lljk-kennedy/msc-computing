edge(a,b).
edge(a,c).
edge(a,d).
edge(b,e).
edge(c,e).
edge(c,f).
edge(d,f).
edge(f,g).
edge(g,e).
edge(e,a).





/* no cycle */
path(X,Y) :- edge(X,Y).
path(X,Z) :- edge(X,Y), path(Y,Z).


len_list([],0).
len_list([H|T] ,R) :- len_list(T,R1) , R is R1 + 1.

show_path(X,Y,[X,Y]) :- edge(X,Y).
show_path(X,Z,  [X|P1] )  :-  edge(X,Y) , show_path(Y,Z, P1 ) .

print_list([]).
print_list([H|T]) :- writeln(H), print_list(T).

print_all_path(X,Y) :- findall(P, show_path(X,Y,P), R), print_list(R).

pathcyc(A,B) :-  walk(A,B,[]).
walk(A,B,V) :- edge(A,B) ,  not(member(B,V)).
walk(A,B,V) :- edge(A,X) ,  not(member(X,V)) ,   walk(X,B,[A|V]).

