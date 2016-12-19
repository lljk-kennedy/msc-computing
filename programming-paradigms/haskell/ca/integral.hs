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