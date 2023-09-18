/*use ships;

task1
Имената и годините на пускане на всички кораби, които имат същото име като
своя клас.
select name, launched
from ships
where name=class;

task2
Имената на всички кораби, за които едновременно са изпълнени следните
условия:
(1) участвали са в поне една битка и
(2) имената им (на корабите)
започват с C или K

select distinct ship
from outcomes
join ships on ships.name=outcomes.ship
where name like'C%' or name like'K%' and battle is not null;

task3
Всички държави, които имат потънали в битка кораби
select  distinct country
from classes
join ships on ships.class=classes.CLASS
right join outcomes on ship=name
where result='sunk';

select  distinct country
from classes
join ships on ships.class=classes.CLASS
join outcomes on ship=name
where result='sunk';

select distinct country
from CLASSES
join ships on ships.class=classes.CLASS
where name in(select ship from OUTCOMES
				where result='sunk');

task4				
Всички държави, които нямат нито един потънал кораб.
select distinct country
from CLASSES
join ships on ships.class=classes.CLASS
where name is null or name not in(select ship from outcomes where result='sunk');

select distinct country
from CLASSES
join ships on ships.class=classes.CLASS
where name is null or name in(select ship from outcomes where result!='sunk');

task5
(От държавен изпит) Имената на класовете, за които няма кораб, пуснат на вода
(launched) след 1921 г. Ако за класа няма пуснат никакъв кораб, той също трябва
да излезе в резултата

select classes.class
from CLASSES
left join ships on CLASSES.class=ships.class and  launched > 1921
where name is null;

select class
from classes
where class not in(select class from ships where  launched > 1921);

task6
• Името, държавата и калибъра (bore) на всички класове кораби с 6, 8 или 10
оръдия. Калибърът да се изведе в сантиметри (1 инч е приблизително 2.54 см).
select class,country,bore*2.54 as boreCM
from CLASSES
where numguns=6 or numguns=8 or numguns=10

select class,country,bore*2.54 as boreCM
from CLASSES
where numguns in(6,8,10);

task7
Държавите, които имат класове с различен калибър (напр. САЩ имат клас с 14
калибър и класове с 16 калибър, докато Великобритания има само класове с 15).

select distinct c.country
from CLASSES c
join CLASSES c2 on c.COUNTRY = c2.Country
where c.bore!=c2.bore;

task7
Страните, които произвеждат кораби с най-голям брой оръдия (numguns).select distinct country
from CLASSES
where numguns >=all(select numguns from CLASSES);
*/

/*use movies;
task1
Всички филми, чието заглавие съдържа едновременно думите 'Star' и 'Trek' (не
непременно в този ред). Резултатите да се подредят по година (първо най-новите
филми), а филмите от една и съща година - по азбучен ред.

select* --title
from movie
where title like'%Star%' and title like'%Trek%'
order by year Desc , title;

task2
Заглавията и годините на филмите, в които са играли звезди, родени между
1.1.1970 и 1.7.1980.

select movietitle,movieyear
from starsin
join MOVIESTAR on starname=name
where BIRTHDATE>='1.1.1970' and  BIRTHDATE <='1.7.1980';
*/

use pc;
/*task1
Компютрите, които са по-евтини от всеки лаптоп на същия производител.

select*
from pc
join product p1 on pc.model=p1.model
where price < all (select price from laptop
					join product p2 on p2.model=laptop.model
					where p1.maker=p2.maker);

task2	
Компютрите, които са по-евтини от всеки лаптоп и принтер на същия
производител.
*/
select*
from pc
join product p on p.model=pc.model
where price < all(select price 
				  from laptop
				  join product p2 on p2.model=laptop.model
				  where p.maker=p2.maker)
				  and
				  price < all(select price 
								from printer
								join product p3 on p3.model=printer.model
								where p3.maker=p.maker);

