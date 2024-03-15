-- Динамика выручки по месяцам
SELECT
    toStartOfMonth(InvoiceDate) AS months,
    SUM(Quantity*UnitPrice) AS Revenue
FROM default.retail
WHERE Quantity>0
GROUP BY toStartOfMonth(InvoiceDate)
ORDER BY months ASC



-- Общая выручка по странам за весь период
SELECT
    Country,
    case when Country = 'USA' then 'United States' else Country end Country_,
    SUM(Quantity*UnitPrice) AS Revenue
FROM default.retail
WHERE Quantity>0
GROUP BY Country
ORDER BY Revenue DESC



-- Средняя сумма заказа по странам
SELECT
    Country,
    AVG(TotalPrice) AS avg_price
FROM
    (SELECT
        Country,
        InvoiceNo,
        SUM((UnitPrice*Quantity)) AS TotalPrice
    FROM default.retail
    WHERE Quantity>0
    GROUP BY Country, InvoiceNo)
GROUP BY Country
ORDER BY avg_price DESC



Уникальные клиенты по странам
SELECT
    Country,
    COUNT (DISTINCT CustomerID) AS count_users
FROM default.retail
GROUP BY Country
ORDER BY count_users DESC



Уникальные клиенты по месяцам
SELECT
    COUNT (DISTINCT CustomerID) AS count_users,
    toStartOfMonth(InvoiceDate) AS months
FROM default.retail
WHERE Quantity > 0
GROUP BY months
ORDER BY months ASC



-- Динамика среднего чека по месяцам default.retail - avg check
SELECT
    toStartOfMonth(InvoiceDate) AS months,
    AVG(TotalPrice) AS avg_price
FROM
    (SELECT
        InvoiceNo,
        InvoiceDate,
        SUM(UnitPrice*Quantity) AS TotalPrice
    FROM default.retail
    WHERE Quantity > 0
    GROUP BY InvoiceNo, InvoiceDate) AS subquery
GROUP BY months
ORDER BY avg_price DESC



-- ТОП-10 товаров в продажах в штуках
SELECT
    StockCode,
    Description,
    SUM(Quantity) AS Sum_Quantity
FROM default.retail
WHERE Quantity>0
GROUP BY StockCode, Description
ORDER BY Sum_Quantity DESC
LIMIT 10



-- ТОП-10 товаров в продажах по выручке
SELECT
    Description,
    SUM(Quantity * UnitPrice) total_sum
FROM default.retail
WHERE Quantity>0
GROUP BY Description 
ORDER BY total_sum DESC
LIMIT 10