-- Retrieve the minimum and maximum values in each column of the ratings table (except movie_id).

use imdb;

select * from ratings;

SELECT MIN(avg_rating) as MIN_AVG_RATING,
	   MAX(avg_rating) as MAX_AVG_RATING,
       MIN(total_votes) as MIN_TOTAL_VOTES,
	   MAX(total_votes) as MAX_TOTAL_VOTES,
       MIN(median_rating) as MIN_MEDIAN_RATING,
	   MAX(median_rating) as MAX_MEDIAN_RATING
FROM RATINGS;

-- QUESTION 2
-- Identify the top 10 movies based on average rating.
SELECT MOVIE.ID, MOVIE.TITLE, RATINGS.AVG_RATING,
ROW_NUMBER() OVER(ORDER BY avg_rating DESC) AS TOP
FROM RATINGS
INNER JOIN MOVIE ON MOVIE.id = RATINGS.movie_id
LIMIT 10;

-- QUESTION 3
-- Summarise the ratings table based on movie counts by median ratings.
-- Pending
SELECT MEDIAN_RATING, COUNT(*) AS TOTAL_MEDIAN_RATING_MOVIE
FROM RATINGS
GROUP BY MEDIAN_RATING
ORDER BY TOTAL_MEDIAN_RATING_MOVIE DESC;


-- QUESTION 4
-- Identify the production house that has produced the most number of hit movies (average rating > 8).
SELECT * FROM RATINGS;

SELECT MOVIE.PRODUCTION_COMPANY, COUNT(*) AS HIT_MOVIES
FROM RATINGS
INNER JOIN MOVIE ON MOVIE.id = RATINGS.movie_id
WHERE RATINGS.AVG_RATING > 8 AND MOVIE.PRODUCTION_COMPANY IS NOT NULL
GROUP BY MOVIE.PRODUCTION_COMPANY
ORDER BY HIT_MOVIES DESC;

-- QUESTION 5
-- Determine the number of movies released in each genre during March 2017 in the USA with more than 1,000 votes
SELECT  GENRE.GENRE, RATINGS.TOTAL_VOTES, COUNT(*) AS TOTAL_MOVIE_RELEASED_MARCH2017_GRETERTHAN1000VOTES
FROM MOVIE
INNER JOIN RATINGS ON MOVIE.id = RATINGS.movie_id
INNER JOIN GENRE ON MOVIE.id = GENRE.movie_id
WHERE RATINGS.TOTAL_VOTES > 1000 AND MOVIE.COUNTRY = 'USA'  AND YEAR(DATE_PUBLISHED) = 2017 AND MONTH(DATE_PUBLISHED) = 3
GROUP BY GENRE.GENRE, RATINGS.TOTAL_VOTES;

-- QUESTION 6
-- Retrieve movies of each genre starting with the word 'The' and having an average rating > 8.
SELECT  GENRE.GENRE, MOVIE.TITLE
FROM MOVIE
INNER JOIN RATINGS ON MOVIE.id = RATINGS.movie_id
INNER JOIN GENRE ON MOVIE.id = GENRE.movie_id
WHERE MOVIE.TITLE LIKE 'The%'  AND RATINGS.AVG_RATING >8
ORDER BY GENRE;
