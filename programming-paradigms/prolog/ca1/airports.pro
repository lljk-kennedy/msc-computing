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


% CA Question 1
% problem: 	list_airport(X,L) where X (input) is a country and L is a list of all airports in that country.
% solution:	list all city tuples for a specific city. Output all using findall. 
list_airport(Country, List) :- findall(City, country(City, Country), List).

% CA Question 2
% problem: trip(X,Y,T) i.e. a predicate to show the connections from city X to city Y (one by one).
% solution: CityX connects CityA and CityB if there are flights between CityX and CityA, and CityX and CityB
trip(CityA, CityB, [CityA, CityX, CityB]) :- flight(CityA, CityX, _, _, _, _), flight(CityX, CityB, _, _, _, _).

% CA Question 3
% problem: 	all_trip(X,Y,T) i.e. a predicate that returns all the connections (trips) from X to Y and place them in T. Therefore T is a list of lists.
% solution:	Same as above, using findall to put all solutions into a list of lists.
all_trip(CityA, CityB, TripList) :- findall([CityA, CityX, CityB], (flight(CityA, CityX, _, _, _, _), flight(CityX, CityB, _, _, _, _)), TripList).

% CA Question 4
% problem: trip_dist(X,Y,[T,D]) the predicate returns the distance D of each trip T btw city X and Y (one by one).
trip_dist(CityA, CityB, [[CityA, CityX, CityB], TotalDistance]) :- flight(CityA, CityX , _, Distance1, _, _), flight(CityX, CityB, _, Distance2, _, _), TotalDistance is Distance1 + Distance2.

% CA Question 5
% problem: trip_cost(X,Y,[T,C]), same as trip_dist but C is the total cost of the trip
trip_cost(CityA, CityB, [[CityA, CityX, CityB], TotalCost]) :- flight(CityA, CityX , _, _, _, Cost1), flight(CityX, CityB, _, _, _, Cost2), TotalCost is Cost1 + Cost2.


% CA Question 6
% problem:	trip_change(X,Y,[T,I]), same as trip_dist but I is the total number of airplanes changed (=0 for direct connections).
