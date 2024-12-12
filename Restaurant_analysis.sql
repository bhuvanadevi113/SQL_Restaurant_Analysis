select * from menu_items; -- view menu item table

select count(*) from menu_items; -- Number of items in Menu
-- Least and most expencsive items
select * from menu_items
order by price DESC limit 1; 

select * from menu_items
order by price  limit 1; 

-- Dishes per category 
select category, count(*) as "number of items" from menu_items 
group by category;

-- What are the least and most expensive italian dishes on the menu


Select * from menu_items
where category = "Italian" 
order by price desc 
Limit 1;

Select * from menu_items
where category = "Italian" 
order by price  
Limit 1;

-- What is the average dish price within each category?
select category, avg(price) 
from menu_items
group by category;
-------------------------------------------------
-- Explore the order details table
-- view the order detail table
select * from order_details;

-- what is the date range of the table?
select min(order_date),max(order_date)
from order_details;

-- how many orders were made within this date range?
select count(distinct(order_id)) 
from order_details;

-- how many items were ordered withing this date range ?
select count(*) from order_details;

-- which orders had the most number of items ?
select order_id,count(item_id) as num_item
from order_details
group by order_id 
order by num_item desc;

-- how many orders had more than 12 items ?

select order_id,count(item_id) from order_details
group by order_id
having count(item_id)>12;


select count(*) as number_orders
from (select order_id,count(item_id) as num_item from order_details
group by order_id
having count(item_id)>12) as num_order;

-- Analyze customer behaviour
-- combine menu_items and order_details
select * from menu_items;
select * from order_details;

select o.order_details_id,o.order_id,o.order_date,o.order_time,o.item_id,
m.item_name,m.category,m.price
from order_details o
left join menu_items m 
on m.menu_item_id=o.item_id
order by 1

select count(*) from (select o.order_details_id,o.order_id,o.order_date,o.order_time,o.item_id,
m.item_name,m.category,m.price
from order_details o
left join menu_items m 
on m.menu_item_id=o.item_id
order by 1) as sub;

-- what were the least and most ordered items
select o.item_id, m.item_name,m.category, count(o.order_details_id) as numb_items 
from order_details o
left join menu_items m
on o.item_id=m.menu_item_id
group by 1,2,3
order by numb_items desc
limit 1;

select o.item_id, m.item_name,m.category, count(o.item_id) as numb_items 
from order_details o
left join menu_items m
on o.item_id=m.menu_item_id
where o.item_id is not null
group by 1,2,3
order by numb_items asc
limit 1;

-- what were the top 5 orders that spent most money

select o.order_id,sum(m.price) as price
from order_details o
left join menu_items m
on o.item_id=m.menu_item_id
group by 1
order by price desc
limit 5;

-- view the details of the highest spend order.what insights can you gather from the results?

select *
from order_details o
left join menu_items m
on o.item_id=m.menu_item_id
where order_id=440;

-- Group by category to understand which category is ordered most in this highest spend order
select category,count(item_id)
from order_details o
left join menu_items m
on o.item_id=m.menu_item_id
where order_id=440
group by category;

-- BONUS:View the details of the top 5 highest spend orders.what insights can you gather from the results?

select category,count(item_id)
from order_details o
left join menu_items m
on o.item_id=m.menu_item_id
where order_id in (440,2075,1957,330,2675)
group by category;

select order_id,category,count(item_id)
from order_details o
left join menu_items m
on o.item_id=m.menu_item_id
where order_id in (440,2075,1957,330,2675)
group by order_id,category;coffee_sales
