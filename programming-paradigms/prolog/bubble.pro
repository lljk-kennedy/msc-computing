%find the minimum of a list of numbers
min_list([Min],Min).                 % We've found the minimum

min_list([H,K|T],M) :-
    H =< K,                             % H is less than or equal to K
    min_list([H|T],M).               % so use H

min_list([H,K|T],M) :-
    H > K,                              % H is greater than K
    min_list([K|T],M).               % so use K

min_trip([Trip1|Trip1CostValue] , [Trip2|Trip2CostValue]) :-
	

list_min([Trip|OtherTrips], Trip, Min) :-
	list_min(OtherTrips, Trip, Min).

list_min([], Min, Min).

list_min([Trip|OtherTrips], Min0, Min) :-
	Min1 is min_trip(Trip, Min0),
	list_min(OtherTrips, Min1, Min).
	

%remove an element from a list
remove_el([],X,[]).
remove_el([H|T],X,T) :- H = X.
remove_el([H|T],X,[H|R1]) :- H =\= X, remove_el(T,X,R1).

%sort a list
bubble([],[]).
bubble([X],[X]).   %this rule is actually redundant, it can be removed
bubble(L,[M|SLS]) :- min_list(L,M), remove_el(L,M,LS), bubble(LS,SLS).


trips(Airport, [HeadAirport|RestOfAirports], DestAirports, [Trip|TripList]) :-
	%% write('Airport: '), write(Airport), nl(),
	%% write('HeadAirport: '), write(HeadAirport), nl(),
	trip(Airport, HeadAirport, Trip),
	%write('Trip: '), write(Trip), nl(),
	not(member(HeadAirport, DestAirports)),
	trips(Airport, RestOfAirports, [HeadAirport|DestAirports], TripList).