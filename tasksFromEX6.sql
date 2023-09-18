use ships;

/*5. Изведете броя на потъналите американски кораби за 
-- всяка проведена битка с поне един потънал американски
-- кораб.

select battle,count(battle)
from ships
left join CLASSES c on c.class=ships.class
left join outcomes on ship =name
where country='USA' and result='sunk'
group by battle;

 6. Битките, в които са участвали поне 3 кораба на 
една и съща страна.

select distinct battle
from outcomes
left join ships on ship=name
left join CLASSES c on c.class=ships.class
group by battle,country
having count(ship)>=3;

6.a) За всеки клас да се изведе името му, държавата и първата година, 
 в която е пуснат кораб от този клас

select classes.class, country,min(launched) as firstYear
from CLASSES
join ships on CLASSES.class=ships.class
group by classes.class,country

6.b) За всеки клас с кораби - името на класа, името на произволен кораб и
брой кораби
select class,max(name),count(name)
from ships
group by class;

7. Имената на класовете, за които няма кораб, пуснат
на вода след 1921 г., но имат пуснат поне един кораб.
select class
from ships
group by class
having max(LAUNCHED)<1921;

8. За всеки кораб да се изведе броят на битките, в които е бил увреден.
Ако корабът не е участвал в битки или пък никога не е бил
увреждан, в резултата да се вписва 0.

select name,count(battle)
from ships
left join outcomes on ship=name and result='damaged'
group by name

8.1. За всяка държава да се изведе броят на корабите и броят на 
потъналите кораби.
Всяка от бройките може да бъде и нула.

select country,count(ships.name),count(outcomes.ship)
from classes
left join ships on CLASSES.class=ships.class
left join outcomes on ship=name and result='sunk'
group by country;

8.2. За всяка държава да се изведе броят на повредените кораби и броят на 
потъналите кораби. Всяка от бройките може да бъде и нула.

select country,count(distinct damaged.ship),count(distinct sunk.ship)
from classes
left join ships on CLASSES.class=ships.class 
left join outcomes damaged on damaged.ship=name and damaged.result='damaged'
left join outcomes sunk on sunk.ship=name and sunk.result='sunk'
group by country;

9. Намерете за всеки клас с поне 3 кораба броя на корабите от този клас, 
които са с резултат ok.

select class,count(distinct ship)
from ships
left join outcomes on ship=name and  result='ok'
group by class
having count(distinct name)>=3;
*/

use movies;
/* За всяка филмова звезда да се изведе името, рождената дата и с кое
студио е записвала най-много филми. (Ако има две студиа с еднакъв 
брой филми, да се изведе кое да е от тях)

select name,birthdate,(select top 1 studioname
						from movie
						join starsin on MOVIETITLE=title and MOVIEYEAR=year
						where starname=name
						group by studioname
						order by count(*)desc) studioname
from moviestar;*/
use pc;
/*
Намерете за всички производители на поне 2 лазерни
принтера, броя на произвежданите от тях PC-та (конкретни
конфигурации), евентуално 0.

select maker,count(pc.code)
from product
left join pc on product.model=pc.model
where maker in(select maker from product 
				join printer on product.model=printer.model 
				where printer.type='Laser'
				group by maker
				having count(*)>=2)
group by maker;


select maker,count(pc.code)
from product
left join pc on product.model=pc.model
group by maker
having maker in(select maker from product 
				join printer on product.model=printer.model 
				where printer.type='Laser'
				group by maker
				having count(*)>=2);

select maker,(select count(*)
			  from product p1
			  join pc on p1.model=pc.model and p1.maker=p.maker)
from product p
join printer on p.model=printer.model
where printer.type='Laser'
group by maker
having count(*) >= 2;

Dа се изведат всички производители,за които средната цена
на произведените компютри е по-ниска от средната цена на техните лаптопи:

select maker
from product p
join pc on p.model=pc.model
group by maker
having avg(price) < (select avg(price) from product
					join laptop on product.model=laptop.model
					where  maker=p.maker);

Един модел компютри може да се предлага в няколко конфигурации 
с евентуално различна цена. Да се изведат тези модели компютри,
чиято средна цена (на различните му конфигурации) е по-ниска
 от най-евтиния лаптоп, произвеждан от същия производител.
 
select pc.model
from pc
join product p on pc.model=p.model
group by pc.model,p.maker
having avg(price)<(select min(price) from laptop
					join product t on laptop.model=t.model
					where t.maker=p.maker);

Всички модели компютри, за които разликата в размера на
най-големия и най-малкия харддиск е поне 20 GB.


select model
from pc
group by model
having max(hd)-min(hd) >=20;
 */
use ships;
/*Да се изведат имената на корабите, които са участвали в битки в
продължение поне на две години.
select ship
from outcomes
join battles on battle=name
group by ship
having year(max(date))-year(min(date)) >=1;

За всяка година, в която е проведена битка, да се изведе броят на
корабите, пуснати на вода през тази година

select year(date), count(distinct ships.name)
from battles
left join ships on year(date)=launched
group  by year(date);*/



