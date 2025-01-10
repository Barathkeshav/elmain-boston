-- Display all from customer
SELECT Customer_ID AS ID, First_Name AS Name, State, Date_of_Birth
FROM customer;

-- Display Distinct Shipping Partner Name
SELECT DISTINCT Shipping_Partner
FROM shipping;

-- Display average product price for each category
SELECT Category, AVG(PRICE) As Price_AVG
FROM product
GROUP BY Category;

-- Display tailor name which starts with 'A'
SELECT Tailor_Name
FROM tailor
WHERE TAILOR_NAME LIKE 'A%';

-- Display average price of a product of category 'Outerwear'
SELECT AVG(Price) AS AVERAGE_PRICE 
FROM product 
WHERE Category='Outerwear';

-- Display designer name for the product id 'P0006 ' 
SELECT D.Designer_Name 
FROM Designer D, Product P 
WHERE D.Designer_ID = P.Designer_ID AND P.Product_ID ='P0006';

-- Display Designers with rating higher than the average rating
SELECT Designer_Name, Rating 
FROM Designer 
WHERE Rating > (
    SELECT AVG(Rating) 
    FROM Designer
);

-- Display Tailors who have experience greater than the average experience  
SELECT Tailor_Name, Experience, State 
FROM Tailor t1 
WHERE Experience > (
    SELECT AVG(Experience) 
    FROM Tailor t2 
    WHERE t2.State = t1.State
);

-- Display customers whose state has more than 2 tailors
SELECT First_Name, Last_Name, State 
FROM Customer c 
WHERE (
    SELECT COUNT(*) 
    FROM Tailor t 
    WHERE t.State = c.State
) > 2;

-- Display name of the Designer who have worked on products which are more expensive than average price of product
SELECT Designer_Name 
FROM Designer d
WHERE EXISTS (
    SELECT 1 
    FROM Product p 
    WHERE p.Designer_ID = d.Designer_ID 
    AND p.Price > (SELECT AVG(Price) FROM Product)
);

-- Display Designer who have not designed products less than $50
SELECT Designer_Name
FROM Designer d 
WHERE NOT EXISTS (
    SELECT 1 
    FROM Product p 
    WHERE p.Designer_ID = d.Designer_ID 
    AND p.Price < 50
);