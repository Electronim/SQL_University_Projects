-- Problema 1
select concat(concat(first_name, ' '), last_name) || ' castiga ' || salary || 
    concat(' dar doreste ', salary * 3) "Salariu ideal"
from employees;

-- Problema 2
select initcap(first_name) "Prenume", upper(last_name) "Nume", length(last_name) "Lungime nume"
from employees
-- where ( (substr(last_name, 1, 1) in ('J', 'M'))
--     or  (substr(last_name, 3, 1) in ('A') ))

where ( last_name like 'J%' or last_name like 'M%' or last_name like '__a%')
order by length(last_name) desc;

-- Problema 3
select employee_id "ID", last_name "Nume", department_id "Department"
from employees
where lower(trim(both from first_name)) = 'steven';

-- Problema 4
select employee_id "ID", last_name "Nume", length(last_name) "Lungime nume",
        instr(lower(last_name), 'a') "Fst pos a in name"
from employees
-- where lower(last_name) like '%e';
-- where substr(last_name, length(last_name), 1) = ‘e’;
where substr(last_name, -1) = 'e';


-- Problema 5
select first_name, last_name, hire_date
from employees
where mod(round(sysdate - hire_date), 7) = 0;

-- Problema 6
select employee_id,
    last_name, 
    salary, 
    round(1.15 * salary, 2),
    round(1.15 * salary / 100, 2)
from employees;

-- Problema 7
select last_name,
    RPAD(hire_date, 20) hire_date
from employees
where commission_pct is not null;

-- Problema 8
select to_char(sysdate + 30, 'MONTH DD YYYY HH24:MI:SS')
from dual;

-- Problema 9
select to_date('31-12-' || extract(year from sysdate), 'DD-MM-YYYY') - trunc(sysdate)
from dual;

-- Problema 10a)
select to_char(sysdate + 0.5, 'dd/mm/yyyy hh24:mi')
from dual;

-- Problema 10b)
select to_char(sysdate + 5/60/24, 'dd/mm/yyyy hh24:mi')
from dual;

-- Problema 11
select last_name || ' ' || first_name "Nume prenume",
    hire_date,
    next_day(add_months(hire_date, 6), 'Monday') "Negociere"
from employees;

-- Problema 12
select last_name, round(months_between(sysdate, hire_date)) "Luni lucrate"
from employees
order by "Luni lucrate";

-- Problema 13
select last_name, hire_date, to_char(hire_date, 'day') "Zi"
from employees
order by to_char(hire_date - 1, 'd') asc;

-- Problema 14
select last_name, nvl(to_char(commission_pct), 'Fara comision') "Comision"
from employees;

-- Problema 15
select last_name, salary, commission_pct
from employees
where salary + nvl(commission_pct, 0) * salary > 10000;

-- Problema 16
select last_name, 
    job_id, 
    salary,
    decode(job_id, 'IT_PROG', salary * 1.2,
            'SA_REP', salary * 1.25,
            'SA_MAN', salary * 1.35,
            salary) "Salariu renegociat"
from employees;

-- Problema 17
select last_name, e.department_id, department_name
from employees e, departments d
where e.department_id = d.department_id;

-- Problema 18
select distinct j.job_id, j.job_title
from jobs j, employees e
where j.job_id = e.job_id and e.department_id = 30;

-- Problema 19
select last_name, department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and e.commission_pct is not null;

-- Problema 20 TODO

-- Problema 21
select last_name, job_title, department_name
from employees e, jobs j, departments d, locations l
where e.job_id = j.job_id
    and e.department_id = d.department_id
    and d.location_id = l.location_id
    and l.city = 'Oxford';
    
-- Problema 22
select e.employee_id "Ang#", e.last_name "Angajat", m.employee_id "Man#", m.last_name "Manager"
from employees e, employees m
where e.manager_id = m.employee_id; -- inner-join

-- Problema 23
select e.employee_id "Ang#", e.last_name "Angajat", m.employee_id "Man#", m.last_name "Manager"
from employees e, employees m
where e.manager_id = m.employee_id (+); -- outer-join

-- Problema 24
select e1.last_name "Nume angajat",
    e1.department_id "Cod departament",
    e2.last_name "Colegi"
from employees e1, employees e2
where e1.employee_id < e2.employee_id
    and e1.department_id = e2.department_id;


-- Problema 27
select e1.last_name, e1.hire_date
from employees e1, employees e2
where e1.manager_id = e2.employee_id and
    e1.hire_date < e2.hire_date;