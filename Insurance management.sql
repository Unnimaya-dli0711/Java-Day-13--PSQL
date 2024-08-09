create table customers (customer_id serial primary key,
first_name varchar(25),
last_name varchar(25),
date_of_birth date,
gender varchar(10),
contact_number varchar(10),
email varchar(25),
address varchar(50));

create table policies (policy_id serial primary key,
policy_name varchar(25),
policy_type varchar(25),
coverage_details varchar(30),
premium real,
start_date date,
end_date date);

create table claims (claim_id serial primary key,
claim_date date,
claim_amount real,
approved_amount real,
claim_status varchar(10),
policy_id serial references policies(policy_id),
customer_status serial references customers(customer_id));

create table agents (agent_id serial primary key,
first_name varchar(25),
last_name varchar(25),
contact_number varchar(10),
email varchar(25),
hire_date date);

create table policyAssignments(assignment_id serial primary key,
customer_id serial references customers(customer_id),
policy_id serial references policies(policy_id),
start_date date,
end_date date);

create table claimProcessing (processing_id serial primary key,
claim_id serial references claims(claim_id),
processing_date date,
payment_amount real,
payment_date date);

--DDL Queries
--1. Add a new column to the agents table
alter table agents add column age int;

--2.Rename the policy_name column in the policies table to policy_title
alter table policies rename column policy_name to policy_title;

--3.Drop the address column from the customers table
alter table customers drop column address;

--DML Queries
--1.Update a policy's premium amount
update policies set premium= 1000 where policy_id=1;

--2.Delete a specific claim
delete from claims where claim_id=1;

--3.Insert a new policy assignment

insert into customers values(1, 'John', 'Doe', '1980-05-15', 'Male', '1234567890', 'john.doe@example.com');
insert into customers values(2, 'Jane', 'Smith', '1990-08-22', 'Female', '2345678901', 'jane.smith@example.com');
insert into customers values(3, 'Emily', 'Brown', '1975-11-30', 'Female', '3456789012', 'emily.brown@example.com');

insert into policies values(1, 'Health Plus', 'Health', 'Covers hospitalization', 500.00, '2024-01-01', '2024-12-31');
insert into policies values(2, 'Auto Secure', 'Auto', 'Covers theft', 300.00, '2024-01-01', '2024-12-31');
insert into policies values(3, 'Life Shield', 'Life', 'Provides life death benefits', 1000.00, '2024-01-01', '2044-12-31');

insert into claims values(1, '2024-07-15', 1500.00, 1200.00, 'Approved', 1, 1);
insert into claims values(2, '2024-07-20', 2000.00, 0.00, 'Denied', 2, 2);
insert into claims values (3, '2024-07-25', 500.00, 500.00, 'Approved', 3, 3);

insert into agents values(1, 'Michael', 'Scott', '1234567890', 'michael.scott@example.com', '2015-04-01');
insert into agents values(2, 'Dwight', 'Schrute', '2345678901', 'dwight.sch@example.com', '2016-05-15');
insert into agents values(3, 'Jim', 'Halpert', '3456789012', 'jim.halpert@example.com', '2017-06-20');

insert into claimprocessing  values(1, 1, '2024-07-16', 1200.00, '2024-07-17');
insert into claimprocessing  values(2, 2, '2024-07-21', 0.00, '2024-07-17');
insert into claimprocessing  values(3, 3, '2024-07-26', 500.00, '2024-07-27');

insert into policyassignments values(1, 1, 1, '2024-01-01', '2024-12-31');
insert into policyassignments values(2, 2, 2, '2024-01-01', '2024-12-31');
insert into policyassignments values(3, 3, 3, '2024-01-01', '2044-12-31');

--Join Queries
--1. Retrieve all customers with their assigned policies and agents
select * from policyassignments p   join customers c on p.customer_id=c.customer_id join policies p2 on p2.policy_id=p.policy_id; 

--2. Find all claims and the associated policy details
select * from claims c join policies p on c.policy_id =p.policy_id ;

--3. List all claims along with the customer details
select * from claims c join customers  on  customers.customer_id=c.customer_status ;

--4. Get the total claim amount and number of claims per policy type
select sum(claim_amount) as total_claim_amount from claims;
select count(*),p.policy_type from claims c join policies p on c.policy_id=p.policy_id group by p.policy_type ;

--5. Find the most recent claim for each customer
select c2.customer_id,c.claim_id ,c2.first_name,c2.last_name from claims c join customers c2 on c.customer_status =c2.customer_id  
where c.claim_date =(select max(claims.claim_date) from claims 
where claims.customer_status =c2.customer_id)order by c.claim_date  desc ;