------------------------------------------------
--Retrieve all tuples from emp table where only matching tuples from emp and dept are displayed.

SELECT e.*
FROM emp e
INNER JOIN dept d ON e.deptno = d.deptno;



---------------------------------------------
--Display all emp details whose dname details are not present in dept table


SELECT e.*
FROM emp e
LEFT JOIN dept d ON e.deptno = d.deptno
WHERE d.dname IS NULL;


--------------------------------------------------
--List all emp names and dept names whose department details are available in dept table.

SELECT e.ename AS emp_name, d.dname AS dept_name
FROM emp e
INNER JOIN dept d ON e.deptno = d.deptno;



----------------------------------------------------------------
--List all emp names and their salary according to their deptno

SELECT ename AS emp_name, sal AS emp_salary
FROM emp
ORDER BY deptno;



-----------------------------------------------------------------------
--Find all emp details for whom matching dept number is found in dept table and also display emp details whose details(dno) are not found in dept table


SELECT e.*
FROM emp e
LEFT JOIN dept d ON e.dno = d.deptno
WHERE d.deptno IS NOT NULL
   OR d.deptno IS NULL;



---------------------------------------------------------------------------
--Display all department details where the dept number is found in emp table , also display the dept details whose details not found in emp table


SELECT d.*
FROM dept d
INNER JOIN emp e ON d.deptno = e.deptno

UNION

SELECT d.*
FROM dept d
LEFT JOIN emp e ON d.deptno = e.deptno
WHERE e.deptno IS NULL;



