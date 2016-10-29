









% the output L1 is a list with all the elements 
% in L that are less or equal than number N

filter([],_,[]).
filter([H|T],N,S) :- H > N , filter(T,N,S).
filter([H|T],N,[H|S]) :- H =< N , filter(T,N,S).


rev_list([],[]).
rev_list([H|T],L) :- rev_list(T,L1), append(L1 , [H] ,L) .


len_list([],0).
len_list([H|T] ,R) :- len_list(T,R1) , R is R1 + 1.


prod_list([],1).
prod_list([H|T] ,R) :- prod_list(T,R1) , R is H * R1.

sum_list([],0).
sum_list([H|T] ,R) :- sum_list(T,R1) , R is H + R1.


print_list([]).
print_list([H|T]) :- writeln(H), print_list(T).
