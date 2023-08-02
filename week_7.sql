-- UNION
SELECT * FROM scott.emp WHERE deptno = 10
UNION
SELECT * FROM scott.emp WHERE sal > 3000;

-- INTERSECT (Note: MySQL does not support INTERSECT, so we'll use an alternative approach)
-- Alternative for INTERSECT in MySQL:
SELECT * FROM scott.emp WHERE deptno = 10 AND empno IN (
  SELECT empno FROM scott.emp WHERE sal > 3000
);

-- MINUS (or EXCEPT in some databases)
-- Dynamic Input: Set the @dept_no variable to filter employees of a specific department
-- Example 1: Employees with salary less than 1000 but not part of department 20
DECLARE @dept_no INT;
SET @dept_no = 20;

SELECT * FROM scott.emp WHERE sal < 1000
AND empno NOT IN (SELECT empno FROM scott.emp WHERE deptno = @dept_no);

-- Example 2: Employees with salary less than 1000 but not part of department 30
DECLARE @dept_no INT;
SET @dept_no = 30;

SELECT * FROM scott.emp WHERE sal < 1000
AND empno NOT IN (SELECT empno FROM scott.emp WHERE deptno = @dept_no);



----------------------------------------------------------------------------



-- Sample query using ORDER BY
-- Query: Select ename, sal, empno from emp where sal > 3000 order by ename desc;
SELECT ename, sal, empno
FROM emp
WHERE sal > 3000
ORDER BY ename DESC;

-- Sample query using GROUP BY
-- Query: Select job, count(ename) from emp group by job order by job;
SELECT job, COUNT(ename)
FROM emp
GROUP BY job
ORDER BY job;

-- Sample query using GROUP BY and HAVING with dynamic input
-- Dynamic Input: Set the @min_job_count variable to filter departments with a minimum number of employees with a specific job
DECLARE @min_job_count INT;
SET @min_job_count = 5;

SELECT COUNT(job), deptno
FROM emp
GROUP BY deptno
HAVING COUNT(job) >= @min_job_count;



-------------------------------------------------------------------------------------



-- Dynamic Input: Set the @salary_list variable to filter employees with specific salaries
DECLARE @salary_list TABLE (salary INT);
INSERT INTO @salary_list VALUES (1500), (2500), (3000), (50000);

-- Using ANY operator
-- Query: SELECT ENAME, SAL FROM EMP WHERE SAL = ANY(SELECT salary FROM @salary_list);
SELECT ENAME, SAL
FROM EMP
WHERE SAL = ANY(SELECT salary FROM @salary_list);

-- Using ALL operator (Note: This may not be practical as explained earlier)
-- Query: SELECT ENAME, SAL FROM EMP WHERE SAL = ALL(SELECT salary FROM @salary_list);
SELECT ENAME, SAL
FROM EMP
WHERE SAL = ALL(SELECT salary FROM @salary_list);

-- Using SOME operator with dynamic input
-- Dynamic Input: Set the @min_salary variable to filter employees whose salary is greater than some values returned by the subquery
DECLARE @min_salary INT;
SET @min_salary = 2500;

-- Query: SELECT ENAME, SAL FROM EMP WHERE SAL > SOME(SELECT salary FROM @salary_list WHERE salary > @min_salary);
SELECT ENAME, SAL
FROM EMP
WHERE SAL > SOME(SELECT salary FROM @salary_list WHERE salary > @min_salary);


-------------------------------------------------------------------------------------


-- Dynamic Input: Set the @new_column_name variable to specify the new column name
DECLARE @new_column_name NVARCHAR(50);
SET @new_column_name = 'mgr';

-- ALTER: Add a new column to the table "emp1"
-- Query: ALTER TABLE emp1 ADD (mgr NUMBER(10));
ALTER TABLE emp1 ADD (@new_column_name NUMBER(10));

-- ALTER: Modify the data type of the column "ename" in the table "emp1"
-- Dynamic Input: Set the @new_data_type variable to specify the new data type for the "ename" column
DECLARE @new_data_type NVARCHAR(50);
SET @new_data_type = 'VARCHAR2(10)';

-- Query: ALTER TABLE emp1 MODIFY ename @new_data_type;
ALTER TABLE emp1 MODIFY ename @new_data_type;

-- ALTER: Drop the column "job" from the table "emp1"
-- Query: ALTER TABLE emp1 DROP COLUMN job;
ALTER TABLE emp1 DROP COLUMN job;

-- ALTER: Rename the column "eno" to "enum" in the table "emp1"
-- Dynamic Input: Set the @new_column_name variable to specify the new name for the "eno" column
SET @new_column_name = 'enum';

-- Query: ALTER TABLE emp1 RENAME COLUMN eno TO @new_column_name;
ALTER TABLE emp1 RENAME COLUMN eno TO @new_column_name;

-- TRUNCATE: Truncate the table "emp2"
-- Query: TRUNCATE TABLE emp2;
TRUNCATE TABLE emp2;

-- DROP: Drop the table specified in the @table_name variable
-- Dynamic Input: Set the @table_name variable to specify the table to be dropped
DECLARE @table_name NVARCHAR(50);
SET @table_name = 'emp2';

-- Query: DROP TABLE @table_name;
DROP TABLE @table_name;
