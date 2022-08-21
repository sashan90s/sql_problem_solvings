use world;
-- RECURSIVE SQL QUERIES in PostgreSQL, Oracle, MSSQL & MySQL
/* Recursive Query Structure/Syntax
WITH [RECURSIVE] CTE_name AS
	(
     SELECT query (Non Recursive query or the Base query)
	    UNION [ALL]
	 SELECT query (Recursive query using CTE_name [with a termination condition])
	)
SELECT * FROM CTE_name;
*/

/* Difference in Recursive Query syntax for PostgreSQL, Oracle, MySQL, MSSQL.
- Syntax for PostgreSQL and MySQL is the same.
- In MSSQL, RECURSIVE keyword is not required and we should use UNION ALL instead of UNION.
- In Oracle, RECURSIVE keyword is not required and we should use UNION ALL instead of UNION. Additionally, we need to provide column alias in WITH clause itself
*/

-- Queries:
-- Q1: Display number from 1 to 10 without using any in built functions.
-- Q2: Find the hierarchy of employees under a given manager "Asha".
-- Q3: Find the hierarchy of managers for a given employee "David".


/* TABLE CREATION SCRIPT - PostgreSQL, Oracle, MSSQL */
DROP TABLE emp_details;
CREATE TABLE emp_details
    (
        id           int PRIMARY KEY,
        name         varchar(100),
        manager_id   int,
        salary       int,
        designation  varchar(100)

    );

INSERT INTO emp_details VALUES (1,  'Shripadh', NULL, 10000, 'CEO');
INSERT INTO emp_details VALUES (2,  'Satya', 5, 1400, 'Software Engineer');
INSERT INTO emp_details VALUES (3,  'Jia', 5, 500, 'Data Analyst');
INSERT INTO emp_details VALUES (4,  'David', 5, 1800, 'Data Scientist');
INSERT INTO emp_details VALUES (5,  'Michael', 7, 3000, 'Manager');
INSERT INTO emp_details VALUES (6,  'Arvind', 7, 2400, 'Architect');
INSERT INTO emp_details VALUES (7,  'Asha', 1, 4200, 'CTO');
INSERT INTO emp_details VALUES (8,  'Maryam', 1, 3500, 'Manager');
INSERT INTO emp_details VALUES (9,  'Reshma', 8, 2000, 'Business Analyst');
INSERT INTO emp_details VALUES (10, 'Akshay', 8, 2500, 'Java Developer');
commit;
/* ************************************************************************** */


/* TABLE CREATION SCRIPT - MySQL */
DROP TABLE world.emp_details;
CREATE TABLE world.emp_details
    (
        id           int PRIMARY KEY,
        name         varchar(100),
        manager_id   int,
        salary       int,
        designation  varchar(100)

    );

INSERT INTO demo.emp_details VALUES (1,  'Shripadh', NULL, 10000, 'CEO');
INSERT INTO demo.emp_details VALUES (2,  'Satya', 5, 1400, 'Software Engineer');
INSERT INTO demo.emp_details VALUES (3,  'Jia', 5, 500, 'Data Analyst');
INSERT INTO demo.emp_details VALUES (4,  'David', 5, 1800, 'Data Scientist');
INSERT INTO demo.emp_details VALUES (5,  'Michael', 7, 3000, 'Manager');
INSERT INTO demo.emp_details VALUES (6,  'Arvind', 7, 2400, 'Architect');
INSERT INTO demo.emp_details VALUES (7,  'Asha', 1, 4200, 'CTO');
INSERT INTO demo.emp_details VALUES (8,  'Maryam', 1, 3500, 'Manager');
INSERT INTO demo.emp_details VALUES (9,  'Reshma', 8, 2000, 'Business Analyst');
INSERT INTO demo.emp_details VALUES (10, 'Akshay', 8, 2500, 'Java Developer');
commit;



select * from
emp_details;

/* recursive lesstions*/

with recursive numbers as
	(select 1 as n
    union 
    select n + 1
    from numbers
    where n <10
    )
    
select * from numbers;

-- Q2: Find the hierarchy of employees under a given manager "Asha".
select *
from 
emp_details;

with recursive emp_hierrarchy as
( select id, name, manager_id, designation
from emp_details
where name = 'Asha'
union 
select E.id, E.name, E.manager_id, E.designation
from emp_hierrarchy as H
join emp_details as E
on H.id = E.manager_id
)

select * from emp_hierrarchy;


with recursive emp_hierrarchy as
( select id, name, manager_id, designation, 1 as lvl
from emp_details
where name = 'Asha'
union 
select E.id, E.name, E.manager_id, E.designation, H.lvl +1 as lvl
from emp_hierrarchy as H
join emp_details as E
on H.id = E.manager_id
)

select * from emp_hierrarchy;
