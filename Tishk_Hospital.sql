 create database Tishk_Hospital;
 use Tishk_Hospital;


-- table creation start 

-- nurse  table

create table nurse (
id int primary key auto_increment, 
fname varchar(20) not null ,
sname varchar(20) not null ,
gender enum("male" , "female") not null ,
shift_start_time TIME NOT NULL,
shift_end_time TIME NOT NULL,
shift_day_of_week VARCHAR(10) NOT NULL,
posiition varchar(20) ,
registred tinyint(1) default 1 , 
ssn int not null



);

-- nurse contact table

create table nurse_contact(
nurse_id int primary key auto_increment,
ph_number varchar(20) default "964+" ,
address varchar(20) not null, 
place_of_birth varchar(20),

foreign key (nurse_id) references nurse(id) 
);

-- hospital department table

create table departments(

dep_id int primary key auto_increment,
Department_Name enum("surgery" , "medicine" , "neurology" , "cardiology") , 
Descrption varchar (40), 
head_of_department int 
);

-- table of doctors

create table doctors(

doc_id int primary key auto_increment,
fname varchar(20),
sname varchar(20),
positiion int default 0,
salary int check(salary > 500 and salary < 1500000),
day_availibilty varchar(20) ,
week_availability varchar(10)
);


-- patient table

CREATE TABLE patient (
  patient_id int primary key auto_increment,
  fname varchar(60) not null,
  sname varchar(60) not null,
  type_of_disase varchar(100) not null,
  Doctor_of_patient int not null,
  Nurse_of_patient int not null,
  foreign key( Doctor_of_patient ) references doctors(doc_id) on update cascade on delete cascade ,
    foreign key( Nurse_of_patient ) references nurse(id) on update cascade on delete cascade 

);

-- patient doctor table

create table patient_doctor(
id int primary key auto_increment,
patiient_id int not null,
doctor_id int not null,
foreign key (doctor_id)references doctors(doc_id) on update cascade on delete cascade,
foreign key (patiient_id)references patient(patient_id) on update cascade on delete cascade


);

-- patient nurse table

create table patient_nurse(
id int primary key auto_increment,
patiient_id int not null,
nurse_id int not null,
foreign key (nurse_id)references nurse(id) on update cascade on delete cascade,
foreign key (patiient_id)references patient(patient_id) on update cascade on delete cascade


);
-- room table 

CREATE TABLE room (
    room_id  INT primary key auto_increment ,
    room_type VARCHAR(50) NOT NULL,
    max_capacity INT NOT NULL,
    availability BOOLEAN NOT NULL
);

-- appointments table

CREATE TABLE appointments (
  appointment_id INT AUTO_INCREMENT,
  patient_id VARCHAR(20) NOT NULL,
  doctor_id int NOT NULL,
  nurse_id int not null ,
  appointment_date DATE NOT NULL,
  appointment_time TIME NOT NULL,
  appointment_type VARCHAR(50) NOT NULL,
  PRIMARY KEY (appointment_id),
  foreign key( doctor_id  ) references doctors(doc_id) on update cascade on delete cascade ,
    foreign key( nurse_id ) references nurse(id) on update cascade on delete cascade 
);

-- table for payment details to be more detail we can use hour working per a day for each employee

CREATE TABLE payment_for_doctors(
  payment_id INT NOT NULL AUTO_INCREMENT,
  employee_id INT NOT NULL,
  payment_date DATE NOT NULL,
  amount DECIMAL(8,2) NOT NULL,
  description VARCHAR(255),
  PRIMARY KEY (payment_id),
  FOREIGN KEY (employee_id) REFERENCES doctors(doc_id) on update cascade on delete cascade
);

CREATE TABLE payment_for_nurses(
  payment_id INT NOT NULL AUTO_INCREMENT,
  employee_id INT NOT NULL,
  payment_date DATE NOT NULL,
  amount DECIMAL(8,2) NOT NULL,
  description VARCHAR(255),
  PRIMARY KEY (payment_id),
FOREIGN KEY (employee_id) REFERENCES nurse(id) on update cascade on delete cascade

  
);

