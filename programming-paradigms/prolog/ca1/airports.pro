% =======================	Knowledgebase	=================================
% flight(city-a,city-b,airline,distance,time,cost)

flight(amsterdam,hongkong,klm,7000,660,750).
flight(amsterdam,paris,airfrance,400,30,100).
flight(amsterdam,dublin,ryanair,1000,90,60).

flight(berlin,moscow,lufthansa,3000,300,900).
flight(berlin,dublin,lufthansa,1200,120,900).

flight(cork,dublin,ryanair,300,50,50).

flight(chicago,dublin,aerlingus,5500,480,890).
flight(chicago,newyork,aa,3000,240,430).

flight(dublin,newyork,aerlingus,4500,360,800).
flight(dublin,cork,ryanair,300,50,50).
flight(dublin,rome,ryanair,2000,150,70).
flight(dublin,chicago,aerlingus,5500,480,890).
flight(dublin,amsterdam,ryanair,1000,90,60).
flight(dublin,london,aerlingus,500,45,150).
flight(dublin,paris,airfrance,600,60,200).
flight(dublin,berlin,lufthansa,1200,120,900).
flight(dublin,sao_paulo,airfrance,10000,900,800).

flight(hongkong,amsterdam,klm,7000,660,750).
flight(hongkong,london,ba,7500,700,1000).
flight(hongkong,moscow,aerflot,5500,420,500).

flight(london,dublin,aerlingus,500,45,150).
flight(london,newyork,ba,5000,700,1100).
flight(london,hongkong,ba,7500,700,1000).
flight(london,rome,ba,1500,150,400).

flight(moscow,newyork,aerflot,9000,720,1000).
flight(moscow,hongkong,aerflot,5500,420,500).
flight(moscow,berlin,lufthansa,3000,300,900).

flight(newyork,chicago,aa,3000,240,430).
flight(newyork,london,ba,5000,700,1100).
flight(newyork,dublin,aerlingus,4500,360,800).
flight(newyork,moscow,aerflot,9000,720,1000).

flight(paris,dublin,airfrance,600,60,200).
flight(paris,amsterdam,airfrance,400,30,100).
flight(paris,rome,airfrance,1200,120,500). 

flight(rio,berlin,lufthansa,11000,1200,1100).

flight(rome,london,ba,1500,150,400).
flight(rome,paris,airfrance,1200,120,500). 
flight(rome,dublin,ryanair,2000,150,70).

flight(sao_paulo,newyork,airfrance,7000,840,650).

country(dublin,ireland).
country(cork,ireland).
country(london,uk).
country(rome,italy).
country(moscow,russia).
country(hongkong,china).
country(amsterdam,holland).
country(berlin,germany).
country(paris,france).
country(newyork,usa).
country(chicago,usa).
country(sao_paulo,brazil).
country(rio,brazil).

% ===========================================================================


% =======================	Helper predicates	=============================

% ===========================================================================


% **************************   CA Question 1    *****************************
%
% Problem: 			list_airport(X,L) where X (input) is a country and L is
%					a list of all airports in that country.
%
% Solution: 		Find all results where the city matches the country

list_airport(Country, List) :- 
	findall(City, country(City, Country), List).

% ***************************************************************************


% **************************   CA Question 2    *****************************
% 
% Problem: 			trip(X,Y,T) i.e. a predicate to show the connections 	
%					from city X to city Y (one by one).
%
% Solution: 		CityX connects CityA and CityB if there are flights 						
%					between CityX and CityA, and CityX and CityB

trip(CityA,CityB, [CityA|Path]) :-
	canFly(CityA,CityB,[], Path).

canFly(CityA,CityB,Visited,[CityB]) :- 
	flight(CityA,CityB, _, _, _, _),  
	not(member(CityB,Visited)).

canFly(CityA,CityB,Visited,[CityX|Path]) :- 
	flight(CityA,CityX, _, _, _, _),  
	not(member(CityX,Visited)),
	canFly(CityX,CityB,[CityA|Visited], Path).

% ***************************************************************************

% **************************   CA Question 3    *****************************
% 
% Problem: 			all_trip(X,Y,T) i.e. a predicate that returns all them 	 
%					connections (trips) from X to Y and place them in T.						
% 					Therefore T is a list of lists.
%
% Solution:			Same as above, using findall to put all solutions into a 
%					list of lists.

all_trip(CityA, CityB, TripList) :- 
	findall(TripList, trip(CityA, CityB, TripList), TripList).

% ***************************************************************************

