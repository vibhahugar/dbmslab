create database employees;
use employees;

create table project(
pno int,
ploc varchar(40),
pname varchar(40),
primary key(pno)
);

create table dept(
deptno int,
dname varchar(40),
dloc varchar(40),
primary key(deptno)
);

create table employee(
empno int,
ename varchar(40),
mgr_no int,
hiredate date,
sal int,
deptno int,
primary key (empno),
foreign key (deptno) references dept(deptno) on delete cascade
);

create table incentives(
empno int,
incentive_date date,
incentive_amount int,
primary key(incentive_date),
foreign key (empno) references employee(empno) on delete cascade
);

create table assigned_to(
empno int,
pno int,
job_role varchar(50),
foreign key (pno) references project(pno) on delete cascade,
foreign key (empno) references employee(empno) on delete cascade
);

insert into project values(1,"Bengaluru","Microsoft"), (2,"Mangalore","Reliance"),(3,"Mysuru","Dell"),(4,"Hyderabad,","HP"),(5,"Chennai","Byjus");

insert into dept values (10,"Research","Bengaluru"),(20,"Finance","West Bengal"),(30,"Marketing","Bihar"),(40,"HR","Mumbai"),(50,"Sales","Hyderabad");

insert into employee values 
(100,"airi",400,'2003-01-01',100000,10),(200,"haruka",500,'2004-02-02',100500,50), (300,"shizuku",100,'2005-03-03',200500,30), (400,"minori", 500 ,'2006-04-04',300500,40),
(500,"nene",300,'2007-05-05',200700,40), (600,"toya",200,'2008-06-06',200000,20),(700,"akito",200,'2009-07-07',200900,20);

insert into  incentives values(100,'2012-01-17',6000),(200,'2012-02-18',7000),(300,'2012-03-19',8000),(500,'2013-04-20',9000),(600,'2013-05-21',10000);

insert into assigned_to values(100,1, "Manager"),(200,1, "Manager"),(300,2, "Researcher"),(400,3, "Businessman"),
(500,3, "Businessman"),(700,5, "CEO");

select * from project; 
select * from dept; 
select * from employee;
select * from incentives;
select * from assigned_to;   

select a.empno employee_number from project p, assigned_to a
where p.pno=a.pno and p.ploc in("Hyderabad","Bengaluru","Mysuru");

select e.empno from employee e
where e.empno NOT IN
 (select i.empno from incentives i);
 
 select e.ename emp_name, e.empno emp_number, d.dname department, 
a.job_role jobrole, d.dloc department_location, p.ploc project_location
from project p, dept d, employee e, assigned_to a
where e.empno=a.empno
 and p.pno=a.pno 
 and e.deptno=d.deptno 
 and p.ploc=d.dloc;
