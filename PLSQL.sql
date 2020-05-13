--1. 

<< out_blockone >>  -- usually block name is optional
DECLARE
      n_outerblock      NUMBER(6) := 100;            
BEGIN
   DBMS_OUTPUT.PUT_LINE ('Printout from outer block, n_outerblock is '||
       n_outerblock || '.');
           
   DBMS_OUTPUT.PUT_LINE ('End of outer block - - - - - - ');
           
-- below is a subunit, or called inner block, enclosed block, child block
  DECLARE
    n_innerblock NUMBER(6) := 99;
    n_outerblock NUMBER(6) := 88;
-- same name, over-write the global variable
  BEGIN
      DBMS_OUTPUT.PUT_LINE
              ('Printout from inner block, n_innerrblock is ' ||
            n_innerblock || '.');
           
      DBMS_OUTPUT.PUT_LINE
      ('Printout from inner block, n_outerblock defined in inner block is '||
            n_outerblock || '.');
      DBMS_OUTPUT.PUT_LINE
        ('Printout from inner block, n_outerblock in outer block is ');
            -- Add your statement here
      DBMS_OUTPUT.PUT_LINE
        ('Printout from inner block, n_outerblock in outer block is ' || out_blockone.n_outerblock || '.');   
    END;
END out_blockone;


--2.


DECLARE
        dept_id        departments.department_id%TYPE := 299;
        dept_name      departments.department_name%TYPE := 'Future';
        manager        departments.manager_id%TYPE := 145;
        location       departments.location_id%TYPE := 1700;

BEGIN
        INSERT INTO departments (department_id, department_name, manager_id, location_id)
        VALUES (dept_id, dept_name, manager, location);

	DBMS_OUTPUT.PUT_LINE ('after insertion: new record where department ID is ' || dept_id 
			      || ', department name is ' || dept_name || ', manager id is ' || manager || ', 
			      and location id is ' || location || '.');

END;


--3.

DECLARE
        dept_name      departments.department_name%TYPE;
        manager        departments.manager_id%TYPE;

BEGIN
	DELETE FROM departments 
	WHERE department_id = 299
	RETURNING department_name, manager_id
	INTO dept_name, manager;

	DBMS_OUTPUT.PUT_LINE('after deletion: the record deleted had department name of ' || dept_name || ' and manager id of ' || manager || '.');
END;



--4. NOTE: this is not working


DECLARE
	empid   	employees.employee_id%TYPE ;
	e_last_name  	employees.last_name%TYPE;
        num_no_dept	integer ;

BEGIN
         
   SELECT count (*) into num_no_dept 
	from employees where department_ID is null;

   If num_no_dept = 1 then
	
	SELECT employee_id, last_name into empid, e_last_name 
	from employees where department_ID is null;

        UPDATE employees
	SET    department_ID = 60
	WHERE  employee_id  = empid;
       
        DBMS_OUTPUT.PUT_LINE ('The employee with id ' ||
            empid || ', last name as '|| e_last_name ||
        ' is now assigned to department 60. ') ;
   else
      DBMS_OUTPUT.PUT_LINE ('The employee without dept is not one. ' );
   end if;
   -- rollback;
END;
/
-- ROLLBACK;



--5.

DECLARE
        this_salary     employees.salary%TYPE;
BEGIN
        SELECT AVG(employees.SALARY) INTO this_salary
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID = 50;

        CASE
            WHEN this_salary > 3500 THEN DBMS_OUTPUT.PUT_LINE('high');
            WHEN this_salary > 2500 AND this_salary < 3500 THEN DBMS_OUTPUT.PUT_LINE('ok');
            WHEN this_salary < 2500 THEN DBMS_OUTPUT.PUT_LINE('low');    
        END CASE;
END;




--6. NOTE: Have to change the employee_id in the BEGIN block to view different employee's results


DECLARE
        this_salary             employees.salary%TYPE;
        this_hire_date          employees.hire_date%TYPE;
        this_employee_id        employees.employee_id%TYPE;
        this_years              NUMBER;
        extra_bonus             employees.salary%TYPE;
        TOTAL_BONUS_AMT         employees.salary%TYPE;
        
BEGIN
    select salary INTO this_salary
    from employees
    where employee_id = 114;

    SELECT hire_date INTO this_hire_date
    from employees
    where employee_id = 114;

    SELECT FLOOR(months_between(sysdate, this_hire_date) / 12) into this_years
    from employees
    where employee_id = 114;


    IF this_salary >= 10000 THEN
        extra_bonus := 200;
    ELSIF this_salary >= 6000 AND this_salary < 10000 THEN
        extra_bonus := 400;
    ELSIF this_salary < 6000 THEN
        extra_bonus := 800;
    END IF;


    --if this_years is more than 23, 500 initial + 240 + extra_bonus
    --otherwise just 500 + extra bonus
    IF this_years > 23 THEN
        total_bonus_amt := 500 + 240 + extra_bonus;
    ELSE
        total_bonus_amt := 500 + extra_bonus;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Total bonus amt for this employee: ' || total_bonus_amt);

END;


--7.


--Basic loop:

DECLARE
    X NUMBER := 11;
BEGIN
        LOOP
                x := x + 1;
                if x > 12 THEN
                        EXIT;
                end if;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('AFTER LOOP: X = ' || TO_CHAR(X));
END;



--For loop:

BEGIN
    FOR i IN 11 .. 13 loop
        DBMS_OUTPUT.PUT_LINE ('The value of i is: ' || TO_CHAR(i));
    END LOOP;
END;




--While loop:

DECLARE
    X NUMBER := 11;
BEGIN
        WHILE X < 13 LOOP
                DBMS_OUTPUT.PUT_LINE ('Inside loop: x = ' || TO_CHAR(x));
                x := x + 1;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('AFTER LOOP: X = ' || TO_CHAR(X));
END;





