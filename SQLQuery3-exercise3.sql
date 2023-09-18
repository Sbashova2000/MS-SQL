/*use movies;

1.1
select name 
from MOVIESTAR
where gender='F' and name in (select name from MOVIEEXEC where NETWORTH > 10000000)


-- може и select name from movieexec where name in (select name from moviestar...)

-- можеше и с intersect
(select name
from moviestar
where gender = 'F')
intersect
(select name
from movieexec
where networth > 10000000);

1.2
select name
from moviestar where name not in(select name from MOVIEEXEC);

-- може и с except: select name from moviestar except select name from movieexec;
*/


/*use pc;

2.1
select distinct maker
from product 
where model in (select model from pc where speed >=500);

2.2
select*
from laptop 
where speed < All(select speed from pc);

2.3
select distinct model
from (select model,price from printer union all select model,price from pc union all select model,price from laptop)prices
where price >= All(select price
					from pc
					union all
					select price
					from laptop
					union all
					select price
					from printer);
2.4
select distinct maker
from product
where model in(select model from printer where color='y' 
and price <= all(select price from printer where color='y'));

2.5
select distinct maker
from product 
where model in(select model from pc where ram<=all(select ram from pc)
and speed >= all(select speed from pc where ram<= all(select ram from pc)));
*/

use ships;

/*
3.1
select distinct country
from CLASSES 
where numguns >= all(select numguns from classes);

3.2
select name
from ships
where class in(select class from classes where bore=16);

3.3
select  battle
from outcomes
where ship in (select name from ships where class='Kongo');
*/

select name
from ships s
join CLASSES c on s.class=c.class
where numguns >= all(select numguns from classes c2 where c2.bore=c.bore);
