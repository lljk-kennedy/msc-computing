% CA Question 2
% problem: trip(X,Y,T) i.e. a predicate to show the connections from city X to city Y (one by one).
% solution: CityX connects CityA and CityB if there are flights between CityX and CityA, and CityX and CityB
trip(CityA,CityB, [CityA|Path]) :-  canFly(CityA,CityB,[], Path).
canFly(CityA,CityB,Visited,[CityB|Path]) :- flight(CityA,CityB, _, _, _, _) ,  not(member(CityB,Visited)).
canFly(CityA,CityB,Visited,[CityX|Path]) :- flight(CityA,CityX, _, _, _, _) ,  not(member(CityX,Visited)) ,   canFly(CityX,CityB,[CityA|Visited], Path).