USE IMDB;

-- QUESTION1
-- Classify thriller movies based on average ratings into different categories.
SELECT * FROM RATINGS;

SELECT MOVIE_ID, MOVIE.TITLE,
  CASE 
    WHEN AVG_RATING BETWEEN 8 AND 10 THEN 'SUPER HIT'
    WHEN AVG_RATING BETWEEN 5 AND 7.99 THEN 'HIT'
    WHEN AVG_RATING BETWEEN 0 AND 4.99 THEN 'FLOP'
    ELSE 'UNKNOWN'
  END AS MOVIE_TYPE
FROM RATINGS
INNER JOIN MOVIE ON MOVIE.ID = RATINGS.MOVIE_ID
WHERE MOVIE_ID IN (
  SELECT MOVIE_ID
  FROM GENRE
  WHERE GENRE = 'THRILLER'
)
ORDER BY TITLE;

-- QUESTION 2 (pending)
-- analyse the genre-wise running total and moving average of the average movie duration.
SELECT
  g.genre,
  SUM(m.duration) as running_total,
  AVG(m.duration) AS moving_average
FROM genre g
JOIN movie m ON g.movie_id = m.id
group BY g.genre, m.year;


-- QUESTION 3
-- Identify the five highest-grossing movies of each year that belong to the top three genres.
WITH top_genres AS (
  SELECT genre, COUNT(*) AS genre_count
  FROM genre
  GROUP BY genre
  ORDER BY genre_count DESC
  LIMIT 3
),
top_movies AS (
  SELECT m.title,m.year,tg.genre,m.worlwide_gross_income , 
  dense_rank() OVER (PARTITION BY m.year,tg.genre ORDER BY m.worlwide_gross_income DESC) AS row_num
  FROM movie m, top_genres tg
  WHERE m.id IN (
    SELECT movie_id
    FROM genre
    WHERE genre IN (SELECT genre FROM top_genres)
  )
  order by tg.genre
)
SELECT *
FROM top_movies
WHERE row_num <= 5;

-- QUESTION 4
-- Determine the top two production houses that have produced the highest number of hits among multilingual movies.
SELECT production_company, COUNT(*) AS hit_count
FROM movie
WHERE languages LIKE '%,%' AND production_company is not null
GROUP BY production_company
ORDER BY hit_count DESC
LIMIT 2;


-- QUESTION 5
-- Identify the top three actresses based on the number of Super Hit movies (average rating > 8) in the drama genre.

SELECT * FROM
(SELECT  
DENSE_RANK() OVER(ORDER BY RATINGS.AVG_RATING DESC) AS TOP_RANK,
NAMES.NAME AS ACTRESSES_NAME, RATINGS.AVG_RATING
FROM ROLE_MAPPING
INNER JOIN NAMES ON ROLE_MAPPING.NAME_ID = NAMES.ID
INNER JOIN RATINGS ON ROLE_MAPPING.MOVIE_ID = RATINGS.MOVIE_ID
INNER JOIN MOVIE ON ROLE_MAPPING.MOVIE_ID = MOVIE.ID
INNER JOIN GENRE ON ROLE_MAPPING.MOVIE_ID = GENRE.MOVIE_ID
WHERE ROLE_MAPPING.CATEGORY = "ACTRESS" AND RATINGS.AVG_RATING > 8 AND GENRE = 'Drama'
ORDER BY TOP_RANK) AS ANSWER
WHERE TOP_RANK <= 3;

-- QUESTION 6
-- Retrieve details for the top nine directors based on the number of movies, including average inter-movie duration, ratings, and more.
SELECT *
FROM
(SELECT  NAMES.NAME AS DIRECTOR_NAME, COUNT(DISTINCT(MOVIE.ID)) AS TOTAL_MOVIE, AVG(DURATION)   , AVG(AVG_RATING) AS AVGR,
ROW_NUMBER() OVER(PARTITION BY COUNT(DISTINCT(MOVIE.ID)) ORDER BY AVG(DURATION) DESC ,AVG(AVG_RATING) DESC ) AS RNUM
FROM DIRECTOR_MAPPING
LEFT JOIN NAMES ON DIRECTOR_MAPPING.NAME_ID = NAMES.ID
LEFT JOIN RATINGS ON DIRECTOR_MAPPING.MOVIE_ID = RATINGS.MOVIE_ID
LEFT JOIN MOVIE ON DIRECTOR_MAPPING.MOVIE_ID = MOVIE.ID
GROUP BY NAME
ORDER BY TOTAL_MOVIE DESC) AS X
WHERE X.RNUM = 1;

SELECT  NAMES.NAME AS DIRECTOR_NAME, COUNT(DISTINCT(MOVIE.ID)) AS TOTAL_MOVIE, AVG(DURATION)   , AVG(AVG_RATING) AS AVGR,
ROW_NUMBER() OVER(PARTITION BY COUNT(DISTINCT(MOVIE.ID)) ORDER BY AVG(DURATION) DESC ,AVG(AVG_RATING) DESC ) AS RNUM
FROM DIRECTOR_MAPPING
LEFT JOIN NAMES ON DIRECTOR_MAPPING.NAME_ID = NAMES.ID
LEFT JOIN RATINGS ON DIRECTOR_MAPPING.MOVIE_ID = RATINGS.MOVIE_ID
LEFT JOIN MOVIE ON DIRECTOR_MAPPING.MOVIE_ID = MOVIE.ID
GROUP BY NAME
ORDER BY TOTAL_MOVIE DESC;

SELECT COUNT(*) FROM DIRECTOR_MAPPING WHERE NAME_ID = 'nm1777967';


SELECT * FROM NAMES;
SELECT DISTINCT(CATEGORY) FROM ROLE_MAPPING;