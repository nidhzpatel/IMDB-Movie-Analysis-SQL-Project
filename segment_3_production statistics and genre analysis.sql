-- Retrieve the unique list of genres present in the dataset.
USE IMDB;

SELECT DISTINCT(GENRE) 
FROM GENRE;

-- Identify the genre with the highest number of 
-- movies produced overall.
SELECT GENRE,COUNT(MOVIE_ID) AS  TOTAL_GENRE_MOVIE
FROM GENRE
GROUP BY GENRE
ORDER BY TOTAL_GENRE_MOVIE DESC
LIMIT 1;

-- Determine the count of movies that belong to 
-- only one genre.
SELECT MOVIE_ID
FROM GENRE
WHERE MOVIE_ID IN (
    SELECT MOVIE_ID
    FROM GENRE
    GROUP BY MOVIE_ID
    HAVING COUNT(GENRE) = 1
);

-- Calculate the average duration of movies in each genre.
SELECT GENRE,AVG(MOVIE.DURATION) AS  AVERAGE_DURATION
FROM GENRE
INNER JOIN MOVIE ON GENRE.movie_id = MOVIE.id
GROUP BY GENRE.genre;

-- Find the rank of the 'thriller' genre among all genres 
-- in terms of the number of movies produced.
SELECT X.GENRE, X.GENRE_RANK
FROM
(SELECT GENRE,COUNT(MOVIE_ID) as MOVIE_COUNT,
ROW_NUMBER() OVER (ORDER BY COUNT(genre.movie_id) DESC) AS genre_rank
FROM movie
JOIN genre ON movie.id = genre.movie_id
GROUP BY genre) AS X
WHERE X.GENRE = 'Thriller';

