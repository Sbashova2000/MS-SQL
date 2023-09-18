use movies;
begin transaction; -- изпълняваме този ред

--1.1
insert into MOVIESTAR(name,gender,BIRTHDATE)
values ('Nicole Kidman','F','1967-06-20');

select*
from moviestar;


--1.2
delete 
from movieexec
where networth < 10000000;

select*
from MOVIEEXEC;

--1.3
delete
from MOVIESTAR
where ADDRESS is null;

--1.4
UPDATE MovieExec
SET name = 'Pres. ' + name
WHERE cert# IN (SELECT presC# FROM Studio);

select*
from MOVIEEXEC

use pc;

--2.1
insert into product(maker,model,type)
values ('C','1100','PC');
insert into pc(code,model,speed,ram,hd,cd,price)
values(12,'1100',2400,2048,500,'52x',299)

--2.2
delete 
from pc
where model='1100';

delete
from product
where model='1100';

select*
from pc;

--2.3
--neka maker-a na tezi laptopi se kazwa Z
insert into product(model,maker,type)
select distinct model,'Z','Laptop'
from pc;

insert into laptop(code,model,speed,ram,hd,price,screen)
select code+100,model,speed,ram,hd,price+500,15
from pc;

select*
from laptop;

--2.4
delete
from laptop
where model in (select model from product
				where type='Laptop' and maker not in 
				(select maker from product where type='printer'));

--2.5
update product
set maker = 'A'
where maker='B';

select*
from product

--2.6
update pc
set price=price/2, hd=hd+20;

--2.7
update laptop
set screen= screen+1
where model in(select model from product where  maker='B');


use ships;
--3.1
insert into classes
values('Nelson', 'bb','Gr.britain',9,16,34000);

insert into ships
values('Nelson','Nelson',1927);

insert into ships
values('Rodney','Nelson',1927);

select*
from ships

--3.2
delete
from ships
where name in (select ship from outcomes where result='sunk');

--3.3
update CLASSES
set bore=bore*2.54, DISPLACEMENT = DISPLACEMENT/1.1;

--3.4
delete 
from CLASSES
where class not in(select class from ships group by class having count(*) >=3);


delete 
from classes
where class in
(select classes.class 
from classes
left join ships on classes.class=ships.class
group by classes.class
having count(name)<3)


--3.5
update classes
set bore=(select bore from classes where class='Bissmarck'),
	displacement=(select DISPLACEMENT from classes where class ='Bismarck')	
	where class='Iowa';

rollback transaction;