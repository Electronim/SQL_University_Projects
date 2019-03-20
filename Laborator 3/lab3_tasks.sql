


-- 7
select e.last_name, d.department_name
from employees e
left outer join departments d
on e.department_id = d.department_id;

-- 7(2)
select e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id (+);

-- 9
select e.last_name, d.department_name
from employees e
right join departments d
on e.department_id = d.department_id;

-- 9(2)
select e.last_name, d.department_name
from employees e, departments d
where e.department_id (+) = d.department_id;

-- 10
select e.last_name, d.department_name
from employees e
left join departments d
on e.department_id = d.department_id
union
select e.last_name, d.department_name
from employees e
right join departments d
on e.department_id = d.department_id;

-- 10(2)
select e.employee_id, e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id (+)
union
select e.employee_id, e.last_name, d.department_name
from employees e, departments d
where e.department_id (+) = d.department_id;

-- 10(3)
select e.last_name, d.department_name
from employees e
full join departments d
on e.department_id = d.department_id;

-- extra
select unique e.employee_id,
        e.last_name,
        d.department_name,
        e2.employee_id,
        e2.last_name
from employees e, departments d, employees e2
where e.department_id = d.department_id
    and e.department_id = e2.department_id
    and e.last_name = e2.last_name
    and e.employee_id < e2.employee_id;
    

-- 11
select d.department_id
from departments d
where lower(d.department_name) like '%re%'
union
select e.department_id
from employees e
where e.job_id = 'SA_REP';

-- 12
-- nu sunt unice

-- 13
select d.department_id
from departments d
minus
select unique department_id
from employees;

-- 13(2)
select d.department_id
from departments d
where d.department_id not in (
    select distinct nvl(department_id, 0)
    from employees);
    
-- 13(3)
select d.department_id
from departments d
where d.department_id not in (
    select distinct department_id
    from employees
    where department_id is not null);
    
-- 14
select d.department_id, d.department_name
from departments d
where lower(d.department_name) like '%re%'
intersect
select e.department_id, d.department_name
from employees e
join departments d
on (d.department_id = e.department_id)
where e.job_id = 'HR_REP';

-- 15
select e.employee_id, e.job_id, e.last_name
from employees e
where (e.salary > 3000)
union
select e.employee_id, e.job_id, e.last_name
from employees e
join jobs j
on (j.job_id = e.job_id)
where e.salary = (j.min_salary + j.max_salary) / 2;

-- 15(2)
select e.employee_id, e.job_id, e.last_name
from employees e
join jobs j on (e.job_id = j.job_id)
where e.salary > 3000 or e.salary = (j.min_salary + j.max_salary) / 2;

-- 16
select last_name, hire_date
from employees
where hire_date > (
    select hire_date
    from employees
    where initcap(last_name) = 'Gates');
    
-- 17
select last_name, salary
from employees
where department_id = (
    select department_id
    from employees
    where initcap(last_name) = 'Gates')
and initcap(last_name) <> 'Gates';

-- 18
select last_name, salary
from employees
where manager_id in (
    select employee_id
    from employees
    where manager_id is null);
    
-- 19
select last_name, department_id, salary
from employees
where (department_id, salary) in (
    select department_id, salary
    from employees
    where commission_pct is not null);
    
-- 21
select unique last_name
from employees e
where salary > ALL (
    select salary
    from employees
    where lower(job_id) like '%clerk%')
order by salary desc;
    
-- 22
select e.last_name, d.department_name, e.salary
from employees e, departments d
where (e.department_id = d.department_id) and e.commission_pct is null and e.manager_id in (
    select ee.employee_id
    from employees ee
    where ee.commission_pct is not null);


-- 23
    
-- 24
select last_name, department_id, job_id
from employees
where department_id in (
    select department_id
    from departments
    where location_id in (
        select location_id
        from locations
        where initcap(city) = 'Toronto'));
