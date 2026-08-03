--REMOVING DUPLICATES

SELECT *
INTO Layoffs_Staging
FROM Layoffs
WHERE 1 = 0;
--WHERE 1 = 0 is the key — it copies the table structure only (columns, data types) without copying any data, just like MySQL's CREATE TABLE ... LIKE.

-- First verify duplicates
WITH duplicate_cte AS
(
SELECT *,
row_number() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions ORDER BY (SELECT NULL)) AS row_num
FROM Layoffs_Staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Then delete duplicates in separate query
WITH duplicate_cte AS
(
SELECT *,
row_number() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions ORDER BY (SELECT NULL)) AS row_num
FROM Layoffs_Staging
)
DELETE
FROM duplicate_cte
WHERE row_num > 1;

--checking if the duplicates are still there
WITH duplicate_cte AS
(
SELECT *,
row_number() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions, row ORDER BY (SELECT NULL)) AS row_num
FROM Layoffs_Staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

select *
from Layoffs_Staging
;

--STANDARDIZING DATA

select distinct company, trim(company) 
from Layoffs_Staging;

update Layoffs
set company = trim(company);

select distinct company, trim(company) 
from Layoffs_Staging;

select *
from Layoffs_Staging
where  industry like 'Crypto%'
;

update Layoffs_Staging
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct industry
from Layoffs_Staging;

select * 
from Layoffs_Staging;

select *
from Layoffs_Staging
where country like 'United States'
order by 1;

--SQL Server doesn't have TRIM(TRAILING ...) like MySQL. Use REPLACE or STUFF instead:
select distinct country, replace(country, '.', '') as trimmed_country
from Layoffs_Staging
order by 1;

update Layoffs_Staging
set country = replace(country, '.', '') 
where country like 'United States';

-- changing from one data type to another
SELECT date,
try_convert(DATE, date, 101) AS converted_date
FROM Layoffs_Staging;

UPDATE Layoffs_Staging
SET date = TRY_CONVERT(DATE, date, 101)
WHERE TRY_CONVERT(DATE, date, 101) IS NOT NULL;


alter table Layoffs_Staging
alter column date DATE;

select *
from Layoffs_Staging;

--NULL & BLANK VALUES
select *
from Layoffs_Staging
where total_laid_off = 'NULL'
and percentage_laid_off = 'NULL';

select *
from Layoffs_Staging
where industry = 'NULL'
 ;

 select *
from Layoffs_Staging
where company = 'Airbnb'
 ;

 --Check what you're working with
SELECT company, industry
FROM Layoffs_Staging
WHERE industry IS NULL OR industry = 'NULL' OR industry = '';

--populating NULL industry using self join
UPDATE t1
SET t1.industry = t2.industry
FROM Layoffs_Staging t1
JOIN Layoffs_Staging t2
    ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = 'NULL' OR t1.industry = '')
AND (t2.industry IS NOT NULL AND t2.industry != 'NULL' AND t2.industry != '');

SELECT company, industry
FROM Layoffs_Staging
WHERE industry IS NULL OR industry = 'NULL' OR industry = '';

select *
from Layoffs_Staging
where total_laid_off = 'NULL'
AND percentage_laid_off = 'NULL';

DELETE 
from Layoffs_Staging
where total_laid_off = 'NULL'
AND percentage_laid_off = 'NULL';

select *
from Layoffs_Staging;