-- log tables

-- trigger table for doctors
create table doctor_log(
id int primary key auto_increment,
doc_id int ,
actionn varchar(20),
old_fname varchar(20),
new_fname varchar(20),
old_sname varchar(20),
new_sname varchar(20),
old_room int,
new_room int,
old_salary int,
new_salary int,
log_Date date,
log_Time time




);

-- trigger table for nurses

create table nurse_log(
id int primary key auto_increment,
nurse_id int ,
actionn varchar(20),
old_fname varchar(20),
new_fname varchar(20),
old_sname varchar(20),
new_sname varchar(20),
old_position varchar(20),
new_position varchar(20),
log_Date date,
log_Time time




);


create table patient_log(
id int primary key auto_increment,
patient_id int ,
actionn varchar(20),
old_fname varchar(20),
new_fname varchar(20),
old_sname varchar(20),
new_sname varchar(20),
old_doctor int,
new_doctor int,
old_nurse int,
new_nurse int,
old_disase varchar(20),
new_disase varchar(20),
log_Date date,
log_Time time




);
-- table creation ends here

-- trigger queries

-- trigger for doctor table

create trigger doctor_insertaion
after insert on doctors
for each row
insert into doctor_log
set
actionn = "insertaion",
doc_id = new.doc_id,
new_fname = new.fname,
new_sname = new.sname,
new_room = new.room,
new_salary = new.salary,
log_date = current_date(),
log_time = current_time();

-- delete trigger for doctor

create trigger doctor_delete
after delete on doctors
for each row
insert into doctor_log
set
actionn = "delete",
doc_id = old.doc_id,
new_fname = old.fname,
new_sname = old.sname,
new_room = old.room,
new_salary = old.salary,
log_date = current_date(),
log_time = current_time();

-- update trigger for doctor

create trigger doctor_update
after update on doctors
for each row
insert into doctor_log
set
actionn = "update",
doc_id = new.doc_id,
old_fname = old.fname,
new_fname = new.fname,
old_sname = old.sname,
new_sname = new.sname,
old_room = old.room,
new_room = new.room,
old_salary = old.salary,
new_salary= new.salary,
log_date = current_date(),
log_time = current_time();


-- end of doctor log queries


-- trigger for nurse table

create trigger nurse_insertation
after insert on nurse
for each row
insert into nurse_log
set
actionn = "insertaion",
nurse_id = new.id,
new_fname = new.fname,
new_sname = new.sname,
new_position = new.posiition,
log_date = current_date(),
log_time = current_time();

-- delete trigger for nurse

create trigger nurse_delete
after delete on nurse
for each row
insert into nurse
set
actionn = "delete",
nurse_id = old.id,
new_fname = old.fname,
new_sname = old.sname,
new_position = old.posiition,
log_date = current_date(),
log_time = current_time();

-- update trigger for nurse

create trigger nurse_update
after update on nurse
for each row
insert into nurse_log
set
actionn = "update",
nurse_id = new.id,
old_fname = old.fname,
new_fname = new.fname,
old_sname = old.sname,
new_sname = new.sname,
old_position = old.posiition,
new_position = new.posiition,
log_date = current_date(),
log_time = current_time();



-- end of nurse log queries


-- trigger for patient table

create trigger patient_insertaion
after insert on patient
for each row
insert into patient_log
set
actionn = "insertaion",
patient_id = new.patient_id,
new_fname = new.fname,
new_sname = new.sname,
new_doctor = new.Doctor_of_patient,
new_nurse = new.Nurse_of_patient,
new_disase = new.type_of_disase,
log_date = current_date(),
log_time = current_time();


-- delete trigger for patient

create trigger patient_delete
after delete on patient
for each row
insert into patient_log
set
actionn = "delete",
patient_id = old.patient_id,
new_fname = old.fname,
new_sname = old.sname,
new_doctor = old.Doctor_of_patient,
new_nurse = old.Nurse_of_patient,
new_disase = old.type_of_disase,
log_date = current_date(),
log_time = current_time();
-- update trigger for patient

