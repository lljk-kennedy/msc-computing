-- Course:			Programming Paradigms - DT228B1
-- 					Assignment 3 - Haskell
-- Due Date: 		21st December 2016
--
-- Student: 		Iain Breen
-- Student Number:	D07112248

-- **************************   CA Question 2    *****************************
--
-- Problem: 			A small database contains two tables, one is a list of 
--						cities, identified by a city_id, city_name, 
--						city_population and country_id. The other table is a 
--						list of countries (country_id, country_name). Table 
--						country is related by a 1 to many relation with table 
--						cities, country_id is the foreign key.
--
-- Solution: 	    	Using list comprehension!  
--
-- Examples: 			get_city_above 6000000 = ["Paris","London","Madrid"]
--						get_city "Italy" = ["Rome","Milan","Florence","Venice"]
-- 						num_city = [("UK",2),("Italy",4), ("France",2),("Spain",2)]		

cities 					= 	[	
								(1,"Paris",7000000,1),
								(2,"London",8000000,2),
								(1,"Rome",3000000,3),
								(1,"Edinburgh",500000,2),
								(1,"Florence",500000,3),
								(1,"Venice",200000,3), 
								(1,"Lyon",1000000,1),
								(1,"Milan",5000000,3),
								(1,"Madrid",6000000,4),
								(1,"Barcelona",5000000,4)
							]

countries				= 	[
								(1,"UK"),
								(2,"France"),
								(3,"Italy"),
								(4,"Spain")
							]

get_city_above 			:: Int -> [String]
get_city_above val		= [cityName | (_, cityName, pop, _) <- cities, pop >= val ]

get_city 				:: String -> [String]
get_city countryName    = [cityName | (_, cityName, _, country_id) <- cities, (c_id, c_name) <- countries, countryName == c_name, country_id == c_id]

num_city				:: [(String, Int)]
num_city				= [(countryName, length (get_city countryName)) |  (_, countryName) <- countries ] 
-- ***************************************************************************