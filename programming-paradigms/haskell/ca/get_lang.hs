-- Course:			Programming Paradigms - DT228B1
-- 					Assignment 3 - Haskell
-- Due Date: 		21st December 2016
--
-- Student: 		Iain Breen
-- Student Number:	D07112248

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
-- Solution: 			Combine the letter frequency with the euclidian distance
--						answers, and compare the results of the distances; shorter
--						distance is closer to the freq analsis and we can guess that
--						it is the correct language.

--  ////// Code from freq_letter_pc.hs /////
import Data.Char
import Data.List
import Data.Function

eng_freq :: [Float]
eng_freq = [8.12,1.49,2.71,4.32,12.02,2.30,2.03,5.92,7.31,0.10,0.69,3.98,2.61,6.95,7.68,1.82,0.11,6.02,6.28,9.10,2.88,1.11,2.09,0.17,2.11,0.07]

pt_freq :: [Float]
pt_freq = [12.21, 1.01, 3.35, 4.21, 13.19, 1.07, 1.08, 1.22, 5.49, 0.30, 0.13, 3.00, 5.07, 5.02, 10.22, 3.01, 1.10, 6.73, 7.35, 5.07, 4.46, 1.72, 0.05, 0.28, 0.04, 0.45]

count_letter 		:: 	Char -> [Char] -> Int -> Float
count_letter letterToCount stringToCount stringLength = ((fromIntegral (length [ x | x <- stringToCount, x == letterToCount])) / (fromIntegral  stringLength)) * 100
																		
create_freq_tuple	::	String -> [(Char, Float)]
create_freq_tuple stringToCount =[(x, count_letter x stringToCount (length [c | c <- stringToCount, isAlpha c])) | x <- nub stringToCount, isAlpha x ]

freq_letter_pc		::	String -> [(Char, Float)]
freq_letter_pc text = sortBy ( compare `on` fst) (create_freq_tuple (map toLower [char | char <- text]))
-- ///// END Code from freq_letter_pc.hs /////


-- ///// Code from Euclid Distance /////
minusAndSquare				::	(Float,Float) -> Float
minusAndSquare coord		=	((fst coord) - (snd coord)) ^ 2

eucl_dist					::	[Float] -> [Float] -> Float
eucl_dist vector1 vector2 	= sqrt (sum (map minusAndSquare (zip vector1 vector2)))

-- ///// Code from Euclid Distance //////


guess_lang 						::	Float -> Float -> String
guess_lang eng_dist port_dist  	= if eng_dist < port_dist
									then  "This text is in English"	
									else "This text is in Portuguese"

main = do
	contents <- getContents
	putStrLn "English Euclidian Distance:"
	print $ eucl_dist (snd(unzip (freq_letter_pc contents))) eng_freq
	putStrLn "Portuguese Euclidian Distance:"
	print $ eucl_dist (snd(unzip (freq_letter_pc contents))) pt_freq
	print $ guess_lang (eucl_dist (snd(unzip (freq_letter_pc contents))) eng_freq) (eucl_dist (snd(unzip (freq_letter_pc contents))) pt_freq)
 
-- ***************************************************************************