-- ==========================
-- Project: Bestseller Books
-- File: prepare_data.sql
-- Author: Wipadee S.
-- Purpose: Clean and prepare data for Power BI analysis
-- ==========================
-- Note: During initial data import, the CSV header row was not recognized.
-- The first row was inserted as a data row, causing incorrect column alignment.
-- Steps taken:
-- 1. Deleted the first row from the table.
-- 2. Renamed all columns manually to: Name, Author, User_Rating, Reviews, Price, Year, Genre.
-- This ensures the data is clean and ready for analysis.

-- ##Step 1: Import data

-- ## Step 2: Delete the first column
DELETE FROM `bestsellers_with_categories_1` 
WHERE COL 1='Name'

-- ## Step 3: Query data to check information
SELECT * 
FROM `bestsellers_with_categories_1` 
LIMIT 10;
-- #Output: The first column has been deleted.
	
-- ##Step 4: Change column name
SELECT COL 1='Name',COL 2='Author',COL 3='User_Rating',COL 4='Reviews',COL 5='Price',COL 6='Year',COL 7='Genre' 
FROM `bestsellers_with_categories_1`
-- #Output: Column name=(Name,Author,User_Rating,Reviews,Price,Year,Genre)

-- ## Step 5: Change data type
ALTER TABLE bestsellers_with_categories_1
MODIFY User_Rating FLOAT,
MODIFY Reviews INT,
MODIFY Price FLOAT,
MODIFY Year INT;
-- #Output example:	Column		Data Type
       			-- Name		varchar
			-- Author	varchar
			-- User_Rating	float
			-- Reviews	int
			-- Price	float
			-- Year		int
			-- Genre	varchar

-- ## Step 6: Checking for and handling missing values
SELECT
  COUNT(*) AS total_rows,
  COUNT(CASE WHEN Name IS NULL THEN 1 END) AS Name_nulls,
  COUNT(CASE WHEN Author IS NULL THEN 1 END) AS Author_nulls,
  COUNT(CASE WHEN User_Rating IS NULL THEN 1 END) AS User_Rating_nulls,
  COUNT(CASE WHEN Reviews IS NULL THEN 1 END) AS Reviews_nulls,
  COUNT(CASE WHEN Price IS NULL THEN 1 END) AS Price_nulls,
  COUNT(CASE WHEN Year IS NULL THEN 1 END) AS Year_nulls,
  COUNT(CASE WHEN Genre IS NULL THEN 1 END) AS Genre_nulls
FROM bestsellers_with_categories_1
-- #Output:The dataset contains no missing values

-- ## Step 7: Unique values
SELECT COUNT(DISTINCT(Name)),COUNT(DISTINCT(Author)),COUNT(DISTINCT(User_Rating)),COUNT(DISTINCT(Reviews)),COUNT(DISTINCT(Price)),COUNT(DISTINCT(Year)),COUNT(DISTINCT(Genre))
FROM bestsellers_with_categories_1
-- #Output example:
	-- Name           350
	-- Author         248
	-- User Rating     14
	-- Reviews        346
	-- Price           40
	-- Year            11
	-- Genre            2

-- ## Step 8: Statistics
-- ## Exploratory Analysis
-- #User Rating
SELECT COUNT(User_Rating),AVG(User_Rating),MAX(User_Rating),MIN(User_Rating)
FROM bestsellers_with_categories_1
-- #Output example::
	-- COUNT(User_Rating)	550
	-- AVG(User_Rating)	4.6183636452934955
	-- MAX(User_Rating)	4.9
	-- MIN(User_Rating)	3.3

-- #Reviews
SELECT COUNT(Reviews),AVG(Reviews),MAX(Reviews),MIN(Reviews)
FROM bestsellers_with_categories_1
-- #Output example:
	-- COUNT(Reviews)	550
	-- AVG(Reviews)		11953.2818
	-- MAX(Reviews)		87841
	-- MIN(Reviews)		37

