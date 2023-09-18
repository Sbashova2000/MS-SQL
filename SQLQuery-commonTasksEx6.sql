use movies;


/*1.��� ���������� ���������� � �������� �� ������ �����, ������� ����� 1982, � ����� � �����
���� ���� ������ (�������), ����� ��� �� ������� ���� ������� 'k', ���� 'b'. ����� �� �� �������
���-������� �����.

select distinct movietitle,movieyear
from starsin
where MOVIEYEAR < 1982 and starname not like '%k%' and starname not like '%b%'
order by MOVIEYEAR 

select title,year
from movie
left join STARSIN on MOVIETITLE=TITLE and MOVIEYEAR=YEAR
where year <1982 and STARNAME not like '%[kb]%'
order by year

2. ���������� � ��������� � ������ (length � � ������) �� ������ �����, ����� �� �� ������
������, �� ����� � � ������ Terms of Endearment, �� ��������� �� � ��-����� ��� ����������

select title, length/60 as hrs
from movie
where year =(select year from movie where title='Terms of Endearment')  and length <= (select length from movie
																						where title='Terms of Endearment')or length is null

3. ������� �� ������ ����������, ����� �� � ������� ������ � �� ������ � ���� ���� ����
����� 1980 �. � ���� ���� ���� 1985 �

use movies;
select name
from MOVIESTAR
join starsin on starname=name
where name in (select starname from starsin) and MOVIEYEAR < 1980 
-- MOVIEYEAR > 1985


4.������ �����-���� �����, �������� ����� ���-������ ������ ���� (InColor='y'/'n') �� ������
������.

select title
from MOVIE m1
where INCOLOR ='N' and year <(select min(year)
								from MOVIE m2
								where INCOLOR='Y' and m1.STUDIONAME=m2.STUDIONAME)


5. ������� � �������� �� ��������, ����� �� �������� � ��-����� �� 5 �������� ������� ������1
������, �� ����� ���� �������� ����� ��� ���, �� �� �� ���� ��� ������� �� ������ � ���, ����
�� ����� ��������. ����� �� �� ������� ��������, �������� � ���-����� ������.
1����. ��� �������� ��� ��� �����, ���� � ������ �� ������ A, B � C, � ��� ������ - C, D � �, ��
�������� � �������� � 5 ������ ����
							

select studioname, address
from MOVIE
left join studio on studioname=name
left join starsin on MOVIETITLE=title and MOVIEYEAR=year
group by studioname,address
having count(distinct STARNAME)<5
order by count(distinct  starname) desc;

12. �� ����� ������/������� �������� ���� �� ���������� ������, � ����� �� ��������� �����.

select starname,count(distinct studioname)
from starsin
left join movie on MOVIETITLE=title and MOVIEYEAR=year
group by starname;

13. �� ����� ������/������� �������� ���� �� ���������� ������, � ����� �� ��������� �����,
����������� � �� ����, �� ����� ������ ���������� � ����� ����� �� ������.

select name,count(distinct studioname)
from MOVIESTAR 
left join starsin on starname=name
left join movie on MOVIETITLE=title and MOVIEYEAR=year
group by name;

14. �������� ������� �� ���������, ��������� � ���� 3 ����� ���� 1990 �.

select starname
from starsin
where MOVIEYEAR>1990
group by STARNAME
having count(MOVIETITLE)>=3;
*/

use ships;

/*6. �� ����� �����, ����� � �� ���� � ���, ����������� ������� i � k, �� �� ������ �����
�� ������ � ���� ��� ������ � ������ �� ���� (launched). ���������� �� ���� ��������
����, �� ����� �� �� �������� ���-����� ��������� ������.

select name,launched
from ships
where class not like'%i%' and class not like '%k%'
order by launched desc;

7. �� �� ������� ������� �� ������ �����, � ����� � �������� (damaged) ���� ����
������� �����.

select battle
from outcomes
left join ships on ship=name
left join CLASSEs on classes.class=ships.class
where result='damaged' and country = 'Japan'

8. �� �� ������� ������� � ��������� �� ������ ������, ������� �� ���� ���� ������ ����
������ 'Rodney' � ����� �� �������� �� � ��-����� �� ������� ���� ������ ��
���������, ������������ �� ������� ������.

select  name,class
from ships
where launched -1=(select launched from ships where name='Rodney')

9. �� �� ������� ������������� �������, �� ����� ������ ����� ������ �� ������� �� ����
� ������� �� ���� 10 ������ (�������� ������ �� ���� North Carolina �� ������� �
������� �� 1911 �� 1941, ����� � ������ �� 10 ������, ������ ������ �� ���� Tennessee
�� ������� ���� ���� 1920 � 1921 �.).


select classes.class
from classes
join ships on ships.class=classes.class
where country='USA' 
group by classes.class
having max(launched) - min(launched) >=10;

10. �� ����� ����� �� �� ������ �������� ���� ������ �� ���� � ���� ������� (�������� �
������� ��� Guadalcanal �� ��������� 3 ����������� � ���� ������� �����, �.�.
�������� ���� � 2).

select battle,count(ship)/count(distinct country)
from outcomes
left join ships on ship=name
left join CLASSES c on c.class=ships.class
group by battle;

11. �� ����� ������� �� �� ������: ����� �� �������� �� ���� �������; ���� �� �������, �
����� � ���������; ���� �� �������, � ����� ���� ����� � ������� ('sunk') (��� ����� ��
�������� � 0 � �� �� ������� 0).

select c.country, count(ships.name),count(o1.battle),count(o2.result)
from classes c
left join ships on  c.class=ships.class
left join outcomes o1 on  o1.ship=name
left join outcomes o2 on  o2.ship=name and o2.result='sunk'
group by country;

16. �������� ���� �� ���������� ����������� ������ �� ����� ��������� ����� � ���� ����
������� ����������� �����.

select battle, count(ship)
from outcomes
left join ships on ship=name
left join CLASSES on CLASSES.class=ships.class and result = 'sunk'
where country='USA'
group by battle;

//same

select BATTLE, count(result)
from OUTCOMES	
left join SHIPS on ships.NAME=OUTCOMES.SHIP
left join CLASSES on ships.CLASS=CLASSES.CLASS
where RESULT='sunk' and COUNTRY='USA'
group by BATTLE

--17. �������, � ����� �� ��������� ���� 3 ������ �� ���� � ���� ������.

select battle
from OUTCOMES
left join SHIPS on ships.NAME=OUTCOMES.SHIP
left join CLASSES on ships.CLASS=CLASSES.CLASS
group by battle,country
having count(ship)>=3;

18. ������� �� ���������, �� ����� ���� �����, ������
�� ���� ���� 1921 �., �� ���� ������ ���� ���� �����.


select class
from ships
where launched not in(select launched from ships where launched > 1921)
group by class;

select class
from ships
group by class
having max(launched) <=1921;

19. (*) �� ����� ����� �������� ���� �� �������, � ����� � ��� �������. ��� ������� �� �
�������� � ����� ��� ��� ������ �� � ��� ��������, � ��������� �� �� ������ 0.


select name, count(battle)
from ships
left join outcomes on ship=name  and result='damaged'
group by name;


20. �������� �� ����� ���� � ���� 3 ������ ���� �� �������� �� ���� ����, ����� �� ��������
� �����.

select class, count(distinct name)
from ships
left join outcomes on ship=name and result='ok'
group by class
having count(distinct name)>=3;

*/