% **************************   CA Question 4    *****************************
%
% Problem: 			trip_dist(X,Y,[T,D]) the predicate returns the distance 
%					D of each trip T btw city X and Y (one by one).
%
% Solution:			using the path_walk example from class, keep track of the
%					visited cities and calculated the distance travelled as
%					we traverse the graph.

trip_dist(CityA,CityB, [[CityA|Path], TotalDistance]) :-  
	canFlyAndDist(CityA,CityB,[], Path, TotalDistance).

canFlyAndDist(CityA,CityB,Visited,[CityB], TotalDistance) :- 
	flight(CityA,CityB, _, Distance, _, _) ,  
	not(member(CityB,Visited)), 
	TotalDistance is Distance.

canFlyAndDist(CityA,CityB,Visited,[CityX|Path], TotalDistance) :-  
	flight(CityA,CityX, _, Distance1, _, _),  
	not(member(CityX,Visited)),
	canFlyAndDist(CityX,CityB,[CityA|Visited], Path, Distance2),
	TotalDistance is Distance1 + Distance2.

% ***************************************************************************


% **************************   CA Question 5    *****************************
% 
% Problem: 			trip_cost(X,Y,[T,C]), same as trip_dist but C is the 
%					total cost of the trip.
%
% Solution:			Same as CA Question 4 but focusing on Cost

trip_cost(CityA,CityB, [[CityA|Path], TotalCost]) :-  
	canFlyAndCost(CityA,CityB,[], Path, TotalCost).

canFlyAndCost(CityA,CityB,Visited,[CityB], TotalCost) :- 
	flight(CityA,CityB, _, _, _, Cost),  
	not(member(CityB,Visited)),
	TotalCost is Cost.

canFlyAndCost(CityA,CityB,Visited,[CityX|Path], TotalCost) :-  
	flight(CityA,CityX, _, _, _, Cost1) ,  
	not(member(CityX,Visited)),  
	canFlyAndCost(CityX,CityB,[CityA|Visited], Path, Cost2), 
	TotalCost is Cost1 + Cost2.

% ***************************************************************************	

% ********************   N/A - Used for Question 8    ***********************
% 
% Problem: 			trip_time(X,Y,[T,C]), same as trip_dist but C is the 
%					total cost of the trip.
%
% Solution:			Same as CA Question 4 & 5 but focusing on Time

trip_time(CityA,CityB, [[CityA|Path], TotalTime]) :-  
	canFlyAndTime(CityA,CityB,[], Path, TotalTime).

canFlyAndTime(CityA,CityB,Visited,[CityB], TotalTime) :- 
	flight(CityA,CityB, _, _, Time, _),  
	not(member(CityB,Visited)),
	TotalTime is Time.

canFlyAndTime(CityA,CityB,Visited,[CityX|Path], TotalTime) :-  
	flight(CityA,CityX, _, _, Time1, _) ,  
	not(member(CityX,Visited)),  
	canFlyAndTime(CityX,CityB,[CityA|Visited], Path, Time2), 
	TotalTime is Time1 + Time2.

% ***************************************************************************


% **************************   CA Question 6    *****************************
%
% Problem:			trip_change(X,Y,[T,I]), same as trip_dist but I is the 
%					total number of airplanes changed 
% 					(=0 for direct connections).
%
% Solution:			Sames as before, except now we pop the head off the path
%					and calculate the length of the remaining list

% some helper predicates ...
len_list([], 0).
len_list([_|T], R) :- 
	len_list(T,N), R is N + 1.
	
listsplit([H|T], H, T).


trip_change(CityA,CityB, [[CityA|Path], TotalChanges]) :- 
	canFlyAndChange(CityA,CityB,[], Path),
	listsplit(Path, _, Changes),
	len_list(Changes, TotalChanges).

canFlyAndChange(CityA,CityB,Visited,[CityB]) :- 
	flight(CityA,CityB, _, _, _, _),  
	not(member(CityB,Visited)).

canFlyAndChange(CityA,CityB,Visited,[CityX|Path]) :-  
	flight(CityA,CityX, _, _, _, _) ,  
	not(member(CityX,Visited)),  
	canFlyAndChange(CityX,CityB,[CityA|Visited], Path).

% ***************************************************************************


% **************************   CA Question 7    *****************************
%
% Problem:				all_trip_noairline(X,Y,T,A). same as all_trip, 
%						but DISCARD all the trip containing a flight with 
%						airline A (for instance the customer would like to 
% 						flight from rome to dublin avoiding ryanair)
%
% Solution:				This time, we do a NOT check on the airline and
%						don't add the flight to the possible solutions if
%						it contains the Airline we don't want.

trip_noairline(CityA,CityB, [CityA|Path], Airline) :-  
	canFly_noairline(CityA,CityB,[], Path, Airline).