-- #Price
SELECT COUNT(Price),AVG(Price),MAX(Price),MIN(Price)
FROM bestsellers_with_categories_1
-- #Output example:
	-- COUNT(Price)		550
	-- AVG(Price)		13.1
	-- MAX(Price)		105
	-- MIN(Price)		0

-- #Year
SELECT COUNT(Year),AVG(Year),MAX(Year),MIN(Year)
FROM bestsellers_with_categories_1
-- #Output example:
	-- COUNT(Year)		550
	-- AVG(Year)		2014
	-- MAX(Year)		2019
	-- MIN(Year)		2009

-- #Interpretation:Everything looks normal except for the "Price" column, the minimum value is 0 and the maximum value is 105. Both of which appear to be outliers.

-- ## Step 9: Max Price Values
-- ## Exploratory Analysis
SELECT DISTINCT(Name),Price
FROM bestsellers_with_categories_1
ORDER BY Price DESC
-- #Output example:	
		-- Name								Price
		-- Diagnostic and Statistical Manual of Mental Disord...	105
		-- The Twilight Saga Collection					82
		-- Hamilton: The Revolution					54
		-- The Book of Basketball: The NBA According to T...     	53

-- ## Step 10: Min Price Values
-- ## Exploratory Analysis
SELECT DISTINCT(Name),Price
FROM bestsellers_with_categories_1
ORDER BY Price ASC
-- #Output example:		
			-- Name							Price
			-- Cabin Fever (Diary of a Wimpy Kid, Book 6)		0
			-- Diary of a Wimpy Kid: Hard Luck, Book 8     		0
			-- Frozen (Little Golden Book)				0
			-- JOURNEY TO THE ICE P					0
            		-- Little Blue Truck					0
			-- The Constitution of the United States		0
			-- The Getaway						0
			-- The Short Second Life of Bree...			0
			-- To Kill a Mockingbird				0
-- #Interpretation: Some book prices may seem unusual, as bestsellers generally do not sell for such low prices. 
-- #However, these low prices may be special edition or promotional prices.Therefore, the data set is still used as the main data.

-- ##Step 11: Check duplicate values in the 'Name' column.
SELECT *,COUNT(*) AS duplicate_count
FROM bestsellers_with_categories_1
GROUP BY Name
HAVING COUNT(*) > 1;
-- #Output example:
-- Name					Author			User_Rating	Reviews	Price	Year	Genre		duplicate_count
-- A Man Called Ove...			Fredrik Backman		4.6		23848	8	2016	Fiction		2
-- All the Light We Cannot See		Anthony Doerr		4.6		36348	14	2014	Fiction		2
-- Becoming				Michelle Obama		4.8		61133	11	2018	Non Fiction	2
-- Between the World and Me		Ta-Nehisi Coates	4.7		10070	13	2015	Non Fiction	2
-- Brown Bear, Brown Bear,...		Bill Martin Jr.		4.9		14344	5	2017	Fiction		2
-- Catching Fire (The Hunger Games)	Suzanne Collins		4.7		22614	11	2010	Fiction		3


-- #Step 12: Check quantity duplicate values in the 'Name' column.
SELECT COUNT(Name)
FROM bestsellers_with_categories_1
WHERE Name IN (
	SELECT Name
	FROM bestsellers_with_categories_1
	GROUP BY Name
	HAVING COUNT(Name) > 1 )
ORDER BY Name
-- #Output: 295

-- #Step 13: Duplicate values in rows
SELECT *
FROM bestsellers_with_categories_1
WHERE (Name,Author,User_Rating,Reviews,Price,Year,Genre) IN (
    SELECT *
	FROM bestsellers_with_categories_1
	GROUP BY Name,Author,User_Rating,Reviews,Price,Year,Genre
	HAVING COUNT(*) > 1
 )
-- #Output: No Duplicate values in rows

