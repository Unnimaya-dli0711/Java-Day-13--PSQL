create table Authors (author_id serial primary key,
first_name varchar(25),
last_name varchar(25),
date_of_birth date,
nationality varchar(25));


create table Books (book_id serial primary key,
title varchar(25),
author_id serial ,
publication_year int,
genre varchar(25),
isbn varchar(25),
available_copies int ,
foreign key(author_id) references Authors(author_id));


create table Members (member_id serial primary key,
first_name varchar(25),
last_name varchar(25),
date_of_birth date,
contact_number varchar(10),
email varchar(25),
membership_date date
);

create table Loans(loan_id serial primary key,
book_id serial,
member_id serial,
loan_date date,
return_date date,
actual_return_date date,
foreign key (member_id) references Members(member_id) ,foreign key (book_id) references Books(book_id));


create table Staff (staff_id serial primary key,
first_name varchar(25),
last_name varchar(25),
position varchar(25),
contact_number varchar(10),
email varchar(25),
hire_date date);


--DDL Queries


--Add a new column to the books table

alter table Books add column rating int;

--Rename the position column in the staff table to job_title:

alter table Staff rename column position to job_title;

--drop the email column from the members table

alter table Members drop column email;

insert into Authors values(1,'Harper', 'Lee', '1926-04-28', 'American');
insert into Authors values  (2, 'George', 'Orwell', '1903-06-25', 'British');
insert into Authors values (3, 'F. Scott', 'Fitzgerald', '1896-09-24', 'American');
--DML Queries
--1. Insert new data into the books table:

insert into Books values(1,'To Kill a Mockingbird',1,1960,'Fiction','978-0-06-112008-4',5,4);
insert into Books values (2, '1984', 2, 1949, 'Dystopian', '978-0-452-28423-4', 3, 4);
insert into Books values (3, 'The Great Gatsby', 3, 1925, 'Fiction', '978-0-7432-7356-5', 4, 3);

insert into Loans values (1, 1, 101, '2024-08-01', '2024-08-15','2024-08-14');
insert into Loans values (2, 2, 102, '2024-08-03', '2024-08-17', '2024-08-16');
insert into Loans values (3, 3, 103, '2024-08-05', '2024-08-19', '2024-08-15');

insert into Members values (101, 'John', 'Doe', '1990-05-15', '1234567890',  '2022-01-10');
insert into Members values (102, 'Jane', 'Smith', '1985-08-22', '2345678901', '2021-06-25');
insert into Members values(103, 'Emily', 'Brown', '1992-11-30', '3456789012',  '2023-03-14');

insert into Staff values(1, 'Alice', 'Johnson', 'Librarian', '1234567890', 'alice.johnson@example.com', '2020-01-15');
insert into Staff values(2, 'Bob', 'Smith', 'Assistant', '2345678901', 'bob.smith@example.com', '2019-03-22');
insert into Staff values(3, 'Charlie', 'Brown', 'Manager', '3456789012', 'charlie.brown@example.com', '2018-07-30');

--2. Update a member's contact number
update  Members set contact_number='1234567890' where member_id=101;

--3.Delete a specific loan record
delete from  Loans where loan_id=1;

--4. Insert a new loan record
insert into Loans values (2, 2, 102, '2024-08-03', '2024-08-17', '2024-08-16');
insert into Loans values (3, 3, 103, '2024-08-05', '2024-08-19', '2024-08-15');

--Join Queries

--1. Retrieve all books along with their authors
select Books.title ,Authors.first_name ,Authors.last_name from Books join Authors on Books.author_id=Authors.author_id;

--2.Find all books currently on loan along with member details
select * from Loans join Members on Loans.member_id=Members.member_id  join Books  on Loans.book_id=Books.book_id;

--3.List all books borrowed by a specific memberselect * from Loans join Members on Loans.member_id=Members.member_id  join Books  on Loans.book_id=Books.book_id;
select Books.title from Loans join Members on Loans.member_id=Members.member_id  join Books  on Loans.book_id=Books.book_id where Members.first_name='Emily';

--4.Get the total number of books and the total available copies for each genre
select sum(available_copies) as total_copies from Books;
select genre , sum(available_copies) from Books group by genre ;

--5.Find all staff members who are librarians and their hire dates
select first_name,last_name ,hire_date from Staff where job_title='Librarian';

