--use movies;

/*
1.Без повторение заглавията и годините на всички филми, заснети преди 1982, в
които е играл поне един актьор (актриса), чието име не съдържа нито буквата 'k',
нито 'b'. Първо да се изведат
най-старите филми.

select distinct movietitle,movieyear
from STARSIN
where MOVIEYEAR < 1982 and starname not like '%k%' and starname not like '%b%'
order by MOVIEYEAR;

select title,year
from MOVIE
join STARSIN on  MOVIETITLE = title and MOVIEYEAR=year
where MOVIEYEAR < 1982 and starname not like '%[kb]%' 
order by  YEAR asc;

2. Заглавията и дължините в часове (length е в минути) на всички филми, които
са от същата година, от която е и филмът Terms of Endearment, но дължината им е
по-малка или неизвестна.

select title, length/60 as hs
from MOVIE
where year in (select year
				from movie
				where title like 'Terms of Endearment') and LENGTH < (select LENGTH
																	 from movie
																	 where title like 'Terms of Endearment') or LENGTH is Null;


3. Имената на всички продуценти, които са и филмови звезди и са играли в поне един
филм преди 1980 г. и поне един след 1985 г

select name
from MOVIESTAR
join STARSIN on starname=name
where name in (select starname from starsin) and movieyear<1980


4. Всички черно-бели филми, записани преди най-стария цветен филм (InColor='y'/'n')
на същото студио.

										
select title
from MOVIE m1
where INCOLOR = 'n' and year < (select min(year) 
								from MOVIE m2
	 						where INCOLOR = 'y' and m1.STUDIONAME = m2.STUDIONAME);




5. Имената и адресите на студиата, които са работили с по-малко от 5 различни филмови звезди
Студиа, за които няма посочени филми или има, но не се знае кои актьори са играли в тях, също
да бъдат изведени. Първо да се изведат студиата, работили с най-много звезди.
1напр. ако студиото има два филма, като в първия са играли A, B и C, а във втория - C, D и Е, то
студиото е работило с 5 звезди общо


select studioname,address
from movie
left join studio on studioname = name
left join starsin on movietitle=title and movieyear=year
group by studioname,address
having count(distinct starname) <5
order by count(distinct starname) desc;

use ships

6. За всеки кораб, който е от клас с име, несъдържащо буквите i и k, да се изведе името
на кораба и през коя година е пуснат на вода (launched). Резултатът да бъде сортиран
така, че първо да се извеждат най-скоро пуснатите кораби.


select name,LAUNCHED
from SHIPS 
where class not like '%[ik]%'
order by launched desc;


7. Да се изведат имената на всички битки, в които е повреден (damaged) поне
един японски кораб.

I
select battle
from outcomes
where ship in(select name
			  from ships
			  where class in (select class
							 from classes
							 where COUNTRY = 'Japan')
			  ) 
and result='damaged';

II
select battle
from outcomes
join ships on ship = name
join CLASSES on classes.class=ships.class
where COUNTRY = 'Japan' and result='damaged';



8. За всеки кораб да се изведе броят на битките, в които е бил увреден.
Ако корабът не е участвал в битки или пък никога не е бил
увреждан, в резултата да се вписва 0.

I
select name,count(battle)
from ships
left join outcomes on ship=name and result='damaged'
group by name
II
select name, count(case when result = 'damaged' then 1 else null end)
from ships
left join outcomes on ship = name
group by name

8.1. За всяка държава да се изведе броят на корабите и 
броят на потъналите кораби.Всяка от бройките може да бъде
и нула.


I
select country,count(ship), count(case when result='sunk' then 1 else 0 end)
from classes
left join ships on CLASSES.class =  ships.class
left join OUTCOMES on ship=name
group by country;

II
select country,count(ships.name),count(outcomes.ship)
from classes
left join ships on CLASSES.class=ships.class
left join outcomes on ship=name and result='sunk'
group by country;


8.2. За всяка държава да се изведе броят на повредените кораби 
и броят на потъналите кораби. Всяка от бройките може да 
бъде и нула.

I
select distinct  country,count(case when result='damaged' then 1 else null end),count(case when result='sunk' then 1 else null end)
from CLASSES
left join ships on CLASSES.class =  ships.class
left join OUTCOMES on ship=name
group by country;

II
select country,count(distinct damaged.ship),count(distinct sunk.ship)
from classes
left join ships on CLASSES.class=ships.class 
left join outcomes damaged on damaged.ship=name and damaged.result='damaged'
left join outcomes sunk on sunk.ship=name and sunk.result='sunk'
group by country;

!
8.3 Да се изведат имената и класовете на всички кораби,
пуснати на вода една година след кораба 'Rodney' и броят на 
оръдията им е по-голям от средния брой оръдия на
класовете, произвеждани от тяхната страна.


select  name,ships.class
from ships
join classes c on ships.class=c.class
where launched = 1 + (select launched
					  from ships
					  where name like 'Rodney')
	 and numguns > (select avg(numguns)
					from classes
					where country = c.country);


9. Намерете за всеки клас с поне 3 кораба броя на корабите от
този клас, които са с резултат ok.

I
select class,count(case when result='ok' then 1 else null end)
from ships
left join outcomes on ship=name
group by class
having count(distinct name) >=3;

II
select class,count(distinct ship)
from ships
left join outcomes on ship=name and  result='ok'
group by class
having count(distinct name)>=3;

9.1 Да се изведат американските класове, за които всички техни
кораби са пуснати на вода в рамките на поне 10 години
(например кораби от клас North Carolina са пускани в
периода от 1911 до 1941, което е повече от 10 години, докато
кораби от клас Tennessee са пуснати само през 1920 и 1921 г.).

select c.class
from classes c
join ships on c.class=ships.CLASS
where  country = 'USA'
group by c.class
having  max(launched) - min(launched) >=10;
*/

