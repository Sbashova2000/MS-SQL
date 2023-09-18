/*use ships;
select country, name
from classes
join ships on classes.class = ships.class
left join outcomes on name = ship
where outcomes.ship is null;
*/
/*use movies;
1.1
select title, year, studioname, address
from movie
join studio on studioname =name
where length>120

1.2
select distinct studioname,starname
from movie
join starsin on MOVIETITLE = title and MOVIEYEAR = year
order by studioname

1.3
select distinct name
from MOVIEEXEC
join movie on PRODUCERC#=CERT#
join starsin on MOVIETITLE=title and MOVIEYEAR =year
where starname='Harrison Ford';

select name // imeto na producentite
from MOVIEEXEC

1.4
select starname
from starsin
join MOVIESTAR on starname=name
join movie on MOVIETITLE=title and MOVIEYEAR=year
where gender='F' and studioname='MGM';

1.5
select name,title
from MOVIEEXEC
join movie on PRODUCERC#=CERT#
where name in(select name 
			  from MOVIEEXEC
			  join movie on PRODUCERC#=CERT#
			  where title='Star Wars');

1.6			  
select name
from MOVIESTAR
where name not in(select starname from starsin);

select name
from moviestar
left join starsin on starname=name
where starname is null;
*/

/*use pc;

2.1
select distinct product.model,price
from product
left join pc on product.model=pc.model
where product.type='PC'

2.2
select maker,model,type
from product
where model not in(select model from pc)
			and model not in(select model from printer)
			and model not in(select model from laptop);

select maker,p.model,type
from product p
left join(select model from pc union all select model from printer union all select model from laptop)t
on p.model=t.model
where t.model is null;
*/
 

use ships;
/*
3.1
select name,country,numguns,launched
from ships
join CLASSES on SHIPS.class=CLASSES.class

3.2
select ship
from outcomes
join battles on battle=name
where year(date)=1942;
*/