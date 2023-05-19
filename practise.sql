create database tiu;
use tiu;

create table studemt(
id int primary key auto_increment,
fname varchar(20) not null ,
sname varchar(20)   not null     ,
dob date   check (dob > '1996-01-01' and dob < '2006-01-01')      ,
ph_number varchar(20) ,
gender enum("male", "female") not null,
department int not null,
foreign key (department) references departments(id)


);


insert into studemt 
values
(304 , "mood" , "aqaq" , "2004-01-01" , "0750 048 42 12" , "male", 2 );


create table departments(
id int primary key auto_increment,
department enum("it" , "cmpe" , "nurse" , "civil" ) ,
faculty enum("engineering" , "scince" , "edcuation")


);

insert into departments
values(1 , "cmpe" , "engineering" ),
(2 , "it" , "scince");



SHOW COLUMNS FROM studemt;

alter  table studemt
rename to students;


create view it_students as 
select fname , sname , departments.department , faculty
from students , departments
where students.department = 2 and departments.id = 2;

select * 
from it_students;

select fname , sname , dob , if(dob > "2000-01-01" , "passed" , "we dont have any student over 2000") as students_over_2000
from students;


alter table students
add mark int ;

set @