create trigger patient_update
after update on patient
for each row
insert into patient_log
set
actionn = "update",
patient_id = new.patient_id,
new_fname = new.fname,
old_fname = old.fname,
new_sname = new.sname,
old_sname = old.sname,
new_doctor = new.Doctor_of_patient,
old_doctor = old.Doctor_of_patient,
new_nurse = new.Nurse_of_patient,
old_nurse = old.Nurse_of_patient,
new_disase = new.type_of_disase,
old_disase = old.type_of_disase,
log_date = current_date(),
log_time = current_time();

DROP TRIGGER IF EXISTS patient_update;
DROP TRIGGER IF EXISTS patient_insertaion;
-- end of patient log queries






-- end of log queries

-- begin of data validation test

delimiter %%

create trigger chk_disase
before insert on patient
for each row
begin

if(new.type_of_disase="bone") then
set new.type_of_disase = "osseous tissue ";
end if;

end %%

delimiter ;

-- select queries

select CONCAT(fname, ' ', sname) AS Head_Of_department, department_name -- means show the doctors who are head of departments , if we have dr without positiion field it'll not show
from departments,doctors
where positiion = dep_id;

select count(DISTINCT  patient_id) as no_of_patients_that_has_appointments -- to count number of patients that have appoinments, withour repeatin cus may one patient has two appoinments
from appointments;


select fname , sname , registred as not_registered
from nurse
where registred = 0; -- means show those who doesn't registre till now




select nurse_id , fname , sname , place_of_birth
from nurse , nurse_contact
where nurse_id = id; -- it means show those nurses which has contact to see specific nurse u can write name or id like this

select nurse_id , concat(fname , " " , sname) as name_of_nurse , place_of_birth
from nurse , nurse_contact
where nurse_id = 1 and id = 1; -- why both = 1 ? cus if u remove on of them it shows u all contacts or all nurses groub by id 1 , we wanna see contact of urse that has id = 1

select count(room_id) as available_rooms -- to see how many rooms are available when availablity = 1 its true and availaible if its = 0 false not available
from room
where availability=1;


select count(room_id) as no_of_rooms  ,room_type, availability -- this shows u how many rooms is already unavailable to use
from room
group by room_id
having availability=0;

select nurse_id , doctor_id , appointment_type -- to see all appointments between drs and nurses , without any patient
from appointments
where patient_id = 0;

-- to see appoinments drs with patients where patient id != 0 here 0 i use it ass null when the appoinment doesnt include patient as above query

select doctor_id , patient_id , appointment_date , appointment_time
from appointments
where patient_id != 0;

-- to count patients who have appointment in a specific room

select count(patient_id)
from appointments
where app_Room=303;

-- to calculate salary's of doctors from startin date to next year

SELECT YEAR( payment_date ) AS year, SUM(amount * hours_of_working) AS total_salary
FROM payment_for_doctors
where payment_id = 1;

-- to see maximum salary of doctors or nurses

select employee_id, amount
from payment_for_doctors
where amount = (select max(amount) from payment_for_doctors)
limit 1;

-- to see minimum salary of doctors or nurses

select employee_id, amount
from payment_for_doctors
where amount = (select min(amount) from payment_for_doctors)
limit 1;

-- to see patient with specific disase
SELECT * 
FROM patient
WHERE type_of_disase = 'surgery '; 

-- to see doctors and their department + position and all information needed for doctors
select *
from doctors,departments
where positiion = dep_id;


-- end of select queries

-- alter queries

alter table appointments
add appointment_status varchar(200) ;

alter table doctors
rename column positiion to specility;

alter table appointments
add foreign key(app_Room) references room(room_id);

alter table appointments
modify nurse_id int ;


alter table room
modify availability tinyint(1) default 0;


alter table doctors
modify room int not null unique;


alter table doctors
add foreign key (position) references doctors(dep_id);

alter table appointments
add app_Room int not null;

alter table departments
add foreign key (head_of_department) references doctors(doc_id);

alter table payment_for_doctors
add hours_of_working int;

alter table patient
modify type_of_disase varchar(60);

-- end of alter queries

-- insert queries




