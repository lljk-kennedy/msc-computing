-- Course:			Programming Paradigms - DT228B1
-- 					Assignment 3 - Haskell
-- Due Date: 		21st December 2016
--
-- Student: 		Iain Breen
-- Student Number:	D07112248 

-- **************************   CA Question 2    *****************************
--
-- Problem: 			Define a function freq_letter_pc, that displays the 
--						percentage of each letter instead of the number of 
--						occurrences (do not count symbols other than [a..z]). 
--						Transform the text in small case first. 
--
-- Example:				freq_letter_pc "this is text"
--						= [(t,0.3),(s,0.2),(i,0.2),(h,0.1),(e,0.1),(x,0.1)]
--
-- Solution: 			This is a hacky one! 
--						First, create_freq_tuple will create the tuple pairs of
--						of char and length by getting the unique letters in the
--						string using nub, filtering on alpha chars only and then
--						also calcuating the length of the string using only alpha
-- 						chars. 
--		
--						This data is then passed into the function count_letter
--						to count the letters and calculate the percentage freq
--						by taking the letter to count, the input string (after
--						leaving only unique alpha chars) and the original string
-- 						length. We use list comprehension to create a list
--						the matching letters, and then get the len of the list,
--						dividing by the total chars to get the freq of that letter.
--						
--						Finally, freq_letter_pc converts the input text to lowercase,
--						creates the tuple pairs and then sorts the list on the second 
--						value, which is the frequency.
--			
--						Nasty, but it works.


import Data.Char
import Data.List
import Data.Function

count_letter 		:: 	Char -> [Char] -> Int -> Double
count_letter letterToCount stringToCount stringLength = fromIntegral (length [ x | x <- stringToCount, x == letterToCount]) / fromIntegral (stringLength) 

create_freq_tuple	::	String -> [(Char, Double)]
create_freq_tuple stringToCount =[(x, count_letter x stringToCount (length [c | c <- stringToCount, isAlpha c])) | x <- nub stringToCount, isAlpha x ]

freq_letter_pc		::	String -> [(Char, Double)]
freq_letter_pc text = sortBy (flip compare `on` snd) (create_freq_tuple (map toLower [char | char <- text]))
