/*use ships;

task1
������� � �������� �� ������� �� ������ ������, ����� ���� ������ ��� ����
���� ����.
select name, launched
from ships
where name=class;

task2
������� �� ������ ������, �� ����� ������������ �� ��������� ��������
�������:
(1) ��������� �� � ���� ���� ����� �
(2) ������� �� (�� ��������)
�������� � C ��� K

select distinct ship
from outcomes
join ships on ships.name=outcomes.ship
where name like'C%' or name like'K%' and battle is not null;

task3
������ �������, ����� ���� �������� � ����� ������
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
������ �������, ����� ����� ���� ���� ������� �����.
select distinct country
from CLASSES
join ships on ships.class=classes.CLASS
where name is null or name not in(select ship from outcomes where result='sunk');

select distinct country
from CLASSES
join ships on ships.class=classes.CLASS
where name is null or name in(select ship from outcomes where result!='sunk');

task5
(�� �������� �����) ������� �� ���������, �� ����� ���� �����, ������ �� ����
(launched) ���� 1921 �. ��� �� ����� ���� ������ ������� �����, ��� ���� ������
�� ������ � ���������

select classes.class
from CLASSES
left join ships on CLASSES.class=ships.class and  launched > 1921
where name is null;

select class
from classes
where class not in(select class from ships where  launched > 1921);

task6
� �����, ��������� � �������� (bore) �� ������ ������� ������ � 6, 8 ��� 10
������. ��������� �� �� ������ � ���������� (1 ��� � ������������� 2.54 ��).
select class,country,bore*2.54 as boreCM
from CLASSES
where numguns=6 or numguns=8 or numguns=10

select class,country,bore*2.54 as boreCM
from CLASSES
where numguns in(6,8,10);

task7
���������, ����� ���� ������� � �������� ������� (����. ��� ���� ���� � 14
������� � ������� � 16 �������, ������ �������������� ��� ���� ������� � 15).

select distinct c.country
from CLASSES c
join CLASSES c2 on c.COUNTRY = c2.Country
where c.bore!=c2.bore;

task7
��������, ����� ����������� ������ � ���-����� ���� ������ (numguns).select distinct country
from CLASSES
where numguns >=all(select numguns from CLASSES);
*/

/*use movies;
task1
������ �����, ����� �������� ������� ������������ ������ 'Star' � 'Trek' (��
���������� � ���� ���). ����������� �� �� �������� �� ������ (����� ���-������
�����), � ������� �� ���� � ���� ������ - �� ������� ���.

select* --title
from movie
where title like'%Star%' and title like'%Trek%'
order by year Desc , title;

task2
���������� � �������� �� �������, � ����� �� ������ ������, ������ �����
1.1.1970 � 1.7.1980.

select movietitle,movieyear
from starsin
join MOVIESTAR on starname=name
where BIRTHDATE>='1.1.1970' and  BIRTHDATE <='1.7.1980';
*/

use pc;
/*task1
����������, ����� �� ��-������ �� ����� ������ �� ����� ������������.

select*
from pc
join product p1 on pc.model=p1.model
where price < all (select price from laptop
					join product p2 on p2.model=laptop.model
					where p1.maker=p2.maker);

task2	
����������, ����� �� ��-������ �� ����� ������ � ������� �� �����
������������.
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

