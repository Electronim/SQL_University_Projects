-- 2
SELECT  ROUND(MAX(salary)) Maxim,
        ROUND(MIN(salary)) Minim,
        ROUND(SUM(salary)) Suma, 
        ROUND(AVG(salary)) Media
FROM employees;

-- 3
select job_id, max(salary), min(salary), sum(salary), avg(salary)
from employees
group by job_id;

-- 4
select job_id, count(employee_id)
from employees
group by job_id;

-- 5
select count(distinct manager_id)
from employees;

-- 6
select round(max(avg(salary)) - min(avg(salary))) Diferenta
from employees
group by department_id;

-- 7
select d.department_id, max(d.location_id), count(e.employee_id), min(e.salary)
from employees e, departments d
where d.department_id = e.department_id
group by d.department_id;

-- 8
-- 9
-- 10
-- 11

-- 12
select d.department_id, max(d.department_name), sum(e.salary)
from employees e, departments d
where e.department_id = d.department_id
group by d.department_id;

-- 14
select j.job_id, max(job_title), avg(salary)
from jobs j
join employees e on (e.job_id = j.job_id)
group by j.job_id
having (avg(salary) = (select min(avg(salary)) from employees group by job_id));

-- 15
select avg(salary)
from employees
having avg(salary) > 2500;

-- 16
select e.department_id, e.job_id, sum(salary)
from employees e
left join departments d on e.department_id = d.department_id
join jobs j on j.job_id = e.job_id
group by e.department_id, e.job_id;

-- 17
select d.department_name, min(e.salary)
from employees e, departments d
where e.department_id = d.department_id (+)
group by d.department_id, d.department_name
having avg(e.salary) = (select max(avg(salary)) from employees group by department_id);

-- 18
select department_id, d.department_name, count(e.employee_id)
from employees e
full join departments d using (department_id)
group by department_id, d.department_name
having count(employee_id) <= 4;

-- 19
select extract(day from hire_date), last_name, hire_date
from employees
where extract(day from hire_date) = (
    select extract(day from hire_date)
    from employees
    group by extract(day from hire_date)
    having count(*) = (
        select max(count(*))
        from employees
        group by extract(day from hire_date)));
        
-- 20
select count(count(*))
from employees e
left join departments d on e.department_id = d.department_id
group by d.department_id
having count(*) >= 15;

-- 21
select d.department_id, sum(salary)
from employees e
left join departments d on e.department_id = d.department_id
where nvl(d.department_id, 0) != 30
group by d.department_id
having count(*) >= 10;

-- 22
select  d.department_id,
        d.department_name,
        count(ee.employee_id),
        avg(ee.salary),
        e.last_name,
        e.salary,
        e.job_id
from employees ee
join employees e on (nvl(e.department_id, -1) = nvl(ee.department_id, -1))
full join departments d on ee.department_id = d.department_id
group by d.department_id, d.department_name, e.last_name, e.salary, e.job_id
order by 1;

-- 23
select min(l.city), min(d.department_name), min(j.job_title), sum(salary)
from employees e
left join departments d on e.department_id = d.department_id
join jobs j on e.job_id = j.job_id
left join locations l on d.location_id = l.location_id
where d.department_id > 80
group by (d.department_id, j.job_id)
order by d.department_id;

-- cu afisarea departamentelor fara angajati
select min(l.city), min(d.department_name), min(j.job_title), sum(salary)
from employees e
full join departments d on e.department_id = d.department_id
full join jobs j on e.job_id = j.job_id
left join locations l on d.location_id = l.location_id
where d.department_id > 80
group by (d.department_id, j.job_id)
order by d.department_id;

-- 24
select max(e.last_name), count(j.employee_id)
from employees e, job_history j
where e.employee_id = j.employee_id
having count(j.employee_id) >= 2
group by j.employee_id;

-- 25
SELECT AVG(commission_pct)
FROM employees;

SELECT AVG(NVL(commission_pct, 0))
FROM employees;

SELECT SUM(commission_pct)/COUNT(*)
FROM employees;

-- 26

