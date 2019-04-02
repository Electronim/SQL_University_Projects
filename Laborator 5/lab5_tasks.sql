 -- 1a
select d.department_name, j.job_title, avg(e.salary)
from employees e, departments d, jobs j
where (e.job_id = j.job_id and d.department_id = e.department_id)
group by rollup(d.department_name, j.job_title);
 
 -- fara rollup
select d.department_name, j.job_title, round(avg(e.salary),2)
from employees e
full join departments d using (department_id)
join jobs j using (job_id)
group by d.department_name, j.job_title
UNION ALL
select d.department_name, null, round(avg(e.salary),2)
from employees e
full join departments d using (department_id)
join jobs j using (job_id)
group by d.department_name
UNION ALL
select null, null, round(avg(e.salary),2)
from employees e
full join departments d using (department_id)
join jobs j using (job_id);

-- 1b
select d.department_name, j.job_title, trunc(avg(e.salary)), grouping(department_name) Dep, grouping(job_title) Job
from employees e, departments d, jobs j
where (e.job_id = j.job_id and d.department_id = e.department_id)
group by rollup(d.department_name, j.job_title);

-- 2a
select d.department_name, j.job_title, avg(e.salary)
from employees e, departments d, jobs j
where (e.job_id = j.job_id and d.department_id = e.department_id)
group by cube(d.department_name, j.job_title);

-- 2b
select d.department_name, j.job_title, trunc(avg(e.salary)), grouping(department_name) Dep, grouping(job_title) Job
from employees e, departments d, jobs j
where (e.job_id = j.job_id and d.department_id = e.department_id)
group by cube(d.department_name, j.job_title);

-- 3
select d.department_name, j.job_title, e.manager_id, max(salary), sum(salary)
from employees e, departments d, jobs j
where (e.job_id = j.job_id and d.department_id = e.department_id)
group by grouping sets(
                (d.department_name, j.job_title, e.manager_id),
                (j.job_title, e.manager_id),
                ());
-- 4
select max(salary)
from employees
having max(salary) >= 15000;

-- 5a
select last_name, salary, department_id
from employees e
where salary > (select avg(salary)
                from employees
                where department_id = e.department_id);

-- 5b
select last_name, salary, e.department_id, department_name, 
    (select round(avg(salary)) from employees where nvl(department_id, -1) = nvl(e.department_id, -1)) Medie,
    (select count(*) from employees where nvl(department_id, -1) = nvl(e.department_id, -1)) NrAngajati
from employees e
left join departments d
on (e.department_id = d.department_id)
where salary >= (select avg(salary)
                from employees
                where nvl(department_id, -1) = nvl(e.department_id, -1));
                
-- 5bb
select last_name, salary, e.department_id, department_name, round(a.medie), a.nrAng
from (select ee.department_id, avg(ee.salary) medie, count(*) nrAng 
                    from employees ee
                    group by ee.department_id) a,
employees e
left join departments d on (e.department_id = d.department_id)
where (salary >= (select avg(salary)
                from employees
                where nvl(department_id, -1) = nvl(e.department_id, -1))
and nvl(e.department_id, -1) = nvl(a.department_id, -1));

-- 6
select e.last_name, e.salary
from employees e
where e.salary > all(
    select avg(salary)
    from employees
    group by department_id);

-- 7

-- 8
select e.last_name, d.department_name
from employees e left join departments d
on nvl(e.department_id, -1) = nvl(d.department_id, -1)
where e.hire_date = ( select min(hire_date)
                        from employees
                        where (nvl(e.department_id, -1) = nvl(department_id, -1))
                        group by department_id)
order by 2;

-- 9
SELECT last_name, salary
FROM employees e
WHERE department_id in (SELECT department_id
                        FROM employees
                        WHERE salary = (SELECT MAX(salary)
                                        FROM employees
                                        WHERE department_id = 30));
                                        
-- 10
select e.last_name, e.salary
from employees e
where 2 >= (select count(count(*))
            from employees ee
            where ee.salary > e.salary
            group by ee.salary)
order by 2 desc;

-- 11
select e.employee_id, e.last_name, e.first_name
from employees e
where 2 <= (select count(*)
            from employees ee
            where e.employee_id = ee.manager_id);

-- 12