10. За всяка битка да се изведе средният брой кораби от една и съща
държава (например в битката при Guadalcanal са участвали 3 
американски и един японски кораб, т.е.средният брой е 2).

select BATTLE,avg(ship)
from outcomes
join ships on ship = name
join CLASSES on CLASSES.class = SHIPS.class

/*
11. За всяка държава да се изведе: броят на корабите от тази
държава; броя на битките, в които е участвала; броя на битките,
в които неин кораб е потънал ('sunk') (ако някоя от
бройките е 0 – да се извежда 0).

I
select country,count(name),count(battle),count(case when result='sunk' then 1 else null end)
from classes
left join ships on ships.class=classes.class
left join outcomes on ship = name
group by country;

II
select c.country, count(ships.name),count(o1.battle),count(o2.result)
from classes c
left join ships on  c.class=ships.class
left join outcomes o1 on  o1.ship=name
left join outcomes o2 on  o2.ship=name and o2.result='sunk'
group by country;

*/

use movies;
12. За всеки актьор/актриса изведете броя на различните студиа,
с които са записвали филми.

select starname,count(distinct studioname)
from STARSIN
join movie on MOVIETITLE = title and MOVIEYEAR = year
group by starname;

13. За всеки актьор/актриса изведете броя на различните студиа,
с които са записвали филми,включително и за тези, за които 
нямаме информация в какви филми са играли

select name,count(distinct studioname)
from MOVIESTAR
left join STARSIN on starname=name
left join movie on MOVIETITLE = title and MOVIEYEAR = year
group by name;

14. Изведете имената на актьорите, участвали в поне 3 филма 
след 1990 г

select * 
from starsin
where MOVIEYEAR > 1990
group by starname
having count(MOVIETITLE) >=3;


use pc;

15. Да се изведат различните модели компютри, подредени по цена
на най-скъпия конкретен компютър от даден модел

select distinct model,price
from pc
order by price desc;

16. Изведете броя на потъналите американски кораби за всяка 
проведена битка с поне един потънал американски кораб.

use ships;

select count(case when result='sunk' then 1 else null end)
from outcomes
join ships on ship = name
join classes on classes.class=ships.class
where country='USA';

17. Битките, в които са участвали поне 3 кораба на една и съща
страна

select battle
from outcomes
join ships on ship = name
join classes on classes.class=ships.class
group by battle
having count(ship) >=3;

18. Имената на класовете, за които няма кораб, пуснат на вода
след 1921 г., но имат пуснат поне един кораб.

I
select class
from ships
where launched not in (select launched
						from ships
					    where launched > 1921)
group by class;

II ?
select class
from ships
group by class
having max(launched) < 1921;


19. (*) Намерете за всеки клас с поне 3 кораба броя на
корабите от този клас, които са победили в битка.

select class,count(case when result='ok' then 1 else null end)
from ships
left join outcomes on ship=name
group by class
having count(name) >=3;


