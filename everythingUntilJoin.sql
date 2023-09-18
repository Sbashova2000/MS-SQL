use movies

SELECT address
FROM STUDIO 
WHERE name='MGM'

SELECT starname
FROM starsin
WHERE movieyear=1980 and movietitle like '%Empire%'

use pc

SELECT model, price / 1.1
FROM laptop
order by price

select *
from pc
where (cd='12x' or cd='16x') and price < 2000

select code, model, speed + ram + 10*screen as score
from laptop
order by score desc, code

use ships

select *
from ships
where name = class

select name
from ships
where name like '% %' and name not like '% % %'

use movies

select distinct starname
from movie join starsin on title = movietitle and movieyear = year
where studioname = 'MGM' and year = 1995

use pc

select product.model, price
from product
	 join laptop on product.model = laptop.model
where maker = 'B'

UNION

select product.model, price
from product
	 join pc on product.model = pc.model
where maker = 'B'

UNION

select product.model, price
from product
	 join printer on product.model = printer.model
where maker = 'B'

order by price desc

select distinct *
from pc p
where hd in (select hd 
			 from pc
			 where p.code != code)

select *
from pc p
where exists (select code
			 from pc
			 where p.hd = hd and p.speed = speed and p.code != code)

select distinct *
from pc p1
join pc p2 on p1.speed = p2.speed and p1.hd = p2.hd
where p1.model < p2.model;

use ships

select *
from classes 
	 join ships on classes.CLASS = ships.class
	 join OUTCOMES on ship = NAME
where battle = 'Guadalcanal'

select distinct country
from classes
where type = 'bb' and  country in (select country
								 from classes
								 where type = 'bc')

select ship
from outcomes o
join battles b on battle = name
where result = 'damaged' and ship in (select ship
									  from outcomes
									  join battles on battle = name
									  where b.date < date)

use movies

select *
from movieexec

select name
from moviestar
where gender = 'F' and name in (select name
			   from movieexec
			   where NETWORTH > 10000000)

select name
from moviestar
where name not in (select name
			   from movieexec)

use pc

select *
from laptop
where speed < all (select speed from pc)

select top 1 model
from(
select model, price
from laptop
union
select model, price
from pc
union
select model, price
from printer) n
order by price desc


use ships

select distinct country
from classes c
where numguns >= all (select numguns from classes)

select battle
from ships
join outcomes on ship = name
where class = 'Kongo'

select *
from ships s
join classes c on s.class = c.class
where numguns >= all (select numguns
					  from classes
					  where bore = c.bore)

use movies

SELECT ms.name, me.name,
 ms.birthdate, me.networth
FROM moviestar ms
FULL JOIN movieexec me ON ms.name = me.name;

use ships

select country, name
from classes
join ships on classes.class = ships.class
left join outcomes on name = ship
where outcomes.ship is null;

select country, name
from outcomes
right join ships on ship = name
join classes on classes.class = ships.class
where outcomes.ship is null;
