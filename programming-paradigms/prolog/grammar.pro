% DCG that recognizes a list of a's
as --> [].
as --> [a], as.
% 
% Run by querying
% ?- phrase(as, Ls).

%DCG that recognizes a palindrome 
pal --> [].
pal --> [a].
pal --> [b].
pal --> [b], pal, [b].
pal --> [a], pal, [a].

% keyword to evaluate an expression - 
% phrase(pal, [a,b,a])