canFly_noairline(CityA,CityB,Visited,[CityB], Airline) :- 
	flight(CityA,CityB, _, _, _, _), 
	not(flight(CityA, CityB, Airline, _, _, _)), 
	not(member(CityB,Visited)).

canFly_noairline(CityA,CityB,Visited,[CityX|Path], Airline) :- 
	flight(CityA,CityX, _, _, _, _),  
	not(member(CityX,Visited)),
	not(flight(CityA, CityX, Airline, _, _, _)),
	canFly_noairline(CityX,CityB,[CityA|Visited], Path, Airline).

all_trip_noairline(CityA, CityB, TripList, Airline) :- 
	findall(TripList, trip_noairline(CityA, CityB, TripList, Airline), TripList).

% ***************************************************************************

% **************************   CA Question 8    *****************************
%
% Problem: 				cheapest(X,Y,T,C) shortest(X,Y,T,C) fastest(X,Y,T,C)
% 						finding the cheapest, shortest, fastest trip T 
%						from city X to city Y. C is the cost,distance 
%						or time.
%
% Solution:				First, we alter the quicksort example from class to
%						to sort based on the costValue (be it time, distance
%						or speed); once this is done, we sort the results of
%						trip_cost, trip_dist and trip_time, split the first 
%						result from the results and then split the Path and
%						CostValue to be returned seperately.

% === quicksort! ===

% We expect a Trip being passed in, in the format 
% [[airport1, ... airportX], CostValue]]. For this sort, we can drop the 
% list of airports using _
lessThan([_|CostA], [_|CostB]) 
	:- CostA =< CostB.

greaterThan([_|CostA], [_|CostB]) 
	:- CostA > CostB.

% root case, return an empty list
divide([], _, [], []).
% if the number is less than the head, add to the lest than list
divide([H|T], N, [H|Less], Greater) :- 
	lessThan(H, N), 
	divide(T, N, Less, Greater).
% if the number is greater than the head, add to the greater than list
divide([H|T], N, Less, [H|Greater]) :- 
	greaterThan(H, N),  
	divide(T, N, Less, Greater).

quicksort([], []).
quicksort([H|T], R) :- 
	divide(T, H, Less, Greater), 
	quicksort(Less, LessSorted), 
	quicksort(Greater, GreaterSorted), 
	append(LessSorted, [H|GreaterSorted], R).


% ==== / quicksort! ===

cheapest(CityA, CityB, Trip, Cost) :-
	findall(ThisTrip, trip_cost(CityA, CityB, ThisTrip), TripList),
	quicksort(TripList, [BestCostTrip|_]),
	listsplit(BestCostTrip, Trip, Cost).

shortest(CityA, CityB, Trip, Cost) :-
	findall(ThisTrip, trip_dist(CityA, CityB, ThisTrip), TripList),
	quicksort(TripList, [BestCostTrip|_]),
	listsplit(BestCostTrip, Trip, Cost).

fastest(CityA, CityB, Trip, Cost) :-
	findall(ThisTrip, trip_time(CityA, CityB, ThisTrip), TripList),
	quicksort(TripList, [BestCostTrip|_]),
	listsplit(BestCostTrip, Trip, Cost).

% ***************************************************************************

% **************************   CA Question 9    *****************************
%
% Problem:			trip_to_nation(X,Y,T) showing all the connections from 
%					airport X to country Y (one by one).
%
% Solution:			Build an all_trips predicate that finds all trips from
%					a city to a list of airports, use findall to get all
%					solutions within, and then iterate over the list in
%					return using member.

all_trips(_, [], []).
all_trips(CityA, [HeadAirport|RestOfAirports], [HeadAirportTrips|RestOfAirportTrips]) :-
	findall(TripC, trip(CityA, HeadAirport, TripC), HeadAirportTrips),
	all_trips(CityA, RestOfAirports, RestOfAirportTrips).

trip_to_nation(OriginCity, DestinationCountry, Trip) :-
	list_airport(DestinationCountry, Airports),
	all_trips(OriginCity, Airports, AllTrips),
	append(AllTrips, SingleTripList),
	member(Trip, SingleTripList).



% ***************************************************************************

% **************************   CA Question 10    ****************************
%
% Problem:			all_trip_to_nation(X,Y,T) Important: to avoid trips with 
%					cycles,such as [rome,paris,rome,london, dublin], keep a 
% 					list of cities already visited for the trip.
%
% Solution:			Assume this is the same as Q3... same result!

all_trip_to_nation(CityA, Country, TripList) :-
	findall(Trip, trip_to_nation(CityA, Country, Trip), TripList).

% ***************************************************************************


