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
-- Example:				 

minusAndSquare				::	(Double,Double) -> Double
minusAndSquare coord		=	((fst coord) - (snd coord)) ^ 2

eucl_dist					::	[Double] -> [Double] -> Double
eucl_dist vector1 vector2 	= sqrt (sum (map minusAndSquare (zip vector1 vector2)))

-- **************************************************************************
