use sales;
show tables;

-- adding new column normalised_amount to transactions table and assigning value
alter table transactions add Normalised_amount double;
update transactions set normalised_amount= sales_amount;
update transactions set normalised_amount= sales_amount*79.64 where currency='USD' ;

-- calculating total revenue
select sum(normalised_amount) as Total_Revenue from transactions ;

-- calculating total quantity
select sum(sales_qty) as sales_quantity from transactions 
where sales_amount>=1;

--  query to see revenue by markets
select sum(normalised_amount),markets.markets_name from transactions left join markets
on transactions.market_code=markets.markets_code
group by transactions.market_code 
order by sum(normalised_amount) desc;

--  query to see sales_quantity by markets
select sum(sales_qty),markets.markets_name from transactions left join markets
on transactions.market_code=markets.markets_code where sales_amount>=1
group by transactions.market_code 
order by sum(sales_qty) desc ;

-- top 5 customers
select sum(normalised_amount),customers.custmer_name from transactions left join customers
on transactions.customer_code=customers.customer_code 
group by transactions.customer_code
order by sum(normalised_amount) desc limit 5;

-- top 5 products
select sum(normalised_amount),products.product_code from transactions inner join products 
on transactions.product_code=products.product_code
group by transactions.product_code 
order by sum(normalised_amount) desc;
