% 1) build a predicate to reverse a list
% rev_list(L, LR)

rev_list([], []).
rev_list([H|T], LR) :- rev_list(T, R), append(R, [H], LR). 


% L = [1,2,9,5], LR = [5,9,2,1]


% append(L1, L2, L3) - concetenate lists together

% 2) list an number and the output list
% less_list(L,N,R)

lessThan(A, B) :- A =< B.
greaterThan(A,B) :- A > B.

less_list([], _, []).
less_list([H|T], N, R) :- lessThan(H, N), less_list(T, N, Y),  append(Y, [H], R).
less_list([H|T], N, R) :- greaterThan(H, N), less_list(T, N, R). 


% L = [1,3,3,5,2,9], N = 3, R = [1,3,3,2]


%quicksort ([4,1,2,6,9,5,3]) :- quicksort([2,1,3]) + [4] + quicksort(5,6,9)

% take a list L and divide into two lists, 1 smaller and 1 bigger than N
%divide(L, N, Small, Big)

% root case, return an empty list
divide([], _, [], []).

% if the number is less than the head, add to the lest than list
divide([H|T], N, [H|Less], Greater) :- lessThan(H, N), divide(T, N, Less, Greater).
% if the number is greater than the head, add to the greater than list
divide([H|T], N, Less, [H|Greater]) :- greaterThan(H, N),  divide(T, N, Less, Greater).

quicksort([], []).
quicksort([H|T], R) :- divide(T, H, Less, Greater), quicksort(Less, LessSorted), quicksort(Greater, GreaterSorted), append(LessSorted, [H|GreaterSorted], R).