-- #Step 14:Determine the different years in which the same book title appears multiple times in the bestseller list.
SELECT *
FROM bestsellers_with_categories_1
WHERE Name IN (
    SELECT Name
    FROM bestsellers_with_categories_1
    GROUP BY Name
    HAVING COUNT(DISTINCT Year) > 1
)
ORDER BY Name, Year;
-- #Output example:
-- Name					Author			User_Rating	Reviews	Price	Year	Genre
-- A Man Called Ove: A Novel		Fredrik Backman		4.6		23848	8	2016	Fiction
-- A Man Called Ove: A Novel		Fredrik Backman		4.6		23848	8	2017	Fiction
-- All the Light We Cannot See		Anthony Doerr		4.6		36348	14	2014	Fiction
-- All the Light We Cannot See		Anthony Doerr		4.6		36348	14	2015	Fiction
-- #Interpretation: It can be concluded that some of the duplicate book titles have been bestsellers for many years, 
-- for example, "A Man Called Ove: A Novel" was a bestseller in both 2016 and 2017, and All the Light We Cannot See was a bestseller in both 2014 and 2015.

-- #Step 15: This analysis checks whether bestselling books appear consistently across multiple years, 
-- in order to support decisions on whether or not to remove duplicate entries.
SELECT Name,
GROUP_CONCAT(DISTINCT Year ORDER BY Year SEPARATOR ',') AS 'Years',
MAX(Year)-MIN(Year)+1 AS 'Expected_continuous_years',
COUNT(DISTINCT Year) AS 'Actual_years_count',
	CASE 
        WHEN COUNT(DISTINCT Year) = MAX(Year)-MIN(Year)+1
        THEN 'continue'
	ELSE 'discontinue'
        END AS 'Year_Continuity_Status'
FROM bestsellers_with_categories_1
GROUP BY Name
HAVING COUNT(DISTINCT Year) > 1
ORDER BY Name
-- #Output example:
-- Name				Years		Expected_continuous_years	Actual_years_count	Year_Continuity_Status
-- A Man Called Ove: A Novel	2016,2017	2				2			continue
-- All the Light We Cannot See	2014,2015	2				2			continue
-- Becoming			2018,2019	2				2			continue
-- Between the World and Me	2015,2016	2				2			continue
-- Brown Bear, Brown Bear...	2017,2019	3				2			discontinue

-- #Step 16: Check quantity continue status
SELECT Continue_Status, COUNT(*) AS book_count
FROM (
    SELECT Name,
           GROUP_CONCAT(DISTINCT Year ORDER BY Year SEPARATOR ',') AS 'Years',
           MAX(Year)-MIN(Year)+1 AS 'Expected_continuous_years',
           COUNT(DISTINCT Year) AS 'Actual_years_count',
           CASE 
               WHEN COUNT(DISTINCT Year) = MAX(Year)-MIN(Year)+1
               THEN 'continue'
               ELSE 'discontinue'
           END AS 'Continue_Status'
    FROM bestsellers_with_categories_1
    GROUP BY Name
    HAVING COUNT(DISTINCT Year) > 1
) AS Summary
GROUP BY Continue_Status
-- #Output: continue 86 discontinue 9


-- #Step 17: Determine the different price in which the same book title appears multiple times in the bestseller list.
SELECT Name, Price,Year
FROM bestsellers_with_categories_1
WHERE Name IN (
    SELECT Name
    FROM bestsellers_with_categories_1
    GROUP BY Name
    HAVING COUNT(DISTINCT Price) > 1
)
ORDER BY Name, Price DESC
-- #Output example:
-- Name								Price	Year	
-- Gone Girl							10	2012
-- Gone Girl							10	2013
-- Gone Girl							9	2014
-- Quiet: The Power of Introverts in a World That Can...	20	2012
-- Quiet: The Power of Introverts in a World That Can...	7	2013

-- #Interpretation: Duplicate book titles also have duplicate prices.

