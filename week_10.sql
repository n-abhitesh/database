--Find salary of employee whose name starts with ‘s’ and dept num is 10

DECLARE
    v_salary employees.salary%TYPE;
BEGIN
    SELECT salary
    INTO v_salary
    FROM employees
    WHERE emp_name LIKE 'S%' AND dept_num = 10;

    DBMS_OUTPUT.PUT_LINE('Salary of the employee: ' || v_salary);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;



--Update the job name for all employees as ‘Sr Manager’ whose experience is >5 and working present as ‘Manager’.

DECLARE
    v_experience NUMBER;
BEGIN
    -- Calculate experience for employees working as 'Manager'
    SELECT (SYSDATE - hire_date) / 365 INTO v_experience
    FROM employees
    WHERE job = 'Manager';

    -- Update job to 'Sr Manager' for employees with experience > 5
    UPDATE employees
    SET job = 'Sr Manager'
    WHERE job = 'Manager' AND v_experience > 5;
    
    -- Commit the changes
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No Manager found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
END;



--Print annual salary of all employees working in dept number 30. plsql

BEGIN
    FOR emp_rec IN (SELECT emp_id, emp_name, salary FROM employees WHERE dept_num = 30)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Employee: ' || emp_rec.emp_name || ', Annual Salary: ' || (emp_rec.salary * 12));
    END LOOP;
END;


--Print average salary for each dept. plsql


BEGIN
    FOR dept_rec IN (SELECT dept_num, AVG(salary) AS avg_salary FROM employees GROUP BY dept_num)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Department: ' || dept_rec.dept_num || ', Average Salary: ' || dept_rec.avg_salary);
    END LOOP;
END;



--Find all employees who are drawing highest salary in their dept plsql


DECLARE
    CURSOR c_emp_salaries IS
        SELECT emp_id, emp_name, dept_num, salary,
               RANK() OVER (PARTITION BY dept_num ORDER BY salary DESC) AS rnk
        FROM employees;
BEGIN
    FOR emp_rec IN c_emp_salaries
    LOOP
        IF emp_rec.rnk = 1 THEN
            DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_rec.emp_id ||
                                 ', Employee Name: ' || emp_rec.emp_name ||
                                 ', Department: ' || emp_rec.dept_num ||
                                 ', Highest Salary: ' || emp_rec.salary);
        END IF;
    END LOOP;
END;




--Update salary of employees with following criteria:
--DNO Experience Percentage Rise
--in salary
--10 >5 10
--20 >=5 15
--30 >=10 18
--40 >=10 20 plsql


BEGIN
    UPDATE employees
    SET salary = 
        CASE 
            WHEN dept_num = 10 AND experience > 5 THEN salary * 1.10
            WHEN dept_num = 20 AND experience >= 5 THEN salary * 1.15
            WHEN dept_num = 30 AND experience >= 10 THEN salary * 1.18
            WHEN dept_num = 40 AND experience >= 10 THEN salary * 1.20
        END
    WHERE (dept_num = 10 AND experience > 5)
       OR (dept_num = 20 AND experience >= 5)
       OR (dept_num = 30 AND experience >= 10)
       OR (dept_num = 40 AND experience >= 10);
    
    COMMIT;
END;


