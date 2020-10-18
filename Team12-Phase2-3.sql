
--Q1
SELECT count(*) AS num_account FROM ACCOUNT;
--Q2
SELECT First_name, last_name, address FROM ACCOUNT, ADMIN WHERE Account_id = uid;
--Q3
SELECT count(*) AS num_account FROM (SELECT count(*) AS uid FROM RATING GROUP BY uid HAVING uid > 5) AS T; 
--Q4
SELECT count(*) AS num_movie FROM MOVIE LEFT OUTER JOIN (SELECT * FROM GENRE JOIN GENRE_OF ON gen = Genre_id where Genre = 'Romance') as g on mid = Movie_id where date_part('year', Start_year) = 2020;
--Q5
SELECT count(*) AS num_movie FROM MOVIE WHERE Start_year + interval '5 year' > '2020-10-07';
--Q6
SELECT ROUND(avg(Rating),1) AS avg_rating FROM MOVIE WHERE date_part('year', Start_year) > (date_part('year',NOW())-5);
--Q7
SELECT count(*) AS num_movie FROM MOVIE WHERE Running_time > 100; 
--Q8
SELECT original_title FROM MOVIE 
LEFT OUTER JOIN (SELECT * FROM GENRE_OF, GENRE WHERE gen = Genre_id AND Genre = 'Action' OR Genre = 'Comedy') AS G 
ON Movie_id = mid WHERE Rating IS NOT NULL ORDER BY Rating DESC LIMIT 1;
--Q9
SELECT count(*) AS num_Tv_series 
FROM (SELECT count(*) AS c, pid FROM EPISODE GROUP BY pid) AS T 
WHERE T.c > 5; 
--Q10
SELECT First_name, Last_name FROM ACCOUNT WHERE NOT EXISTS(SELECT NULL FROM RATING WHERE Account_id = uid) 
ORDER BY birthday ASC LIMIT 1;
--Q11
SELECT count(*) AS num_user FROM ACCOUNT ,(SELECT count(*) AS num_rating, uid FROM RATING GROUP BY uid) AS T
WHERE Account_id = T.uid AND T.num_rating = 1 AND Job IS NOT NULL;
--Q12