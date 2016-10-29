sum_list([], 0).
sum_list([H|T], R) :- sum_list(T, N), R is H + N.