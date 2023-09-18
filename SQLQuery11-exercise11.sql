--use movies;

/*
1.1
create view mov_S
as
select name,birthdate 
from MOVIESTAR;

select*
from mov_S;

drop view mov_S;

select*
from mov_S;*/

/*
1.2
create view cntFilms
as
select name,count(movietitle) as cntMovies
from MOVIESTAR
left join STARSIN on starname=name
group by name;

select*
from cntFilms;

drop view cntFilms;*/

--use pc;


/*2.1
create view v_all_products
as 
	select code, model, price
	from pc
	union all
	select code, model, price
	from laptop
	union all
	select code, model, price
	from printer;

select*
from v_all_products;

drop view v_all_products;

2.2
alter view v_all_products
as
select code,model,price,'PC' as type from pc
union all
select code,model,price,'Laptop' as type from laptop
union all
select code,model, price,'Printer' as type from printer;

select*
from v_all_products;


2.3
alter view v_all_products
as
select code,model,price,'PC' as type,speed from pc
union all
select code,model,price,'Laptop' as type,speed from laptop
union all
select code,model, price,'Printer' as type,null from printer;

select*
from v_all_products;

drop view v_all_products;*/

--use ships;

/*
3.1
create view BritishShips
as
select classes.class,type,numguns,bore,displacement,launched
from classes
join ships on ships.class = classes.class
where country='Gt.Britain';

select * from BritishShips
drop view BritishShips;
*/

/*
3.2
create view BritishShips
as
select classes.class,type,numguns,bore,displacement,launched
from classes
join ships on ships.class = classes.class
where country='Gt.Britain';

select numguns,displacement
from BritishShips
where type='bb' and launched <= 1919;

drop view BritishShips;

3.3
select numguns,displacement
from classes
join ships on CLASSES.class=ships.class
where type='bb' and launched <=1919;*/

/*
3.4
create view tbt
as
select country, max(displacement) as maxShip
from classes
group by country;

select*
from tbt;


select avg(maxShip)
from tbt;

drop view tbt;

3.5
go
create view all_sunked
as
select battle, ship
from outcomes
where result='sunk';
go

select*
from all_sunked;

3.6
insert into all_sunked(battle,ship)
values('Guadalcanal','California');

drop view all_sunked;

3.7
go
create view AtLeast9NumGuns
as
select class
from classes
where numguns>=9
with check option;
go


select*
from AtLeast9NumGuns;

update AtLeast9NumGuns
set numguns=5
where class='Iowa';

3.8
drop view AtLeast9NumGuns;

create view AtLeast9NumGuns
as
select class
from classes
where numguns>=9;

3.9
go
create view atLeast1Damaged
as
select battle,count(distinct ship) as shipCount
from outcomes
join ships on ship=name
left join CLASSES on CLASSES.class=ships.class
where numguns<=9 and result='damaged'
group by battle
having count(distinct name) >=3;
go

select*
from atLeast1Damaged;

drop view atLeast1Damaged;
*/
delete from outcomes where result is null;