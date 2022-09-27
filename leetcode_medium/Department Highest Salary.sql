-- https://leetcode.com/problems/department-highest-salary/

/* Write your T-SQL query statement below */
SELECT final.depart AS Department, e1.name AS Employee, final.maximum AS Salary
FROM employee e1
    JOIN (
SELECT f.departmentId AS dept_id, d.name AS depart, f.maxi AS maximum
FROM department d
    JOIN (SELECT DepartmentId, MAX(Salary) AS maxi
FROM employee
GROUP BY DepartmentId) f
    ON f.DepartmentId=d.id ) final
        ON final.dept_id=e1.DepartmentId AND
            final.maximum=e1.salary;


-- 02
WITH cte AS(
SELECT d.name AS dept, e.name AS emp, e.salary AS sal, RANK() OVER (PARTITION BY DepartmentId ORDER BY salary DESC) AS ranking
FROM employee e
    JOIN Department d
        ON e.departmentId=d.id
)

SELECT cte.dept AS Department, cte.emp AS Employee, cte.sal AS Salary
FROM cte
WHERE ranking=1;