/*
use pc;
1.1
select avg(speed)
from pc;

1.2
select maker,avg(screen)
from product
join laptop on product.model=laptop.model
group by maker;

1.3
select avg(speed)
from laptop
where price > 1000;

1.4
select avg(price)
from pc
join product on product.model=pc.model
where maker='A';

1.5
select avg(price)
from(select price
	 from pc 
	 join product on product.model=pc.model
	 where maker='B'
		union all 
	 select price 
	 from laptop 
	 join product on product.model=laptop.model 
	 where maker='B' )LaptopPC;

select avg(price)
from
(
	select price
	from product p join pc
	on p.model=pc.model 
	where maker='B'

	union all

	select price
	from product p join laptop l
	on p.model=l.model 
	where maker='B'
) AllPrices;

1.6
select speed, avg(price)
from pc
group by speed;

1.7
select maker
from product
where type='PC'
group by maker
having count(*) >=3

1.8
Напишете заявка, която извежда производителите на компютрите с
най-висока цена.
select maker
from product
join pc on pc.model=product.model
where price = (select MAX(price) from pc);

1.9
select speed,avg(speed)
from pc
where speed > 800
group by speed

1.10
select avg(hd)
from pc 
join product p on p.model=pc.model
where maker in(select maker
				from product 
				where  type='Printer');

1.11
select screen,(MAX(price) - MIN(price))
from laptop
group by screen;

select*
from laptop
*/

use ships;
/*
2.1
select count(*)
from classes;

2.2
select avg(numguns)
from classes
join ships on ships.class=classes.class


2.3
select class, min(launched) as firstYear,max(launched) as lastYear
from ships
group by class;

select*
from ships

2.4
select class, count(ship)
from outcomes
join ships on ship=name
where result='sunk'
group by class;

-- 2.4. (не се включват класове без
-- потънали кораби)
select class, count(*)
from ships s 
join outcomes o on s.name=o.ship
where o.result='sunk'
group by class;

2.5
select class,count(name) --*
from ships
join outcomes on ship=name
where result='sunk' and class in(select class
								 from ships 
								 group by class
								 having count(*) > 4)		
group by class;

2.6
select country,avg(displacement)
from classes
group by country
*/