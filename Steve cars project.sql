INSERT INTO cars (car_id, make, type, style, cost_$)
VALUES (1, 'Honda', 'Civic', 'Sedan', 30000),
(2, 'Toyota', 'Corolla', 'Hatchback', 25000),
(3, 'Ford', 'Explorer', 'SUV', 40000),
(4, 'Chevrolet', 'Camaro', 'Coupe', 36000),
(5, 'BMW', 'X5', 'SUV', 55000),
(6, 'Audi', 'A4', 'Sedan', 48000),
(7, 'Mercedes', 'C-Class', 'Coupe', 60000),
(8, 'Nissan', 'Altima', 'Sedan', 26000);

INSERT INTO salesperson (salesperson_id, name, age, city)
VALUES (1, 'John Smith', 28, 'New York'),
(2, 'Emily Wong', 35, 'San Fran'),
(3, 'Tom Lee', 42, 'Seattle'),
(4, 'Lucy Chen', 31, 'LA');
select * from salesperson;
INSERT INTO sales (sales_id, car_id, salesman_id, purchase_date)
VALUES (1, 1, 1, '2021-01-01'),
(2, 3, 3, '2021-02-03'),
(3, 2, 2, '2021-02-10'),
(4, 5, 4, '2021-03-01'),
(5, 8, 1, '2021-04-02'),
(6, 2, 1, '2021-05-05'),
(7, 4, 2, '2021-06-07'),
(8, 5, 3, '2021-07-09'),
(9, 2, 4, '2022-01-01'),
(10, 1, 3, '2022-02-03'),
(11, 8, 2, '2022-02-10'),
(12, 7, 2, '2022-03-01'),
(13, 5, 3, '2022-04-02'),
(14, 3, 1, '2022-05-05'),
(15, 5, 4, '2022-06-07'),
(16, 1, 2, '2022-07-09'),
(17, 2, 3, '2023-01-01'),
(18, 6, 3, '2023-02-03'),
(19, 7, 1, '2023-02-10'),
(20, 4, 4, '2023-03-01');
select * from sales

-------Question1-------
SELECT cars.* FROM cars
JOIN sales ON cars.car_id = sales.car_id
WHERE EXTRACT(YEAR FROM purchase_date) = 2022
order by car_id;


-----	Question 2 --------
select salesperson.salesperson_id, salesperson.name,count(sales.car_id) as total_car_sold
 from salesperson 
 join sales on salesperson.salesperson_id = sales.salesman_id
 group by salesperson.salesperson_id, salesperson.name
 order by  total_car_sold desc;

-----	Question 3 --------
select salesperson.salesperson_id,salesperson.name,sum(cars.cost_$) as total_revanue
from salesperson
left join sales on sales.salesman_id= salesperson.salesperson_id
left join cars on cars.car_id=sales.car_id
group by salesperson.salesperson_id,salesperson.name
order by total_revanue desc;

-----	Question 4 --------
select salesperson.salesperson_id,salesperson.name,cars.*
from salesperson 
join sales on salesperson.salesperson_id = sales.salesman_id
join  cars on cars.car_id=sales.car_id
order by salesperson.salesperson_id;

-----	Question 5 --------
select cars.car_id,cars.type,sum(cars.cost_$) as total_revenue
from cars
join sales on sales.car_id=cars.car_id
group by cars.type,cars.car_id
order by total_revenue desc;

-----	Question 6 --------
select cars.* from cars
join sales on cars.car_id=sales.sales_id
join salesperson on sales.salesman_id=salesperson.salesperson_id
where extract(year from purchase_date) = 2021 and salesperson.name='Emily Wong';

-----	Question 7 --------
select cars.car_id,cars.type,cars.make,cars.style, sum(cost_$) as total_ravenue
from cars
join sales on cars.car_id=sales.car_id 
where cars.style='hatchback'
group by cars.car_id,cars.style;

-----	Question 8 --------
select cars.car_id,cars.type,cars.make,cars.style, sum(cost_$) as total_ravenue
from cars
join sales on cars.car_id=sales.car_id 
where extract(year from purchase_date)=2022 and cars.style='SUV'
group by cars.style;

-----	Question 9 --------
select salesperson.salesperson_id,salesperson.name,salesperson.city,count(sales.car_id)
as total_car_sold from salesperson
join sales on cars.car_id=sales.car_id
join salesperson on sales.salesmen_id=salesperson.salesperson_id
where extract(year from sales.purchase_date)= 2023 
group by salesperson.salesperson_id,salesperson.name 
order by total_car_sold desc
limit 1;

-----	Question 10 --------
SELECT 
    salesperson.salesperson_id,
    salesperson.name,
    salesperson.age,
    SUM(cars.cost_$) as revenue
FROM 
    salesperson
JOIN 
    sales ON salesperson.salesperson_id = sales.salesman_id
JOIN 
    cars ON cars.car_id = sales.car_id
WHERE 
    EXTRACT(YEAR FROM sales.purchase_date) = 2022
GROUP BY 
    salesperson.salesperson_id, salesperson.name, salesperson.age
ORDER BY 
    revenue DESC
LIMIT 1;





