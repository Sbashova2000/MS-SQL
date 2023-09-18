use movies;


/*1.Без повторение заглавията и годините на всички филми, заснети преди 1982, в които е играл
поне един актьор (актриса), чието име не съдържа нито буквата 'k', нито 'b'. Първо да се изведат
най-старите филми.

select distinct movietitle,movieyear
from starsin
where MOVIEYEAR < 1982 and starname not like '%k%' and starname not like '%b%'
order by MOVIEYEAR 

select title,year
from movie
left join STARSIN on MOVIETITLE=TITLE and MOVIEYEAR=YEAR
where year <1982 and STARNAME not like '%[kb]%'
order by year

2. Заглавията и дължините в часове (length е в минути) на всички филми, които са от същата
година, от която е и филмът Terms of Endearment, но дължината им е по-малка или неизвестна

select title, length/60 as hrs
from movie
where year =(select year from movie where title='Terms of Endearment')  and length <= (select length from movie
																						where title='Terms of Endearment')or length is null

3. Имената на всички продуценти, които са и филмови звезди и са играли в поне един филм
преди 1980 г. и поне един след 1985 г

use movies;
select name
from MOVIESTAR
join starsin on starname=name
where name in (select starname from starsin) and MOVIEYEAR < 1980 
-- MOVIEYEAR > 1985


4.Всички черно-бели филми, записани преди най-стария цветен филм (InColor='y'/'n') на същото
студио.

select title
from MOVIE m1
where INCOLOR ='N' and year <(select min(year)
								from MOVIE m2
								where INCOLOR='Y' and m1.STUDIONAME=m2.STUDIONAME)


5. Имената и адресите на студиата, които са работили с по-малко от 5 различни филмови звезди1
Студиа, за които няма посочени филми или има, но не се знае кои актьори са играли в тях, също
да бъдат изведени. Първо да се изведат студиата, работили с най-много звезди.
1напр. ако студиото има два филма, като в първия са играли A, B и C, а във втория - C, D и Е, то
студиото е работило с 5 звезди общо
							

select studioname, address
from MOVIE
left join studio on studioname=name
left join starsin on MOVIETITLE=title and MOVIEYEAR=year
group by studioname,address
having count(distinct STARNAME)<5
order by count(distinct  starname) desc;

12. За всеки актьор/актриса изведете броя на различните студиа, с които са записвали филми.

select starname,count(distinct studioname)
from starsin
left join movie on MOVIETITLE=title and MOVIEYEAR=year
group by starname;

13. За всеки актьор/актриса изведете броя на различните студиа, с които са записвали филми,
включително и за тези, за които нямаме информация в какви филми са играли.

select name,count(distinct studioname)
from MOVIESTAR 
left join starsin on starname=name
left join movie on MOVIETITLE=title and MOVIEYEAR=year
group by name;

14. Изведете имената на актьорите, участвали в поне 3 филма след 1990 г.

select starname
from starsin
where MOVIEYEAR>1990
group by STARNAME
having count(MOVIETITLE)>=3;
*/

use ships;

/*6. За всеки кораб, който е от клас с име, несъдържащо буквите i и k, да се изведе името
на кораба и през коя година е пуснат на вода (launched). Резултатът да бъде сортиран
така, че първо да се извеждат най-скоро пуснатите кораби.

select name,launched
from ships
where class not like'%i%' and class not like '%k%'
order by launched desc;

7. Да се изведат имената на всички битки, в които е повреден (damaged) поне един
японски кораб.

select battle
from outcomes
left join ships on ship=name
left join CLASSEs on classes.class=ships.class
where result='damaged' and country = 'Japan'

8. Да се изведат имената и класовете на всички кораби, пуснати на вода една година след
кораба 'Rodney' и броят на оръдията им е по-голям от средния брой оръдия на
класовете, произвеждани от тяхната страна.

select  name,class
from ships
where launched -1=(select launched from ships where name='Rodney')

9. Да се изведат американските класове, за които всички техни кораби са пуснати на вода
в рамките на поне 10 години (например кораби от клас North Carolina са пускани в
периода от 1911 до 1941, което е повече от 10 години, докато кораби от клас Tennessee
са пуснати само през 1920 и 1921 г.).


select classes.class
from classes
join ships on ships.class=classes.class
where country='USA' 
group by classes.class
having max(launched) - min(launched) >=10;

10. За всяка битка да се изведе средният брой кораби от една и съща държава (например в
битката при Guadalcanal са участвали 3 американски и един японски кораб, т.е.
средният брой е 2).

select battle,count(ship)/count(distinct country)
from outcomes
left join ships on ship=name
left join CLASSES c on c.class=ships.class
group by battle;

11. За всяка държава да се изведе: броят на корабите от тази държава; броя на битките, в
които е участвала; броя на битките, в които неин кораб е потънал ('sunk') (ако някоя от
бройките е 0 – да се извежда 0).

select c.country, count(ships.name),count(o1.battle),count(o2.result)
from classes c
left join ships on  c.class=ships.class
left join outcomes o1 on  o1.ship=name
left join outcomes o2 on  o2.ship=name and o2.result='sunk'
group by country;

16. Изведете броя на потъналите американски кораби за всяка проведена битка с поне един
потънал американски кораб.

select battle, count(ship)
from outcomes
left join ships on ship=name
left join CLASSES on CLASSES.class=ships.class and result = 'sunk'
where country='USA'
group by battle;

//same

select BATTLE, count(result)
from OUTCOMES	
left join SHIPS on ships.NAME=OUTCOMES.SHIP
left join CLASSES on ships.CLASS=CLASSES.CLASS
where RESULT='sunk' and COUNTRY='USA'
group by BATTLE

--17. Битките, в които са участвали поне 3 кораба на една и съща страна.

select battle
from OUTCOMES
left join SHIPS on ships.NAME=OUTCOMES.SHIP
left join CLASSES on ships.CLASS=CLASSES.CLASS
group by battle,country
having count(ship)>=3;

18. Имената на класовете, за които няма кораб, пуснат
на вода след 1921 г., но имат пуснат поне един кораб.


select class
from ships
where launched not in(select launched from ships where launched > 1921)
group by class;

select class
from ships
group by class
having max(launched) <=1921;

19. (*) За всеки кораб намерете броя на битките, в които е бил увреден. Ако корабът не е
участвал в битки или пък никога не е бил увреждан, в резултата да се вписва 0.


select name, count(battle)
from ships
left join outcomes on ship=name  and result='damaged'
group by name;


20. Намерете за всеки клас с поне 3 кораба броя на корабите от този клас, които са победили
в битка.

select class, count(distinct name)
from ships
left join outcomes on ship=name and result='ok'
group by class
having count(distinct name)>=3;

*/










