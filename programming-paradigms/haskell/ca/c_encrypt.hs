-- **************************   CA Question 4    *****************************
--
-- Problem: 			a. Write an Haskell function c_encrypt that takes a 
--						string of small letters and spaces , an integer positive 
--						number and return the same string encrypted with the 
--						Caesar cypher
--						c_encrypt "this is a text" 2 = “vjku ku c vgzv”
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
-- Example:				ghc --make c_encrypt.hs
--						./c_encrypt [rotationValue] < [fileToEncrypt] > [EncryptedTextFile]
--						i.e
--						./c_encrypt 10 < q5text.txt > q5textENC.txt
 

import Data.Char
import System.Environment

charToInt				:: Char -> Int
charToInt char 			= ord char - ord 'a'

intToChar 				:: Int -> Char
intToChar intVal 		= chr (ord 'a' + intVal)
 

rotate 					:: Char -> Int -> Char
rotate char intVal 		| isAlpha char = intToChar ((charToInt char + intVal) `mod` 26)
						| otherwise = char

c_encrypt 				:: String -> Int -> String
c_encrypt text rotVal	= [rotate char rotVal | char <- text]

main = do
	[arg1] <- getArgs
	contents <- getContents
	putStrLn $ c_encrypt contents (read arg1::Int)
