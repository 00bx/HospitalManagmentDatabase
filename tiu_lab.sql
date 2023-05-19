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
		('Zara', 'Kawa', 'Omer', 'Zara.Kawa', '123qwe'),
        ('zaman', 'dhulfaqar', 'agha', 'zam_an', '123qyywe');



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
values	(1, 1, 1000),
		(1, 2, 1000),
		(2, 1, 1000),
        (1, 1, 1000),
        (2, 2,1000);



create table withdraw_tbl(
	id				int			primary key 	auto_increment,
    employee_id		int			not null,
    customer_id		int			not null,
    amount			dec(6,1)	not null,
    withdraw_date_time	datetime	default now(),
    last_update			timestamp	default	now() on update current_timestamp,
    
    foreign key(employee_id) references employee_tbl(id),
	foreign key(customer_id) references customer_tbl(id)
);

insert into withdraw_tbl(employee_id, customer_id, amount)
values	(1, 1,200),
		(1, 2, 200),
		(2, 1, 200),
        (1, 1, 200),
        (2, 2,200);
    

