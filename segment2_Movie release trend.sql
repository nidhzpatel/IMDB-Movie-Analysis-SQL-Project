-- Determine the total number of 
-- movies released each year and analyse the month-wise trend.
select * from movie;

SELECT 
YEAR(date_published) AS release_year,
MONTH(date_published) AS release_month,
COUNT(*) AS movie_released
FROM movie
GROUP BY YEAR(date_published), MONTH(date_published)
ORDER BY YEAR(date_published), MONTH(date_published);

-- Calculate the number of movies produced in the USA or India
--  in the year 2019.

SELECT COUNT(*) AS movie_USA_INDIA_2019
FROM movie
WHERE (country = 'USA' OR country = 'India') AND year = 2019;
