-- Course:			Programming Paradigms - DT228B1
-- 					Assignment 3 - Haskell
-- Due Date: 		21st December 2016
--
-- Student: 		Iain Breen
-- Student Number:	D07112248
import Data.Char
import Data.List
import Data.Function


-- **************************   CA Question 1    *****************************
--
-- Problem: 			Define a function is_square that takes an integer 
--						(positive) and returns True if the number is the square 
--						of an integer number. DO NOT use the SQRT function.
--
-- Solution: 			



-- ***************************************************************************

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




count_letter 		:: 	Char -> [Char] -> Int -> Double
count_letter letterToCount stringToCount stringLength = fromIntegral (length [ x | x <- stringToCount, x == letterToCount]) / fromIntegral (stringLength) 

create_freq_tuple	::	String -> [(Char, Double)]
create_freq_tuple stringToCount =[(x, count_letter x stringToCount (length [c | c <- stringToCount, isAlpha c])) | x <- nub stringToCount, isAlpha x ]



freq_letter_pc		::	String -> [(Char, Double)]
freq_letter_pc text = sortBy (flip compare `on` snd) (create_freq_tuple (map toLower [char | char <- text]))

-- ***************************************************************************

-- **************************   CA Question 4    *****************************
--
-- Problem: 			a. Write an Haskell function c_encrypt that takes a 
--						string of small letters and spaces , an integer positive 
--						number and return the same string encrypted with the 
--						Caesar cypher
--						c_encrypt "this is a text" 2 = “vjku ku c vgzv”
--						b. Write a function c_decrypt that takes a string of 
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



charToInt				:: Char -> Int
charToInt char 			= ord char - ord 'a'

intToChar 				:: Int -> Char
intToChar intVal 		= chr (ord 'a' + intVal)

rotate 					:: Char -> Int -> Char
rotate char intVal 		| isAlpha char = intToChar ((charToInt char + intVal) `mod` 26)
						| otherwise = char

c_encrypt 				:: String -> Int -> String
c_encrypt text rotVal 	= [rotate char rotVal | char <- text]

c_decrypt 				:: String -> Int -> String
c_decrypt text rotVal 	= [rotate char (-1 * rotVal) | char <- text]
-- ***************************************************************************

-- **************************   CA Question 5    *****************************
--
-- Problem: 			Create a function eucl_dist to compute the euclidean 
--						distance between two vectors. Each vector is represented 
--						by a list of float number of unknown length. The two 
--						lists must have the same number of elements.
--
-- Solution: 			Create a helper function to do the inner calculation of 
--						adding the vector elements and squaring them. Zip the
--						vectors together and pass them through minusAndSquare,
--						sum the results and get the square root of the total.
--
-- Example:				eucl_dist [0,3,4,5] [7,6,3,-1]

minusAndSquare				::	(Double,Double) -> Double
minusAndSquare coord		=	((fst coord) - (snd coord)) ^ 2

eucl_dist					::	[Double] -> [Double] -> Double
eucl_dist vector1 vector2 	= sqrt (sum (map minusAndSquare (zip vector1 vector2)))

-- ***************************************************************************

-- **************************   CA Question 6    *****************************
--
-- Problem: 			Write a Haskell function get_lang that gets a text and 
--						print the message "The text is in English" if the text 
--						is written in English or "The text is in Portuguese" 
--						if the text is written in Portuguese (as a simplification, 
--						we only use text containing the 26 basic letters, without 
--						accents or other phonetic symbols). In order to identify 
--						the language, compute the frequency distribution of the 
--						letters in the text, store it into a list and check if 
--						the distribution is closer to eng_freq or pt_freq. You 
--						can use the function defined at exercise 2 and 6. 
--						Transform the text in small case first.
--
-- Solution: 			


-- ***************************************************************************



-- **************************   CA Question 7    *****************************
--
-- Problem: 		Define a function integral, that approximates the 
--					integral of a function f.
--
-- Solution: 		Left Riemann Rule, from 
--					http://www.shmoop.com/definite-integrals/left-hand-sum.html
--					Once the function is defined, we use map to pass all the 
--					rectangle interval numbers through. The interval is defined
--					as a list comprehension (though ugly). I had to hand-craft 
--					the list comp until I got the values I wanted, i.e
-- 					[1, 1 + ((20-1) / 9)..(20 - ((20-1) / 9))]
--					which is
--					[minVal, minVal + ((maxVal-minVal) / interval)..(maxVal - ((maxVal-minVal) / interval))]
--
-- Example:			integral func 1 20 9
	

func		:: Double -> Double
func x		= 0.5 * x 		

integral 							:: (Double -> Double) -> Double -> Double -> Double -> Double
integral h minVal maxVal interval	= sum ( map h [minVal, minVal + ((maxVal - minVal) / interval).. ( maxVal - ((maxVal - minVal) / interval))] ) * ((maxVal - minVal) / interval)

-- ***************************************************************************
