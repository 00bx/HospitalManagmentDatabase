create database RTB;
use RTB;

create table employee_tbl(
	id			int				primary key 	auto_increment,
    fname		varchar(20)		not null,
    mname		varchar(20)		not null,
    lname		varchar(20)		not null,
    username	varchar(30)		not null	unique,
    passwordd	varchar(100)	not null,
    salary		int				check(salary > 400),
    dob			date			check(dob >'1960-01-01' and dob <'2001-01-01'),
    gender		enum('Male', 'Female'),
    positionn	enum('Finance Manager', 'HR Manger', 'Recepronist', 'Secretary'),
    phone		varchar(16),
    address		varchar(100),
    hired_date	date check(hired_date < '2023-02-20')
);

-- 	insertng multiple records at the same time
insert into employee_tbl(fname, mname, lname, username, passwordd)
values	('Nasrin', 'Kawa', 'Omer', 'Nasrin.Kawa', '123qwe'),
		('Dara', 'Ali', 'Ahmed', 'Dara.Ali', '123qwe');



create table customer_tbl(
	id			int				primary key 	auto_increment,
    fname		varchar(20)		not null,
    mname		varchar(20)		not null,
    lname		varchar(20)		not null,
    username	varchar(30)		not null	unique,
    passwordd	varchar(100)	not null,
    dob			date			check(dob >'1960-01-01' and dob <'2001-01-01'),
    gender		enum('Male', 'Female'),
    phone		varchar(16),
    address		varchar(100),
    registered_date_time	datetime default now()
);

insert into customer_tbl(fname, mname, lname, username, passwordd)
values	('Dana', 'Omer', 'Ahmed', 'Dana.Omer', '123qwe'),
		('Zara', 'Kawa', 'Omer', 'Zara.Kawa', '123qwe');


create table deposit_tbl(
	id				int			primary key 	auto_increment,
    employee_id		int			not null,
    customer_id		int			not null,
    amount			dec(6,1)	not null,
    deposit_date_time	datetime	default now(),
    last_update			timestamp	default	now() on update current_timestamp,
    
    foreign key(employee_id) references employee_tbl(id),
	foreign key(customer_id) references customer_tbl(id)
);

insert into deposit_tbl(employee_id, customer_id, amount)
values	(1, 1, 400),
		(1, 2, 1000),
		(2, 1, 2000),
        (1, 1, 500),
        (2, 2, 800);


update deposit_tbl
set amount = 3000
where id = 3;

delete from deposit_tbl
where id = 4;


select customer_id, sum(amount) as total_deposit_amount
from deposit_tbl
group by customer_id;

select sum(amount) as total_deposit_amount
from deposit_tbl;

select customer_id, max(amount) 
from deposit_tbl
group by customer_id;

select count(fname) as no_of_customers
from customer_tbl;