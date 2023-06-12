CREATE TABLE
    tbl_Employee (
        employee_name VARCHAR(255) NOT NULL,
        street VARCHAR(255) NOT NULL,
        city VARCHAR(255) NOT NULL,
        PRIMARY KEY(employee_name)
    );
 
 
CREATE TABLE
    tbl_Works (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        company_name VARCHAR(255),
        salary DECIMAL(10, 2)
    );
 
CREATE TABLE
    tbl_Company (
        company_name VARCHAR(255) NOT NULL,
        city VARCHAR(255),
        PRIMARY KEY(company_name)
    );
 
CREATE TABLE
    tbl_Manages (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        manager_name VARCHAR(255)
    );

INSERT INTO
    tbl_Employee (employee_name, street, city)
VALUES (
        'Alice Williams',
        '321 Maple St',
        'Houston'
    ), (
        'Sara Davis',
        '159 Broadway',
        'New York'
    ), (
        'Mark Thompson',
        '235 Fifth Ave',
        'New York'
    ), (
        'Ashley Johnson',
        '876 Market St',
        'Chicago'
    ), (
        'Emily Williams',
        '741 First St',
        'Los Angeles'
    ), (
        'Michael Brown',
        '902 Main St',
        'Houston'
    ), (
        'Samantha Smith',
        '111 Second St',
        'Chicago'
    ),(
		'John Smith',
		'741 First St',
		'Los Angeles'
	);

INSERT INTO
    tbl_Employee (employee_name, street, city)
VALUES (
        'Patrick',
        '123 Main St',
        'New Mexico'
    );
 
INSERT INTO
    tbl_Works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'Patrick',
        'Pongyang Corporation',
        500000
    );
 
INSERT INTO
    tbl_Works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'Sara Davis',
        'First Bank Corporation',
        82500.00
    ), (
        'Mark Thompson',
        'Small Bank Corporation',
        78000.00
    ), (
        'Ashley Johnson',
        'Small Bank Corporation',
        92000.00
    ), (
        'Emily Williams',
        'Small Bank Corporation',
        86500.00
    ), (
        'Michael Brown',
        'Small Bank Corporation',
        81000.00
    ), (
        'Samantha Smith',
        'Small Bank Corporation',
        77000.00
    );
 
INSERT INTO
    tbl_Company (company_name, city)
VALUES (
        'Small Bank Corporation', 'Chicago'), 
        ('ABC Inc', 'Los Angeles'), 
        ('Def Co', 'Houston'), 
        ('First Bank Corporation','New York'), 
        ('456 Corp', 'Chicago'), 
        ('789 Inc', 'Los Angeles'), 
        ('321 Co', 'Houston'),
        ('Pongyang Corporation','Chicago'
    );
 
INSERT INTO
    tbl_Manages(employee_name, manager_name)
VALUES 
    ('Mark Thompson', 'Emily Williams'),
    ('John Smith', 'Jane Doe'),
    ('Alice Williams', 'Emily Williams'),
    ('Samantha Smith', 'Sara Davis'),
    ('Patrick', 'Jane Doe');
 
SELECT * FROM tbl_Employee;
SELECT * FROM tbl_Works;
SELECT * FROM tbl_Manages;
SELECT * FROM tbl_Company;

--Display count of employees under a manager

SELECT manager_name,COUNT(employee_name) AS 'No. of employee' FROM tbl_Manages GROUP BY manager_name 

--Display manager name having count of employee more than 1

SELECT manager_name,COUNT(employee_name) AS 'No. of employee' FROM tbl_Manages GROUP BY manager_name HAVING COUNT(employee_name) > 1 

--2.a
SELECT employee_name FROM tbl_Works WHERE company_name = 'First Bank Corporation'

--2.b
SELECT employee_name,city FROM tbl_Employee WHERE employee_name IN (SELECT employee_name FROM tbl_Works WHERE company_name = 'Small Bank Corporation')


SELECT tbl_Employee.employee_name,city FROM tbl_Employee,tbl_Works WHERE company_name = 'Small Bank Corporation' 
AND tbl_Employee.employee_name=tbl_Works.employee_name

--2.c
SELECT employee_name,street,city FROM tbl_employee WHERE 
	employee_name IN (SELECT employee_name FROM tbl_works WHERE company_name = 'Small Bank Corporation' AND salary > 10000)

