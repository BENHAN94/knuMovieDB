
--Q1
SELECT count(*) AS num_account FROM ACCOUNT;

--Q2
SELECT First_name, last_name, address FROM ACCOUNT, ADMIN WHERE Account_id = uid;

--Q3
SELECT count(*) AS num_account FROM (SELECT count(*) AS uid FROM RATING GROUP BY uid HAVING uid > 5) AS T; 

--Q4
SELECT count(*) AS num_movie FROM MOVIE LEFT OUTER JOIN (
	SELECT * FROM GENRE JOIN GENRE_OF ON gen = Genre_id where Genre = 'Romance') as g 
on mid = Movie_id where date_part('year', Start_year) = 2020;

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

--Q12 (모든 배우를 대상으로) 작업한 모든 영상물의 평균 평점이 8 점 이상인 배우의 이름은 무엇인가?
SELECT Actor_name FROM ACTOR AS A WHERE
NOT EXISTS(SELECT * FROM MOVIE AS B,ACTOR_OF AS C WHERE B.Movie_id=C.mid AND A.Actor_id = C.aid AND 
	NOT EXISTS(SELECT * FROM MOVIE AS D WHERE B.Movie_id = D.Movie_id AND D.Rating >= 8));
--Q13 
SELECT DISTINCT Actor_name, Original_title FROM MOVIE, ACTOR_OF AS A, ACTOR, GENRE, GENRE_OF AS G 
WHERE A.mid=Movie_id AND A.aid=Actor_id AND G.gen=Genre_id AND G.mid = Movie_id 
AND Genre != 'Action' AND Rating < 6 AND Type = 'movie' AND date_part('year',start_year)>=2010;

--Q14
select count(*) from movie,(select MAX(date_part('year',birthday)) as YOUTH 
	from account,membership where sid = Membership_id AND membership_name = 'prime') as Y where date_part('year',start_year)=Y.YOUTH;

--Q15
select max(start_year) from (select uid, count(*) as R from membership,rating, movie, account 
	where sid=Membership_id AND Membership_name = 'premium' 
	AND mid = movie_id AND rating<8 AND type != 'tvSeries' group by uid) as F, movie;

--Q16
SELECT Phone 
FROM ACCOUNT AS A, (SELECT uid FROM RATING, MOVIE WHERE mid=Movie_id AND Rating = (SELECT max(Rating) FROM MOVIE))AS T
WHERE uid=A.Account_id AND length(A.Address) = (SELECT max(length(B.Address)) FROM ACCOUNT AS B);

--Q17 
select count(*) from movie as Q,(SELECT Movie_id, MIN(Start_year), rating FROM MOVIE, ACTOR_OF AS A,
(SELECT (ROW_NUMBER() OVER(ORDER BY num_filmed DESC)) AS ROW, * FROM
(SELECT num_filmed, aid FROM
(SELECT count(*) AS num_filmed,aid FROM ACTOR_OF GROUP BY aid ORDER BY num_filmed LIMIT 10) AS T1) AS T2
) AS T3 WHERE ROW = 3 AND T3.aid = A.aid AND A.mid = Movie_id 
group by movie_id) as T4 where Q.rating<T4.rating+1 AND Q.rating>T4.rating-1;

--Q18


SELECT M.Rating FROM MOVIE AS M,
(SELECT count(*) AS num_version,M2.Movie_id as m2id FROM MOVIE AS M2, VERSION WHERE M2.Movie_id=mid GROUP BY M2.Movie_id) AS T1,
(SELECT count(*) AS num_actor, M3.Movie_id as m3id FROM MOVIE AS M3, ACTOR_OF WHERE M3.Movie_id=mid GROUP BY M3.MOVIE_ID) AS T2, 
(SELECT M4.Movie_id FROM MOVIE AS M4 WHERE M4.Type = 'movie' OR M4.Type = 'tvSeries') AS T3
WHERE M.Movie_id = m2id 
AND M.Movie_id = m3id AND num_version >= 5 AND num_version <= 10 AND num_actor <= 5 AND M.Movie_id = T3.Movie_id;
--Q19
--Q20 