insert into departments(dep_id , department_name,Descrption)
values(3, "neurology" , "for bones contact us " ) ;


insert into doctors
values(2 , "zaman" , "dhulfaqar" , 2 , 1290 , "16-00-00 => 24-00-00 ","fri -> mon" ),
      (3 , "sana" , "dhulfaqar" , 3 , 1550 , "16-00-00 => 24-00-00 ","tue -> sun" );


insert into nurse_contact
values(3 ,"04444 244412","kirkuk road","kirkuk" ); -- contact added to zaman's information


insert into nurse
values(8, "uuu" , "kuuuamal" , "male" , 16-00-00, 23-00-00,"mon -> fri", " Nuruse" , 0 , 10001);


insert into appointments
values(1 , 1 , 3, 5 ,"2023:03:21", 10-00-00 , "easy disase, need some medicin"),
(2, 3 , 1, 2 ,"2023:04:01", 16-30-00 , "easy disase, need some medicin"),
(3 , 3 , 3, 4 ,"2023:01:12", 12-45-00 , "neurology disase");

insert into patient
values(1 , "ahmad " , "khasro"  , "neurology" , 1, 3),
(2 , "mahmood " , "razaq"  , "surgery " , 2, 5),
(3 , "ersan" , "tasin" , "medicin" ,1,6);

insert into room
values(301 , "neurology" , 5 , 1),
( 239 , "medicin" , 10 , 1 ),
( 241 , "surgery" , 2 , 0);


insert into payment_for_nurses
values(1 , 1 , "2023-04-11" , 10000.98 , "head payment"),
(2 , 2 , "2023-02-21" , 600000.876, "junior payment"),
(3, 3 , "2023-02-11" , 120000.65, "full-junior payment");

insert into payment_for_doctors
values(1 , 1 , "2023-04-11" , 10000.98 , "head payment"),
(2 , 2 , "2023-02-21" , 600000.876, "junior payment"),
(3, 3 , "2023-02-11" , 120000.65, "full-junior payment");
-- end of insertation queries


-- begin update queries

update doctors
set fname = "rayyan" 
where doc_id = 10;

-- to update child row 

UPDATE doctors c
JOIN departments o ON c.doc_id = o.head_of_department
SET  c.doc_id = 1001, o.head_of_department = 1001
WHERE o.head_of_department = 1;

-- delete queries

delete from doctors
where doc_id = 10;

-- end of delete queries

-- procedure queries


-- procedure for adding patient -> first time need variables for next time insertation just change the vlaue of variables

delimiter $$
CREATE PROCEDURE add_patient(
    IN patient_id int ,
    IN fname varchar(20),
    IN sname varchar(20),
    IN type_of_disase varchar(30),
    IN Doctor_of_patient int,
    Nurse_of_patient int
)
BEGIN
    INSERT INTO patient 
    VALUES (patient_id , fname , sname , type_of_disase, Doctor_of_patient , Nurse_of_patient);
END$$
delimiter ;

set @patient_id = 4;
set @fname = "zara";
set @sname = "khasro";
set @type_of_disase = "neurology";
set @Doctor_of_patient = 2;
set @Nurse_of_patient = 4;

call add_patient(@patient_id, @fname , @sname,@type_of_disase ,@Doctor_of_patient,@Nurse_of_patient);


-- to update patient disase
delimiter $$

CREATE PROCEDURE update_patient_disase(
    IN new_patient_id INT,
    IN new_type_of_disase VARCHAR(50)
)
BEGIN
    UPDATE patient
    SET type_of_disase = new_type_of_disase
    WHERE patient_id = new_patient_id;
END$$

delimiter ;

set @new_type_of_disase = "heart attack";
set @new_patient_id = 2;

call update_patient_disase ( @new_patient_id  , @new_type_of_disase);


delimiter $$


-- procedure to delete patient

CREATE PROCEDURE delete_patient(
  IN id INT
)
BEGIN
  DELETE FROM patient WHERE patient_id = id;
END$$
delimiter ;


set @patient_id = 1;
call delete_patient(@patient_id);


-- procedure to find patient with first name or second , even for more than 1 patient

