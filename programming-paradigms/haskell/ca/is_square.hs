-- Course:			Programming Paradigms - DT228B1
-- 					Assignment 3 - Haskell
-- Due Date: 		21st December 2016
--
-- Student: 		Iain Breen
-- Student Number:	D07112248

-- **************************   CA Question 1    *****************************
--
-- Problem: 			Define a function is_square that takes an integer 
--						(positive) and returns True if the number is the square 
--						of an integer number. DO NOT use the SQRT function.
--
-- Solution: 			List comprehension. For each integer from 1 to Val,
--						square it and see if the result == Val; if there is
--						a result, the length of the list should be 1 and so we
--						return the bool of length == 1. Quite inefficient for
--						large squares as it's a brute force approach! 

is_square 			:: Int -> Bool
is_square val		= length [ x*x | x <- [1..val], x*x == val] == 1

-- ***************************************************************************