--2.d

SELECT employee_name,city FROM tbl_Employee WHERE city IN 
(SELECT tbl_Company.city FROM tbl_Company 
WHERE company_name IN 
(SELECT company_name FROM tbl_Works WHERE tbl_Employee.employee_name = tbl_Works.employee_name));


--2.e


ALTER TABLE tbl_Manages
ADD street VARCHAR(255), city VARCHAR(255)


UPDATE tbl_Manages
SET city = 'New York', street = '235 Fifth Ave'
WHERE manager_name = 'Emily Williams'

UPDATE tbl_Manages
SET city = 'New Mexico', street = '123 Main St'
WHERE manager_name = 'Jane Doe'

UPDATE tbl_Manages
SET city = 'Chicago' , street = '111 Second St'
WHERE manager_name = 'Sara Davis'


SELECT employee_name FROM tbl_Employee WHERE employee_name IN 
(SELECT employee_name FROM tbl_Manages WHERE tbl_Employee.street= tbl_Manages.street AND tbl_Employee.city = tbl_Manages.city)


SELECT tbl_Employee.employee_name FROM tbl_Employee INNER JOIN tbl_Manages ON tbl_Employee.employee_name = tbl_Manages.employee_name 
WHERE tbl_Employee.city = tbl_Manages.city AND tbl_Employee.street = tbl_Manages.street 


--2.f

SELECT employee_name FROM tbl_Employee WHERE employee_name IN ( SELECT employee_name FROM tbl_Works WHERE NOT company_name = 'First Bank Corporation')


--2.g

SELECT employee_name FROM tbl_Employee WHERE employee_name IN 
(SELECT employee_name FROM tbl_Works WHERE NOT company_name = 'Small Bank Corporation' 
AND salary > (SELECT MAX(salary) FROM tbl_Works WHERE company_name = 'Small Bank Corporation'))


--2.h

SELECT company_name FROM tbl_Company WHERE company_name IN 
(SELECT company_name FROM tbl_Company WHERE city IN 
(SELECT city FROM tbl_Company WHERE company_name = 'Small Bank Corporation') AND NOT company_name = 'Small Bank Corporation')


--2.i

SELECT employee_name FROM tbl_Works WHERE employee_name IN 
(SELECT employee_name FROM tbl_Works WHERE salary > (SELECT AVG(salary) FROM tbl_Works ))


--2.j

SELECT company_name, COUNT(employee_name) AS No_Employees FROM tbl_Works 
GROUP BY company_name HAVING NOT COUNT(employee_name) <= ALL (SELECT COUNT(employee_name) FROM tbl_Works GROUP BY company_name)

--2.k

SELECT company_name FROM tbl_Works GROUP BY company_name HAVING SUM(salary) <= ALL (SELECT SUM(salary) FROM tbl_Works GROUP BY company_name)

--2.l

SELECT company_name FROM tbl_Works GROUP BY company_name HAVING AVG(salary) >=
(SELECT AVG(salary) FROm tbl_Works GROUP BY company_name HAVING company_name = 'First Bank Corporation') AND NOT company_name = 'First Bank Corporation'


--3.a

UPDATE tbl_Employee
SET city = 'Newton'
WHERE employee_name = 'John Smith'

--3.b

UPDATE tbl_Works
SET salary = salary * 1.1
WHERE company_name = 'First Bank Corporation'

--3.c

UPDATE tbl_Works
SET salary = salary * 1.1
WHERE employee_name IN (SELECT manager_name FROM tbl_Manages WHERE company_name = 'First Bank Corporation')

--3.d

UPDATE tbl_Works
SET salary = CASE
WHEN salary < 100000  AND employee_name IN (SELECT manager_name FROM tbl_Manages WHERE company_name = 'First Bank Corporation') THEN salary * 1.1
WHEN salary >= 100000  AND employee_name IN (SELECT manager_name FROM tbl_Manages WHERE company_name = 'First Bank Corporation') THEN salary * 1.03
ELSE salary
END

--3.e

DELETE FROM tbl_Works WHERE company_name = 'Small Bank Corporation'



SELECT * FROM tbl_Employee LEFT JOIN tbl_Manages ON tbl_Employee.employee_name = tbl_Manages.employee_name
SELECT * FROM tbl_Works;
SELECT * FROM tbl_Manages;
SELECT * FROM tbl_Company;
