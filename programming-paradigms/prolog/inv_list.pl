inv_list([], []).

inv_list([H|T], N) :-  append([H], N, N), inv_list(T, N).

% inv_list([f,e,s,q,w,a,q], N).