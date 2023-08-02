--Display the distinct emp ids and first names of employees who have joined their job in the month of June using a subquery


SELECT DISTINCT emp_id, first_name
FROM employees
WHERE emp_id IN (
    SELECT emp_id
    FROM employees
    WHERE MONTH(join_date) = 6
);



--Design a subquery to select the first name of emp with the maximum value of emp id

SELECT first_name
FROM employees
WHERE emp_id = (
    SELECT MAX(emp_id) 
    FROM employees
);


--Display all emp details who work for atleast one dept


SELECT *
FROM emp e
WHERE EXISTS (
    SELECT 1
    FROM dept d
    WHERE d.emp_id = e.emp_id
);



--Display all emp names taking highest salary using subquery.


SELECT emp_name
FROM emp
WHERE salary = (
    SELECT MAX(salary)
    FROM emp
);



--Display all emp names and ids whose job name is same as Smith’s job title


SELECT emp_id, emp_name
FROM emp
WHERE job = (
    SELECT job
    FROM emp
    WHERE ename = 'Smith'
);



--Retrieve ename, sal, deptno of all emp’s who are taking minimum salary in each dept, display your result according to deptnum.


WITH RankedEmp AS (
  SELECT ename, sal, deptno, RANK() OVER (PARTITION BY deptno ORDER BY sal) AS rnk
  FROM emp
)
SELECT ename, sal, deptno
FROM RankedEmp
WHERE rnk = 1
ORDER BY deptno;



--Retrieve all emp numbers, salary and names who are taking salary greater than the employees working as ‘CLERK’ but not working as ‘CLERK’



SELECT empno, sal, ename
FROM emp
WHERE sal > (
    SELECT MAX(sal)
    FROM emp
    WHERE job = 'CLERK'
) AND job <> 'CLERK';



--Retrieve all emp numbers, salary and names whose salary is greater than the average salary paid by each dept. (You may use groub by)


SELECT empno, sal, ename
FROM emp
WHERE sal > (
    SELECT AVG(sal)
    FROM emp e2
    WHERE e2.deptno = emp.deptno
)
