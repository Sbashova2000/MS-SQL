use ships;

/*5. �������� ���� �� ���������� ����������� ������ �� 
-- ����� ��������� ����� � ���� ���� ������� �����������
-- �����.

select battle,count(battle)
from ships
left join CLASSES c on c.class=ships.class
left join outcomes on ship =name
where country='USA' and result='sunk'
group by battle;

 6. �������, � ����� �� ��������� ���� 3 ������ �� 
���� � ���� ������.

select distinct battle
from outcomes
left join ships on ship=name
left join CLASSES c on c.class=ships.class
group by battle,country
having count(ship)>=3;

6.a) �� ����� ���� �� �� ������ ����� ��, ��������� � ������� ������, 
 � ����� � ������ ����� �� ���� ����

select classes.class, country,min(launched) as firstYear
from CLASSES
join ships on CLASSES.class=ships.class
group by classes.class,country

6.b) �� ����� ���� � ������ - ����� �� �����, ����� �� ���������� ����� �
���� ������
select class,max(name),count(name)
from ships
group by class;

7. ������� �� ���������, �� ����� ���� �����, ������
�� ���� ���� 1921 �., �� ���� ������ ���� ���� �����.
select class
from ships
group by class
having max(LAUNCHED)<1921;

8. �� ����� ����� �� �� ������ ����� �� �������, � ����� � ��� �������.
��� ������� �� � �������� � ����� ��� ��� ������ �� � ���
��������, � ��������� �� �� ������ 0.

select name,count(battle)
from ships
left join outcomes on ship=name and result='damaged'
group by name

8.1. �� ����� ������� �� �� ������ ����� �� �������� � ����� �� 
���������� ������.
����� �� �������� ���� �� ���� � ����.

select country,count(ships.name),count(outcomes.ship)
from classes
left join ships on CLASSES.class=ships.class
left join outcomes on ship=name and result='sunk'
group by country;

8.2. �� ����� ������� �� �� ������ ����� �� ����������� ������ � ����� �� 
���������� ������. ����� �� �������� ���� �� ���� � ����.

select country,count(distinct damaged.ship),count(distinct sunk.ship)
from classes
left join ships on CLASSES.class=ships.class 
left join outcomes damaged on damaged.ship=name and damaged.result='damaged'
left join outcomes sunk on sunk.ship=name and sunk.result='sunk'
group by country;

9. �������� �� ����� ���� � ���� 3 ������ ���� �� �������� �� ���� ����, 
����� �� � �������� ok.

select class,count(distinct ship)
from ships
left join outcomes on ship=name and  result='ok'
group by class
having count(distinct name)>=3;
*/

use movies;
/* �� ����� ������� ������ �� �� ������ �����, ��������� ���� � � ���
������ � ��������� ���-����� �����. (��� ��� ��� ������ � ������� 
���� �����, �� �� ������ ��� �� � �� ���)

select name,birthdate,(select top 1 studioname
						from movie
						join starsin on MOVIETITLE=title and MOVIEYEAR=year
						where starname=name
						group by studioname
						order by count(*)desc) studioname
from moviestar;*/
use pc;
/*
�������� �� ������ ������������� �� ���� 2 �������
��������, ���� �� �������������� �� ��� PC-�� (���������
������������), ���������� 0.

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

D� �� ������� ������ �������������,�� ����� �������� ����
�� ������������� �������� � ��-����� �� �������� ���� �� ������� �������:

select maker
from product p
join pc on p.model=pc.model
group by maker
having avg(price) < (select avg(price) from product
					join laptop on product.model=laptop.model
					where  maker=p.maker);

���� ����� �������� ���� �� �� �������� � ������� ������������ 
� ���������� �������� ����. �� �� ������� ���� ������ ��������,
����� ������ ���� (�� ���������� �� ������������) � ��-�����
 �� ���-������� ������, ����������� �� ����� ������������.
 
select pc.model
from pc
join product p on pc.model=p.model
group by pc.model,p.maker
having avg(price)<(select min(price) from laptop
					join product t on laptop.model=t.model
					where t.maker=p.maker);

������ ������ ��������, �� ����� ��������� � ������� ��
���-������� � ���-������ �������� � ���� 20 GB.


select model
from pc
group by model
having max(hd)-min(hd) >=20;
 */
use ships;
/*�� �� ������� ������� �� ��������, ����� �� ��������� � ����� �
����������� ���� �� ��� ������.
select ship
from outcomes
join battles on battle=name
group by ship
having year(max(date))-year(min(date)) >=1;

�� ����� ������, � ����� � ��������� �����, �� �� ������ ����� ��
��������, ������� �� ���� ���� ���� ������

select year(date), count(distinct ships.name)
from battles
left join ships on year(date)=launched
group  by year(date);*/



