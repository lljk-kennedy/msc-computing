-- ghci to load prelude
-- :l test.hs to load the file



--double x 	= x + x
--quadruple x = double (double x)
--factorial n = if n > 0 then product[1..n] else 1

--getFourth list =  head (drop 3 list)
--getNth index list = head (drop (index-1) list)

-- twoSquares x y = (x*x) + (y*y)

-- average list = sum list `div` length list

--isPalindrome list = reverse xs == 

-- For loop
-- x <- [2.5.10], y <- [8, 10, 11]

--pythagoreanTriad x = [(x,y,z) | x <- [1..100], y <- [1..100], z <- [1..x+y], z^2 == x^2 + y^2, y <= x]

-- reverse	:: [Int] -> [Int]

-- map (function, list) i.e map (even, [1,2,3,4,5])
-- output is a list of numbers that satisfy the function

-- map 		:: (Int -> Bool) -> [Int] -> [Int]

-- exercises:

 --count_one 		::	[Int] -> Int
 --count_one ns 	= sum [ x | x <- ns, x == 1 ]


 --count_n 		:: Int -> [Int] -> Int
-- count_n n ns 	= length [ x | x <- ns, x == n 


--second xs = head (tail xs) == [a] -> a
--swap(x,y) == (a,b) -> (b,a)
-- pair x y = (x,y) == a -> b -> (a,b)
-- double x  = x * 2 == 
-- palindrome xs = reverse xs == xs == Equal => [a] -> Bool


type Person = String
type Book = String
type Loan = [(Person, Book)]

loans 		:: Loan

loans		= [("Alice", "TinTin"), ("Anna", "War and Peace"), ("Alice", "Asterix"), ("Rosy", "Macbeth"),  ("Adam", "Macbeth")]


--queries:
-- all the books taken by a specific person
book_by_person	:: 	Person -> [Book]
book_by_person person  = [ y | (x,y) <- loans, x == person ]

-- all the people that took a specific book 
person_by_book	::	Book -> [Person]
person_by_book book = [ x | (x,y) <- loans, y == book ]

-- check if a book is on loan
book_on_loan	:: Book -> Bool
book_on_loan book = if length [ x | (x,y) <- loans, y == book ] > 0  then True else False

-- check the number of book on loan
count_of_book_on_loan :: Book -> Int
count_of_book_on_loan book = length [ x | (x,y) <- loans, y == book ]

-- recursive method to replicate numbers
replicate2				:: Int -> a -> [a]
replicate2 0 _ 			= []
replicate2 n elem 		= [elem] ++ replicate2 (n -1) elem 

-- non recursive method to replicate numbers
replicate3				:: Int -> a -> [a]
replicate3 n elem		= [ elem | _ <- [1..n]] 


-- recursive method to get the power of 2 numbers
power 			:: Int -> Int -> Int
power 0 _		= 1
power _ 0		= 1
power x y 		= x * (power x (y-1))

-- non-recursive method to get the power of 2 numbers
power2			:: Int -> Int -> Int
power2	x y		= product (replicate y x)

add 			:: Int -> Int -> Int
add x y 		= x + y



