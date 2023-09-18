/*use movies
1.1
select name
from starsin
join moviestar on starname = name
where gender = 'F'
	and movietitle = 'Terms of Endearment';

1.2
select name
from STARSIN
join MOVIESTAR on STARNAME=name
join movie on MOVIETITLE = title and MOVIEYEAR = year 
where STUDIONAME = 'MGM' and year=1995

//same

select distinct starname
from starsin
join movie on movietitle = title
	and movieyear = year
where studioname = 'MGM' and movieyear = 1995;*/


/*use pc;

2.1
select maker,speed
from product
join laptop on product.model=laptop.model
where hd >=9

2.2
(select p.model, price
from product p
join laptop on p.model=laptop.model
where maker='B')
union
(select p.model, price
from product p
join pc on p.model=pc.model
where maker='B')
union
(select p.model, price
from product p
join printer on p.model=printer.model
where maker='B')

order by price desc;

2.3
select distinct p1.hd
from pc p1
join pc p2 on p1.hd=p2.hd
where p1.hd=p2.hd and p1.code!=p2.code;

2.4
select distinct p1.model,p2.model
from pc p1
join pc p2 on p1.speed=p2.speed and p1.ram=p2.ram
where p1.model < p2.model;

2.5!!!!!!!pitai
select p1.maker,p2.maker
from product p1,product p2
join pc l on product.model=l.model*/

use ships;
/*3.1
select name
from ships
join CLASSES on ships.class=CLASSES.class
where DISPLACEMENT>35000;

3.2
select name,numguns,displacement
from OUTCOMES
join ships on ship=name
join CLASSES on ships.CLASS = CLASSES.CLASS
where battle='Guadalcanal'

3.3
select country
from CLASSES
where type='bb' 
Intersect
select country
from CLASSES
where type='bc';

same
select distinct c1.country
from classes c1
join classes c2 on c1.country = c2.country
where c1.type = 'bb' and c2.type = 'bc';*/


//!!!!! wij q otnowo
select distinct o1.ship
from outcomes o1
join ships on o1.ship=name.ships
where result='damaged'





