% **************************   CA Question 1    *****************************
%
% Problem: 			Print the status of the blocks. You are required to 
%					define a PROLOG predicate print_status to print the status 
%					of the blocks. print_status(B) where B is a list of three 
%					lists describing the three piles of blocks.
% 
% Solution:			Print the status by printing out each stack.

print_status([]).
print_status([Head|Tail]) :- print_stack(Head), print_status(Tail).

print_stack([]) :- writeln('|').
print_stack(([Head|Tail])) :- write('|'), write(Head), print_stack(Tail). 

% ***************************************************************************