-- #Step 18: Create a new table to aggregate data without using year and calculate averages of key data 
-- (Price, User Rating, Reviews) and count the number of years a book has been on the bestseller list.
SELECT Name,
MIN(Author) AS 'Author', -- Select the first author to represent
AVG(User_Rating) AS 'AVG_Rating',
AVG(Reviews) AS 'AVG_Reviews',
AVG(Price) AS 'AVG_Price',
GROUP_CONCAT(DISTINCT Year ORDER BY Year SEPARATOR ',') AS 'Years',
Genre
FROM bestsellers_with_categories_1
GROUP BY Name
-- #Output example:
-- Name					Author				AVG_Rating	AVG_Reviews	AVG_Price	Years		Genre
-- 10-Day Green Smoothie Cleanse	JJ Smith			4.7		17350		8		2016		Non Fiction
-- 11/22/63: A Novel			Stephen King			4.6		2052		22		2011		Fiction
-- 12 Rules for Life: An Antidote...	Jordan B. Peterson		4.7		18979		15		2018		Non Fiction
-- 1984 (Signet Classics)		George Orwell			4.7		21424		6		2017		Fiction
-- 5,000 Awesome Facts (About...	National Geographic Kids	4.8		7665		12		2019		Non Fiction
-- A Dance with Dragons (A Song...	George R. R. Martin		4.4		12643		11		2011		Fiction
-- A Game of Thrones / A Clash of...	George R. R. Martin		4.7		19735		30		2014		Fiction	
-- A Gentleman in Moscow: A Novel	Amor Towles			4.7		19699		15		2017		Fiction
-- A Higher Loyalty: Truth, Lies...	James Comey			4.7		5983		3		2018		Non Fiction
-- A Man Called Ove: A Novel		Fredrik Backman			4.6		23848		8		2016,2017	Fiction
-- A Patriot's History of the...	Larry Schweikart		4.6		460		2		2010		Non Fiction
-- A Stolen Life: A Memoir		Jaycee Dugard			4.6		4149		32		2011		Non Fiction
-- A Wrinkle in Time (Time Quintet)	Madeleine L'Engle		4.5		5153		5		2018		Fiction
-- Act Like a Lady, Think Like a...	Steve Harvey			4.6		5013		17		2009		Non Fiction
-- Adult Coloring Book Designs:...	Adult Coloring Book Designs	4.5		2313		4		2016		Non Fiction
-- Adult Coloring Book: Stress...	Blue Star Coloring		4.6		2925		6		2015		Non Fiction
-- Adult Coloring Book: Stress Rel...	Blue Star Coloring		4.4		2951		6		2015		Non Fiction
-- Adult Coloring Books: A Coloring...	Coloring Books for Adults	4.5		2426		8		2015		Non Fiction
-- Alexander Hamilton			Ron Chernow			4.8		9198		13		2016		Non Fiction
-- All the Light We Cannot See		Anthony Doerr			4.6		36348		14		2014,2015	Fiction

-- #Step 19: Create a bestseller summary table
SELECT Name,
       MIN(Author) AS 'Author',
       AVG(User_Rating) AS 'AVG_Rating',
       AVG(Reviews) AS 'AVG_Reviews',
       AVG(Price) AS 'AVG_Price',
       COUNT(DISTINCT Year) AS 'Years_Count',
       GROUP_CONCAT(DISTINCT Year ORDER BY Year) AS Years_List,
       Genre
FROM bestsellers_with_categories_1
GROUP BY Name;
-- #Output example:
-- Name					Author				AVG_Rating	AVG_Reviews	AVG_Price	Years_Count	Year		Genre
-- 10-Day Green Smoothie Cleanse	JJ Smith			4.7		17350		8		1		2016		Non Fiction
-- 11/22/63: A Novel			Stephen King			4.6		2052		22		1		2011		Fiction
-- 12 Rules for Life: An Antidote...	Jordan B. Peterson		4.7		18979		15		1		2018		Non Fiction
-- 1984 (Signet Classics)		George Orwell			4.7		21424		6		1		2017		Fiction
-- 5,000 Awesome Facts (About...	National Geographic Kids	4.8		7665		12		1		2019		Non Fiction
-- A Dance with Dragons (A Song...	George R. R. Martin		4.4		12643		11		1		2011		Fiction
-- A Game of Thrones / A Clash of...	George R. R. Martin		4.7		19735		30		1		2014		Fiction	
-- A Gentleman in Moscow: A Novel	Amor Towles			4.7		19699		15		1		2017		Fiction
-- A Higher Loyalty: Truth, Lies...	James Comey			4.7		5983		3		1		2018		Non Fiction
-- A Man Called Ove: A Novel		Fredrik Backman			4.6		23848		8		2		2016,2017	Fiction
-- A Patriot's History of the...	Larry Schweikart		4.6		460		2		1		2010		Non Fiction
-- A Stolen Life: A Memoir		Jaycee Dugard			4.6		4149		32		1		2011		Non Fiction
-- A Wrinkle in Time (Time Quintet)	Madeleine L'Engle		4.5		5153		5		1		2018		Fiction
-- Act Like a Lady, Think Like a...	Steve Harvey			4.6		5013		17		1		2009		Non Fiction
-- Adult Coloring Book Designs:...	Adult Coloring Book Designs	4.5		2313		4		1		2016		Non Fiction
-- Adult Coloring Book: Stress...	Blue Star Coloring		4.6		2925		6		1		2015		Non Fiction
-- Adult Coloring Book: Stress Rel...	Blue Star Coloring		4.4		2951		6		1		2015		Non Fiction
-- Adult Coloring Books: A Coloring...	Coloring Books for Adults	4.5		2426		8		1		2015		Non Fiction
-- Alexander Hamilton			Ron Chernow			4.8		9198		13		1		2016		Non Fiction
-- All the Light We Cannot See		Anthony Doerr			4.6		36348		14		2		2014,2015	Fiction
-- #Export results as a .csv file for analysis in Power BI.

-- #Step 20: Create a table to view yearly trends
SELECT Name, Author, Year, Price, User_Rating, Reviews, Genre
FROM bestsellers_with_categories_1
ORDER BY Name, Year;
-- #Output example:
-- Name					Author				User_Rating	Reviews	Price	Year	Genre
-- 10-Day Green Smoothie Cleanse	JJ Smith			4.7		17350	8	2016	Non Fiction
-- 11/22/63: A Novel			Stephen King			4.6		2052	22	2011	Fiction	
-- 12 Rules for Life: An Antidote to...	Jordan B. Peterson		4.7		18979	15	2018	Non Fiction
-- 1984 (Signet Classics)		George Orwell			4.7		21424	6	2017	Fiction
-- 5,000 Awesome Facts (About...	National Geographic Kids	4.8		7665	12	2019	Non Fiction
-- A Dance with Dragons (A Song of...	George R. R. Martin		4.4		12643	11	2011	Fiction
-- A Game of Thrones / A Clash of...	George R. R. Martin		4.7		19735	30	2014	Fiction
-- A Gentleman in Moscow: A Novel	Amor Towles			4.7		19699	15	2017	Fiction
-- A Higher Loyalty: Truth, Lies,...	James Comey			4.7		5983	3	2018	Non Fiction
-- A Man Called Ove: A Novel		Fredrik Backman			4.6		23848	8	2016	Fiction
-- A Man Called Ove: A Novel		Fredrik Backman			4.6		23848	8	2017	Fiction
-- #Export results as a .csv file for analysis in Power BI.

-- #Export: 
-- #Use Step 19 results as the main dataset for summary analysis in Power BI.
-- #Use Step 20 results to analyze trends by year (line/bar chart, filters).
