create database supplier;
use supplier;

create table supplier
(sid int, sname varchar(50), city varchar(50),
primary key(sid));

create table parts
(pid int, pname varchar(50), colour varchar(50),
primary key(pid));

create table catalog
(sid int, pid int, cost int,
foreign key(sid) references supplier(sid),
foreign key(pid) references parts(pid) on delete cascade);

insert into supplier values
(10001,'acmewidget','bangalore'),(10002,'johns','kolkata'),(10003,'vimal','mumbai'),(10004,'reliance','delhi');


insert into parts values
(20001,'book','red'),(20002,'pen','red'),(20003,'pencil','green'),
(20004,'mobile','green'),(20005,'charger','black');


insert into catalog values
(10001,20001,10),(10001,20002,10),(10001,20003,30),(10001,20004,10),
(10001,20005,10),(10002,20001,10),(10002,20002,20),(10003,20003,30),(10004,20003,40);


select * from supplier;
select * from parts;
select * from catalog;


select pname from parts where pid in (select pid from catalog);

select sname from
(select c.sname,count(distinct a.pid) as cnt from catalog a
left join parts b on a.pid=b.pid
left join supplier c on c.sid=a.sid group by 1) a
where cnt=(select count(distinct a.pid) from catalog a
left join parts b on a.pid=b.pid);

select sname from supplier
where sid in( select sid from catalog where pid in( select pid from 
parts where colour='red'));

select pname from parts where pid in(
select pid from catalog where sid in( select sid from supplier where 
sname='acmewidget'))
and pid not in( select pid from catalog where sid in( select sid from 
supplier where
sname!='acmewidget'));

select c.sid from catalog c
where c.cost >(select avg(cc.cost) from catalog cc where c.pid=cc.pid 
group by cc.pid);

select sname from supplier
where sid in( select sid from catalog where cost in( select max(cost) 
from catalog group by pid));
