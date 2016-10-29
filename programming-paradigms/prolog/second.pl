male(john).
male(fred).
male(harry).
female(mary).
female(julie).
female(susan).
female(anne).
owns(fred,gold).
owns(john,car). 
owns(julie,gold).
owns(anne,house).
blonde(julie).
blonde(susan).
blonde(john).
brunette(mary).
brunette(anne).
dark(fred).
dark(harry).

/* Rules: */
likes(john,Person) :- female(Person), blonde(Person), rich(Person).

likes(fred,Person) :- female(Person), brunette(Person).

likes(harry,Person) :- female(Person), rich(Person).

likes(mary,Person) :- male(Person), dark(Person).

likes(julie,Person) :- male(Person), dark(Person), rich(Person).

rich(Person) :- owns(Person, gold). /* Family Tree Program */
