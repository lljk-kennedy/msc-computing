-- question 12
max_f 						:: 	(Double ->Double) -> Double -> Double -> Double
max_f h minVal maxVal		= maximum ( map h [minVal, minVal + 0.1 .. maxVal] ) 

-- question 8
c_vowel						::	String -> [(Char, Int)]
c_vowel stringToCount 		=	[(x, count_letter x stringToCount) | x <- ['a', 'e', 'i', 'o', 'u']]


count_letter 								:: 	Char -> [Char] -> Int
count_letter letterToCount stringToCount 	= 	length [ x | x <- stringToCount, x == letterToCount]