delimiter %%
CREATE PROCEDURE search_patient(
  IN search_term VARCHAR(255)
)
BEGIN
  SELECT * FROM patient 
  WHERE fname LIKE CONCAT('%', search_term, '%')
    OR sname LIKE CONCAT('%', search_term, '%');
END%%

delimiter ;

call search_patient("khasro");


-- end of procedure quries

-- begin of tcl queries

set autocommit = 0;

insert into patient
values(7 , "johan " , "liebert"  , "neurology" , 3,1);

rollback;  -- here we undoin the action and we also can use it for procedures if action into the procedure contain dml :

set @patient_id = 6;
set @fname = "johan";
set @sname = "liebert";
set @type_of_disase = "neurology";
set @Doctor_of_patient = 3;
set @Nurse_of_patient = 1;

call add_patient(@patient_id, @fname , @sname,@type_of_disase ,@Doctor_of_patient,@Nurse_of_patient);

rollback;

set autocommit = 1;


-- heres more example with savepoint adn relase savepont :

set autocommit = 0;

insert into doctors
values(10, "ahmad" , "azad" , 2 , 1490 , "16-00-00 => 24-00-00 ","fri -> mon" , 231);

savepoint dr_4;

insert into doctors
values(5 , "ahmad" , "zhyar" , 1 , 1490 , "16-00-00 => 24-00-00 ","fri -> mon" , 250);

savepoint dr_5;

rollback to dr_4 ;

release savepoint dr_5;

rollback to dr_5; -- it doesn work cus we have already relased it

 set autocommit = 1;


-- end of tcl queries

-- operators query

select *
from doctors
where positiion in (1,2);

select *
from patient
where patient_id <> 1;

select *
from patient
where type_of_disase != "bone" and type_of_disase != "surgery "  ;



select* 
from doctors 
where salary between 1000 and 2000 ;



-- subquery queries

select employee_id,amount
from  payment_for_doctors
where amount = (select max(amount) from payment_for_doctors)
limit 1;




-- loop queries

--  a loop for updating all doctor's salary for increasing %10 of salary that they already have
delimiter %%

create procedure doctor_salary_update()
begin 
DECLARE doctor_count INT;
DECLARE i INT DEFAULT 0;

SELECT COUNT(*) FROM payment_for_doctors INTO doctor_count;  -- it counts all doctors then put inside doctor count variabe , also we can use max then into in count varable

WHILE i < doctor_count DO
  SET @doctor_salary = (SELECT amount FROM payment_for_doctors WHERE employee_id = i);
  SET @updated_salary = @doctor_salary * 1.1;

  UPDATE payment_for_doctors SET amount = @updated_salary WHERE employee_id = i;

  SET i = i + 1;
END WHILE;

end %%

delimiter ;

call  doctor_salary_update();

-- end of doctor salary updating loop


-- this loop will change the status of appointments by comparing with current date , if its smaller it means the appointment has been missed and fill the space with "missed" word

delimiter %%

create procedure appointment_status_updater()
begin 
DECLARE appointment_count INT;
DECLARE i INT DEFAULT 0;

SELECT max(appointment_id) FROM appointments INTO appointment_count;  -- it counts all appointments then put it inside appointment count variabe , also we can use max then into in count varable

WHILE i <= appointment_count DO
  SET @current_datee = current_date();
  SET @appointments_date = (select appointment_date from appointments where appointment_id= i);

if @appointments_date <  @current_datee then
  UPDATE appointments SET appointment_status = "missed" WHERE appointment_id = i;

end if;

  SET i = i + 1;
END WHILE;

end %%

delimiter ;

call  appointment_status_updater();
-- end of loop


-- reports

-- Patient registration report:  it contains name and id and other stuffs of each patient which registred

select *
from patient;

-- report to see appointents in specific dates

select *
from appointments
where appointment_date = "2023-01-12";

-- report to see appointments which has been missed due of current date

select *
from appointments
where appointment_status = "missed";

-- repoty to retrieve the total number of appointments for each doctor

select doctor_id , count(appointment_id) as total_appointments
from appointments
group by doctor_id;
