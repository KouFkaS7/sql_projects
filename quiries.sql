CREATE TABLE supermarket_sales (
    Invoice_ID VARCHAR(11),
    Branch VARCHAR(10),
    City VARCHAR(10),
    Customer_type VARCHAR(10),
    Gender VARCHAR(10),
    Product_line VARCHAR(50),  -- Adjusted size
    Unit_price decimal(8, 2),  -- Assuming 8 digits with 2 decimal places
    Quantity int,
    Tax_5 decimal(8, 2),       -- Assuming 8 digits with 2 decimal places
    Total decimal(10, 2),      -- Assuming 10 digits with 2 decimal places
    Date_ date,
    time_ time,
    Payment varchar(20),
    cogs decimal(8, 2),        -- Assuming 8 digits with 2 decimal places
    gross_margin_percentage decimal(5, 2),  -- Adjusted for precision and scale
    gross_income decimal(10, 2),            -- Adjusted for precision and scale
    Rating decimal(3, 1)       -- Adjusted for typical rating scales
);

COPY supermarket_sales(
    Invoice_ID, Branch, City, Customer_type, Gender, Product_line, Unit_price, Quantity, 
    Tax_5, Total, Date_, time_, Payment, cogs, gross_margin_percentage, gross_income, Rating
)
FROM 'D:\\Portfolio\\Dataset\\sales\\supermarket_sales - Sheet1.csv'  -- Adjusted for escape character
DELIMITER ','
CSV HEADER;

select branch,sum(total)
from supermarket_sales
group by branch


select customer_type , sum(total) as total_sales 
from supermarket_sales
group by customer_type;

select payment , avg(total) as avg_sales
from supermarket_sales
group by payment

SELECT 
    product_line,
    SUM(CASE WHEN branch = 'A' THEN total ELSE 0 END) AS Sales_A,
    SUM(CASE WHEN branch = 'B' THEN total ELSE 0 END) AS Sales_B,
    SUM(CASE WHEN branch = 'C' THEN total ELSE 0 END) AS Sales_C
FROM 
    supermarket_sales
GROUP BY 
    product_line
ORDER BY 
    product_line;
	
	

SELECT
    CASE
        WHEN EXTRACT(HOUR FROM time_) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM time_) BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN EXTRACT(HOUR FROM time_) BETWEEN 17 AND 20 THEN 'Evening'
        ELSE 'Night'
    END AS Time_Slot,
    COUNT(*) AS Transactions_Count
FROM
    supermarket_sales
GROUP BY
    Time_Slot
ORDER BY
    Transactions_Count DESC;



