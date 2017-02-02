count_a([], 0).

count_a([H|T], N) :- member(a, [H]), count_a(T, N), N is N + 1.
count_a([H|T], N) :- not(member(a, [H])), count_a(T, N).

% count_a([f,e,s,q,w,a,r,t,a,a,g], N).

