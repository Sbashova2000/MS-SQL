SET SCHEMA DB2MOVIE;

-- 07.09.2022
-- 1) Да се напише заявка, която извежда заглавията и дължините в минути на всички
-- цветни филми без най-дългия цветен и без тези с неизвестна дължина. Ако има няколко
-- филма с максимална дължина,нито един от тях не трябва да бъде изведен.

-- I
SELECT TITLE, LENGTH
FROM MOVIE
WHERE INCOLOR = 'Y'
AND LENGTH IS NOT NULL
AND LENGTH <> (SELECT MAX(LENGTH) FROM MOVIE WHERE INCOLOR = 'Y');

-- IS NULL, IS NOT NULL
-- >, <, <>, =, != ..... NULL (UNKNOWN)
-- TRUE 2 > 1
-- FALSE 2 < 1
-- UNKNOWN 2 < NULL

-- II
SELECT TITLE, LENGTH
FROM MOVIE
WHERE INCOLOR = 'Y'
AND LENGTH < (SELECT MAX(LENGTH) FROM MOVIE WHERE INCOLOR = 'Y');

-- III
SELECT TITLE, LENGTH
FROM MOVIE
WHERE INCOLOR = 'Y'
AND LENGTH IS NOT NULL
EXCEPT ALL -- EXCEPT
SELECT TITLE, LENGTH
FROM MOVIE
WHERE INCOLOR = 'Y'
AND LENGTH = (SELECT MAX(LENGTH) FROM MOVIE WHERE INCOLOR = 'Y');

-- UNION , UNION ALL
-- INTERSECT, INTERSECT ALL
-- EXCEPT, EXCEPT ALL


--- GROUP BY COL1, SELECT COL1, + AVG, MIN, MAX, COUNT...

-- 2) Да се посочи коя от следните заявки извежда имената на тези студиа,
-- които нямат филми или са снимали филми само в една единствена година:

-- FROM T1 INNER JOIN T2 ON T1.COL1=T2.COL1;
-- FROM T1 JOIN T2 ON T1.COL1=T2.COL1;
-- FROM T1, T2 WHERE T1.COL1=T2.COL1;

-- FROM T1 LEFT OUTER JOIN T2 ON T1.COL1=T2.COL1;
-- FROM T1 LEFT JOIN T2 ON T1.COL1=T2.COL1;
-- FROM T1 RIGHT OUTER JOIN T2 ON T1.COL1=T2.COL1;
-- FROM T1 FULL OUTER JOIN T2 ON T1.COL1=T2.COL1;

SELECT NAME, TITLE, YEAR
FROM STUDIO LEFT JOIN MOVIE ON NAME = STUDIONAME
WHERE TITLE IS NULL;

-- В)
SELECT NAME, COUNT(DISTINCT YEAR)
FROM STUDIO LEFT JOIN MOVIE ON NAME = STUDIONAME
GROUP BY NAME
HAVING COUNT(DISTINCT YEAR) <=1;

-- 12.07.2022
-- 1) Да се попълнят празните места в следната заявка така, че тя да извежда името
-- на студиото на филма The Usual Suspects и заглавията на всички филми
-- на същото студио:

SELECT s.name, m.title
FROM movie m JOIN studio s ON m.studioname = s.name
WHERE s.name IN (SELECT studioname
                   FROM movie
                   WHERE title = 'The Usual Suspects' AND year = 1995);

-- 2) Да се посочи коя от следните заявки извежда имената на филмовите звезди,
-- за които няма информация в кои филми са играли

-- Б)
SELECT ms.name, si.movietitle
FROM moviestar ms
LEFT JOIN starsin si
ON ms.name=si.starname
WHERE si.movietitle IS NULL;

-- II
SELECT NAME
FROM MOVIESTAR
EXCEPT ALL
SELECT STARNAME
FROM STARSIN;

-- 08.09.2021
-- 1)
-- В)
SELECT studioName
FROM Movie
WHERE inColor = 'Y'
INTERSECT
SELECT studioName
FROM Movie
WHERE length IS NULL;

-- 2)
-- Б)
SELECT name, COUNT(title)
FROM MovieStar
LEFT JOIN StarsIn ON name = starName
LEFT JOIN Movie
ON movieTitle = title
AND movieYear = year
AND inColor = 'N'
WHERE gender = 'F'
GROUP BY name;

-- 13.07.2021

SET SCHEMA DB2PC;
-- USE PC;
-- 1)
-- A)
SELECT code, price FROM Laptop
WHERE screen BETWEEN 13 AND 15
AND ram IN (SELECT ram FROM PC);

--2)
-- В)
SELECT maker, COUNT(code) FROM Laptop
RIGHT JOIN Product
ON Laptop.model = Product.model
AND screen = 15
GROUP BY maker;

-- 16.09.2020

SET SCHEMA DB2MOVIE;
-- 1)
-- I
SELECT S.NAME, S.ADDRESS
FROM STUDIO S, MOVIE M
WHERE S.NAME = M.STUDIONAME
AND M.INCOLOR = 'Y'
INTERSECT
SELECT S.NAME, S.ADDRESS
FROM STUDIO S, MOVIE M
WHERE S.NAME = M.STUDIONAME
AND M.INCOLOR = 'N'
ORDER BY 2;

-- II
SELECT DISTINCT S.NAME, S.ADDRESS
FROM STUDIO S, MOVIE M
WHERE S.NAME = M.STUDIONAME
AND M.INCOLOR = 'Y'
AND NAME IN (SELECT STUDIONAME FROM MOVIE WHERE INCOLOR = 'N')

-- 2)
SELECT S.NAME, S.ADDRESS, AVG(LENGTH) AS AVG_LEN, COUNT(TITLE) AS CNT
FROM STUDIO S LEFT JOIN MOVIE M ON S.NAME = M.STUDIONAME
GROUP BY S.NAME, S.ADDRESS
HAVING COUNT(TITLE) <= 3;

-- 05.08.2020
-- 1)

SELECT MS.NAME, MS.BIRTHDATE
FROM MOVIESTAR MS, STARSIN SI, MOVIE M
WHERE MS.NAME = SI.STARNAME AND SI.MOVIETITLE = M.TITLE
AND SI.MOVIEYEAR = M.YEAR
AND MS.NAME NOT LIKE '%Jr.%'
AND M.INCOLOR = 'Y'
ORDER BY MS.BIRTHDATE DESC, MS.NAME;

-- 2)

SELECT MS.NAME, YEAR(MS.BIRTHDATE) , COUNT(DISTINCT M.STUDIONAME)
FROM MOVIESTAR MS LEFT JOIN STARSIN SI ON MS.NAME = SI.STARNAME
LEFT JOIN MOVIE M ON M.TITLE = SI.MOVIETITLE AND M.YEAR = SI.MOVIEYEAR
WHERE MS.GENDER = 'F'
GROUP BY MS.NAME, MS.BIRTHDATE
HAVING COUNT(*) <= 6;

select name,min(year),max(year),count(title)
from studio
join movie on name=studioname
where name like 'M%'
group by name;


select name,count(title)
from MOVIESTAR
join STARSIN on name=STARNAME
join movie on movietitle=title and movieyear=year
where gender='f'
group by name;

use ships

select class,(year(min(date)),max(year(date)),count(distinct battle)
from ships
left join Outcomes on ship = ships.name
left join BATTLES on BATTLE=battles.name
where class like 'N%'
group by class;


select battle
from outcomes





