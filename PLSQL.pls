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

							   
							   
							   
--below is practive with Records and Prcedures

							   
--Problem 1

DECLARE
	TYPE Emp_phone IS RECORD
        	( last_name     VARCHAR2(25), 
          	  first_name    VARCHAR2(20), 
          	  phone         VARCHAR2(20));
  	V1        Emp_phone;

--retrieve info of employee with ID 160, insert into record
BEGIN
	SELECT last_name, first_name, phone_number
        INTO V1
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = 160;

--print out contents of that record
	DBMS_OUTPUT.PUT_LINE(TO_CHAR(v1.last_name) || ' ' || v1.first_name|| '   ' || v1.phone|| '   .');
END;


--Problem 2

DROP TABLE PHONEBOOK;
CREATE TABLE PHONEBOOK(
    Last_name   VARCHAR2(20),
    First_name  VARCHAR2(20),
    Area_code   VARCHAR2(3),
    Prefix      VARCHAR2(3),
    Num         VARCHAR2(4)
);

DECLARE
    TYPE phone_num IS RECORD
        (lname        VARCHAR2(20),
         fname        VARCHAR2(20),
         areacode     VARCHAR2(3),
         prefix       VARCHAR2(3),
         ph_num       VARCHAR2(4)
         );

    
    CURSOR c IS
    SELECT last_name, first_name, phone_number
    FROM employees
    WHERE department_id in (20,80,90);
    
    p1   phone_num;

BEGIN
    FOR indx in c LOOP
        IF SUBSTR (indx.phone_number, 1, 3 ) = '011' THEN
                    p1.lname := indx.last_name;
                    p1.fname := indx.first_name;
                    p1.areacode := NULL;
                    p1.prefix    := NULL;
                    p1.ph_num    := NULL;

        ELSE
            p1.lname := indx.last_name;
            p1.fname := indx.first_name;
            p1.areacode  := SUBSTR (indx.phone_number, 1, 3 );
            p1.prefix    := SUBSTR (indx.phone_number, 5, 3 );
            p1.ph_num    := SUBSTR (indx.phone_number, 9, 4 );
        END IF;        
        INSERT INTO phonebook VALUES p1;        
    END LOOP;
END;

select * from phonebook;



-Problem 3

DROP TABLE PHONEBOOK;
CREATE TABLE PHONEBOOK(
    Last_name   VARCHAR2(20),
    First_name  VARCHAR2(20),
    Area_code   VARCHAR2(3),
    Prefix      VARCHAR2(3),
    Num         VARCHAR2(4)
);

DECLARE
    TYPE phone_num IS RECORD
        (lname        VARCHAR2(20),
         fname        VARCHAR2(20),
         areacode     VARCHAR2(3),
         prefix       VARCHAR2(3),
         ph_num       VARCHAR2(4)
         );

    TYPE NTphonebook IS TABLE OF phone_num;
    v1   NTphonebook := NTphonebook();
    
    CURSOR c IS
    SELECT last_name, first_name, phone_number
    FROM employees
    WHERE department_id in (20,80,90);
    
    i       NUMBER;
    v_n     INTEGER := 0;
    
BEGIN

--RETRIEVE data from employees table, populate NT, print out data
    FOR INDX IN C LOOP
            v_n := v_n + 1;
            v1.extend;
            IF SUBSTR (indx.phone_number, 1, 3 ) = '011' THEN
                    V1(v_n).lname := indx.last_name;
                    V1(v_n).fname := indx.first_name;
                    V1(v_n).areacode := NULL;
                    V1(v_n).prefix    := NULL;
                    V1(v_n).ph_num    := NULL;
            ELSE
                V1(v_n).lname := indx.last_name;
                V1(v_n).fname := indx.first_name;
                V1(v_n).areacode  := SUBSTR (indx.phone_number, 1, 3 );
                V1(v_n).prefix    := SUBSTR (indx.phone_number, 5, 3 );
                V1(v_n).ph_num    := SUBSTR (indx.phone_number, 9, 4 );
            END IF;    
    END LOOP;
    
        FOR i IN v1.FIRST .. v1.LAST LOOP
            DBMS_OUTPUT.PUT_LINE('result: ' || v1(i).lname || ' '||  v1(i).fname || ' ' || v1(i).areacode || v1(i).prefix || v1(i).ph_num);
            
        END LOOP;
END;


--Problem 4


DECLARE
    TYPE empcurtyp IS REF CURSOR RETURN employees%ROWTYPE;
    emp_cur        empcurtyp;
    v_employee     employees%ROWTYPE;

BEGIN

    OPEN emp_cur FOR
        SELECT * FROM employees
        WHERE department_id = 100
        ORDER BY last_name;
    
    DBMS_OUTPUT.PUT_LINE('Output for dept 100:');
    LOOP
        FETCH emp_cur INTO v_employee;
        EXIT WHEN emp_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('First name: ' || v_employee.first_name || ' Last name: ' || v_employee.last_name || '.');
    END LOOP;


    OPEN emp_cur FOR
        SELECT * FROM employees
        WHERE department_id = 30
        ORDER BY last_name;
    
    DBMS_OUTPUT.PUT_LINE('-----------');
    DBMS_OUTPUT.PUT_LINE('Output for dept 30:');
    LOOP
        FETCH emp_cur INTO v_employee;
        EXIT WHEN emp_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('First name: ' || v_employee.first_name || ' Last name: ' || v_employee.last_name || '.');
    END LOOP;
    CLOSE emp_cur;
END;



--Problem 5


DECLARE
          avg_salary   employees.salary%TYPE;
          emp_count    NUMBER(5);

          PROCEDURE hw5(
                    dept_id     IN  employees.department_id%TYPE) AS
      BEGIN
            SELECT AVG(SALARY)
            INTO avg_salary
            FROM EMPLOYEES            
            WHERE DEPARTMENT_ID = DEPT_ID;
            
            SELECT COUNT(first_name)
            INTO emp_count
            FROM EMPLOYEES
            WHERE department_id = dept_id;
      END;

BEGIN
        HW5(100);
        DBMS_OUTPUT.PUT_LINE ('------------');    
        DBMS_OUTPUT.PUT_LINE ('NUMBER of employees in this department: ' || emp_count || '.');    
        DBMS_OUTPUT.PUT_LINE ('average salary of employees in this dept: ' || avg_salary || '.');    
END;



--Problem 6


DECLARE
           avg_salary   employees.salary%TYPE;
           emp_count    NUMBER(5);
           dept         employees.department_id%TYPE;
           
           CURSOR c IS
                select DISTINCT department_id
                from employees
                ORDER BY department_id;

           PROCEDURE hw5(
                    dept_id     IN  employees.department_id%TYPE) AS
            BEGIN
                SELECT AVG(SALARY)
                INTO avg_salary
                FROM EMPLOYEES            
                WHERE DEPARTMENT_ID = DEPT_ID;
            
                SELECT COUNT(first_name)
                INTO emp_count
                FROM EMPLOYEES
                WHERE department_id = dept_id;
            END;

BEGIN
        --use a cursor loop
        OPEN C;
        LOOP
            fetch c INTO dept;
            EXIT WHEN c%NOTFOUND;
            HW5(dept);
            DBMS_OUTPUT.PUT_LINE ('------------');    
            DBMS_OUTPUT.PUT_LINE ('results for department: ' || dept);    
            DBMS_OUTPUT.PUT_LINE ('NUMBER of employees in this department: ' || emp_count || '.');    
            DBMS_OUTPUT.PUT_LINE ('average salary of employees in this dept: ' || avg_salary || '.');    
        END LOOP;
        CLose c;
END;
