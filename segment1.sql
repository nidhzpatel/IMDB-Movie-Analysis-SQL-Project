-- Segment 1: Database - Tables, Columns, Relationships
use imdb;

-- Question 1
-- What are the different tables in the 
-- database and how are they connected to each other in 
--  the database?

-- Answer
-- >There are 6 different tables director_mapping,genre,movie,
-- names,ratings,role_mapping.
-- >genre,role_mapping,director_mapping,ratings are connected to 
--  movie table where movie_id is foreign key in all tables and id is 
--  primary key in movie table.
 
-- Question 2 
-- Find the total number of rows in each table of the schema.
select count(*) As director_mapping_rows from director_mapping;
select count(*) As genre_rows from genre;
select count(*) As movie_rows from movie;
select count(*) As names_rows from names;
select count(*) As ratings_rows from ratings;
select count(*) As role_mapping_rows from role_mapping;

-- Question 3
-- Identify which columns in the movie table have null values
SELECT 
COUNT(CASE WHEN id IS NULL THEN 1 END) AS id_null_count,
COUNT(CASE WHEN title IS NULL THEN 1 END) AS title_null_count,
COUNT(CASE WHEN year IS NULL THEN 1 END) AS year_null_count,
COUNT(CASE WHEN date_published IS NULL THEN 1 END) AS date_published_null_count,
COUNT(CASE WHEN duration IS NULL THEN 1 END) AS duration_null_count,
COUNT(CASE WHEN country IS NULL THEN 1 END) AS country_null_count,
COUNT(CASE WHEN worlwide_gross_income IS NULL THEN 1 END) AS worlwide_gross_income_null_count,
COUNT(CASE WHEN languages IS NULL THEN 1 END) AS languages_null_count,
COUNT(CASE WHEN production_company IS NULL THEN 1 END) AS production_company_null_count
FROM movie;

SELECT null_columns, count(*)
FROM
(SELECT 
CASE 
	WHEN id IS NULL THEN 'ID' 
	WHEN title IS NULL THEN 'title' 
	WHEN year IS NULL THEN 'year' 
	WHEN date_published IS NULL THEN 'date_published' 
	WHEN duration IS NULL THEN 'duration' 
	WHEN country IS NULL THEN 'country' 
	WHEN worlwide_gross_income IS NULL THEN 'worlwide_gross_income' 
	WHEN languages IS NULL THEN 'languages' 
	WHEN production_company IS NULL THEN 'production_company' 
END AS null_columns
FROM movie) AS X
WHERE X.null_columns is not null
group by 1;

SELECT *,
CASE 
	WHEN id IS NULL THEN 'ID' 
	WHEN title IS NULL THEN 'title' 
	WHEN year IS NULL THEN 'year' 
	WHEN date_published IS NULL THEN 'date_published' 
	WHEN duration IS NULL THEN 'duration' 
	WHEN country IS NULL THEN 'country' 
	WHEN worlwide_gross_income IS NULL THEN 'worlwide_gross_income' 
	WHEN languages IS NULL THEN 'languages' 
	WHEN production_company IS NULL THEN 'production_company' 
END AS null_columns
FROM movie;

select 
count( case when title is null then 1 END )as title_null from movie;

select count(*) 
from movie
where title is null;

SELECT 
CASE WHEN title IS NULL then 1 END AS title_null_check,
FROM movie;
