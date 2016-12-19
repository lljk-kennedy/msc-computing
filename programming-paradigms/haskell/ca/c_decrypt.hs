-- Course:			Programming Paradigms - DT228B1
-- 					Assignment 3 - Haskell
-- Due Date: 		21st December 2016
--
-- Student: 		Iain Breen
-- Student Number:	D07112248

-- **************************   CA Question 4    *****************************
--
-- Problem:				b. Write a function c_decrypt that takes a string of 
--						small letters and spaces , an integer positive number 
--						and return the same string decrypted using a Ceasar 
--						cypher
--						c_decrypt "vjku ku c vgzv" 2 = “this is a text”
--
-- Solution: 			First, create two functions to convert to and from 
--						chars to int, getting the delta from 'a' in each one.
--						Need to also create a function to detect if a char is
--						a space. We can then rotate the text by checking if
-- 						the char is alpha, and if so, convert the car to an int and
--						add the rotation value, then use mod to get the remainder
--						over 26 to rotate back from the start of the alphabet.
--						To encrypt, we build a new string by rotating each char.
--						To decrypt, we simply invert the rotVal to go backwards
--						by that value.
-- 
-- Example:				ghc --make c_decrypt.hs
--						./c_decrypt [rotationValue] < [EncryptedTextFile] > [DecryptedTextFile]
--						i.e
--						./c_decrypt 10 < q5textENC.txt > q5textDEC.txt

import Data.Char
import System.Environment

charToInt				:: Char -> Int
charToInt char 			= ord char - ord 'a'

intToChar 				:: Int -> Char
intToChar intVal 		= chr (ord 'a' + intVal)


rotate 					:: Char -> Int -> Char
rotate char intVal 		| isAlpha char = intToChar ((charToInt char + intVal) `mod` 26)
						| otherwise = char

c_decrypt 				:: String -> Int -> String
c_decrypt text rotVal	= [rotate char (-1 * rotVal) | char <- text]

main = do
	[arg1] <- getArgs
	contents <- getContents
	putStrLn $ c_decrypt contents (read arg1::Int)
