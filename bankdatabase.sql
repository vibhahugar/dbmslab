create database bank_database1;
use bank_database1;

create table branch(
branch_name varchar(40) primary key,
branch_city varchar(40),
assets int
);

create table bank_account(
acc_no int,
branch_name varchar(40),
balance int,
primary key(acc_no,branch_name),
foreign key(branch_name)references branch(branch_name)
on delete cascade);

create table bank_customer(
customer_name varchar(30) primary key,
customer_city varchar(40),
customer_street varchar(50)
);

create table depositer(
customer_name varchar(30),
acc_no int,
primary key(customer_name,acc_no),
foreign key(acc_no) references bank_account(acc_no),

foreign key(customer_name) references bank_customer(customer_name)
on delete cascade);

create table loan(
branch_name varchar(30),
loan_number int primary key,
amount int,
foreign key(branch_name) references branch(branch_name)
on delete cascade);

create table borrower(
loan_number int,
customer_name varchar(30),
primary key(customer_name,loan_number),
foreign key(customer_name) references customer(customer_name)
on delete cascade,
foreign key(loan_number) references loan(loan_number)
on delete cascade
);
desc borrower;


insert into branch
values('HDFC_Chamrajpet','Bengaluru',50000),('HDFC_AnandRaoCircle','Bengaluru',10000),('HDFC_S
hivajiRoad','Mumbai',20000),('HDFC_ParliamentRoad','Delhi',10000),('HDFC_Jantarmantar','Delhi',20000);

insert into bank_account
values(1,'HDFC_Chamrajpet',2000),(2,'HDFC_AnandRaoCircle',5000),(3,'HDFC_ShivajiRoad',6000),(4,'
HDFC_ParliamentRoad',9000),(5,'HDFC_Jantarmantar',8000),(6,'HDFC_ShivajiRoad',4000),(8,'HDFC_
AnandRaoCircle',4000),(9,'HDFC_ParliamentRoad',3000),(10,'HDFC_AnandRaoCircle',5000),(11,'HDF
C_Jantarmantar',2000);
set foreign_key_checks=0;

insert into bank_customer
values('Avinash','Bull_Temple_Road','Bangalore'),('Dinesh','Bannergatta_Road','Bangalore'),('Mohan'
,'NationalCollege_Road','Bangalore'),('Nikil','Akbar_Road','Delhi'),('Ravi','Prithviraj_Road','Delhi');

insert into depositer
values('Avinash',1),('Dinesh',2),('Nikil',4),('Ravi',5),('Avinash',8),('Nikil',9),('Dinesh',10),('Nikil',11);
set foreign_key_checks=0;

insert into loan
values('HDFC_Chamrajpet',1,1000),('HDFC_AnandRaoCircle',2,2000),('HDFC_ShivajiRoad',3,3000),('H
DFC_ParliamentRoad',4,4000),('HDFC_Jantarmantar',5,5000);
set foreign_key_checks=0;

insert into borrower
values(1,'Avinash'),(2,'Dinesh'),(3,'Mohan'),(4,'Nikil'),(5,'Ravi');
set foreign_key_checks=0;
select * from borrower;


create or replace view custom_view (branch_name,assets_in_lakhs)
as select branch_name,assets/100000
from branch;
select* from custom_view;

select customer_name, branch_name from depositer d
inner join bank_account b on d.acc_no=b.acc_no
group by customer_name, branch_name
having count(*)>=2;

insert into loan
values('HDFC_Chamrajpet',6,6000);
create view sum_ as
select branch_name,sum(amount)
from loan
group by branch_name;
select* from sum_;

select customer_name,ba.branch_name,b.branch_city,d.acc_no from branch b inner join bank_account ba inner join depositer d on b.branch_name=ba.branch_name and ba.acc_no=d.acc_no where b.branch_city='Delhi';

select distinct b.customer_name from  borrower b, depositer d
           where b.customer_name NOT IN(
                     select d.customer_name from loan l, depositer d, borrower b
 where l.loan_number=b.loan_number and  d.customer_name=b.customer_name);
 
 
 select distinct d.customer_name from depositer d
where d.customer_name IN(
select d.customer_name from branch br, depositer d,   bank_account ba
where br.branch_city='Bangalore' and br.branch_name=ba.branch_name
                     and ba.acc_no=d.acc_no and customer_name IN(
select customer_name from borrower)
);


select b.branch_name from branch b
where b.assets> ALL (
select SUM(b.assets) from branch b
                    where b.branch_city='Bangalore' );


UPDATE bank_account set balance=(Balance + (Balance*0.05));

delete ba.* from bank_account ba, branch b where branch_city='Bombay' and ba.branch_name=b.branch_name;
select * from bank_account;

select customer_name
 from depositer d,bank_account ba, branch b
 where d.acc_no=ba.acc_no and b.branch_name = ba.branch_name
 and branch_city = 'Delhi'
 group by customer_name
having count(distinct ba.branch_name) = (select count(*) from branch b where branch_city='Delhi');

select customer_name
 from depositer d,bank_account ba, branch b
 where d.acc_no=ba.acc_no and b.branch_name = ba.branch_name
 and branch_city = 'Delhi'
 group by customer_name
having count(distinct ba.branch_name) = (select count(*) from branch b where branch_city='Delhi');
