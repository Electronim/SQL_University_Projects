-- Laborator 1
-- Problema 3
desc employees;
desc departments;
desc jobs;
desc locations;
desc job_history;

-- Problema 4
select * from employees;
select * from departments;
select * from jobs;
select * from job_history;

-- Problema 5
select employee_id, last_name, job_id, hire_date
from employees;

-- Problema 6
select employee_id as cod, last_name nume, job_id "cod job", hire_date "Data angajarii"
from employees;

-- Problema 7
select job_id "Cod job"
from employees;

select distinct job_id "Cod job"
from employees;

-- Problema 8
select last_name || ', ' || job_id "Angajat si titlu"
from employees;

-- Problema 9 -> tema

-- Problema 10
desc employees;
select last_name, salary
from employees
where salary > 2850;

-- Problema 11
select last_name, department_id
from employees
where employee_id = 104;

-- Problema 12
select last_name, salary
from employees
where salary not between 1500 and 2850;

-- Problema 13
desc employees;
select last_name, job_id, hire_date
from employees
where hire_date between to_date('20/02/1987', 'dd/mm/yyyy') and to_date('01/05/1989', 'dd/mm/yyyy')
order by 3 asc;

-- Problema 14
select last_name "Nume", department_id "Departament"
from employees
where department_id in (10, 30, 50)
order by last_name asc;

-- Problema 15
select last_name "Angajat", salary "Salariu lunar"
from employees
where salary > 1500 and department_id in (10, 30, 50);

-- Problema 16
select sysdate from dual;
select to_char(sysdate, 'd/dd/day/mm/month/yyyy/year hh24:mi::ss:sssss') "Zi si ora" from dual;

-- Problema 17
select last_name "Nume", hire_date "Data angajarii"
from employees
where extract (year from hire_date) = 1987;
-- where hire_date like '%87%';
-- where to_char(hire_date, 'yyyy') = '1987';

-- Problema 18
select last_name "Nume", first_name "Prenume", hire_date "Data angajarii"
from employees
where extract(day from hire_date) = extract(day from sysdate);

-- Problema 19
select last_name, job_id
from employees
where manager_id is null;

-- Problema 20
select last_name, salary, commission_pct
from employees
where commission_pct is not null
order by salary desc, 3 desc;

-- Problema 21
-- daca comentez where de mai sus, (null) se pune in fata valorilor in ordine desc

-- Problema 22
select last_name
from employees
where last_name like '__a%';

-- Problema 23
select last_name
from employees
where lower(last_name) like '%l%l%'
and (department_id = 30 or manager_id = 102);

-- Problema 24
select distinct job_id from employees;

select last_name, job_id, salary
from employees
where (lower(job_id) like '%clerk%' or lower(job_id) like '%rep%')
and salary not in (1000, 2000, 3000);

-- Problema 25
select * from departments
where manager_id is null;
