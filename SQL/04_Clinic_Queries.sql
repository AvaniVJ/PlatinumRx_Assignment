-- Q1: Revenue per sales channel
SELECT sales_channel,
       SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel;

-- Q2: Top 10 customers
SELECT uid,
       SUM(amount) AS total_spent
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;

-- Q3: Monthly revenue, expense, profit
WITH revenue AS (
    SELECT MONTH(datetime) AS month, SUM(amount) AS revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
),
expense AS (
    SELECT MONTH(datetime) AS month, SUM(amount) AS expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
)
SELECT r.month,
       r.revenue,
       IFNULL(e.expense,0) AS expense,
       (r.revenue - IFNULL(e.expense,0)) AS profit,
       CASE 
           WHEN (r.revenue - IFNULL(e.expense,0)) > 0 THEN 'PROFITABLE'
           ELSE 'NOT_PROFITABLE'
       END AS status
FROM revenue r
LEFT JOIN expense e ON r.month = e.month;

-- Q4: Most profitable clinic per city (Sept 2021)
WITH profits AS (
    SELECT 
        c.city,
        cs.cid,
        SUM(cs.amount) - IFNULL(SUM(e.amount), 0) AS profit
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e 
        ON cs.cid = e.cid 
        AND MONTH(cs.datetime) = MONTH(e.datetime)
    WHERE MONTH(cs.datetime) = 9 AND YEAR(cs.datetime) = 2021
    GROUP BY c.city, cs.cid
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS rnk
    FROM profits
)
SELECT city, cid, profit
FROM ranked
WHERE rnk = 1;

-- Q5: Second least profitable clinic per state (Sept 2021)
WITH profits AS (
    SELECT 
        c.state,
        cs.cid,
        SUM(cs.amount) - IFNULL(SUM(e.amount), 0) AS profit
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e 
        ON cs.cid = e.cid 
        AND MONTH(cs.datetime) = MONTH(e.datetime)
    WHERE MONTH(cs.datetime) = 9 AND YEAR(cs.datetime) = 2021
    GROUP BY c.state, cs.cid
),
ranked AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk
    FROM profits
)
SELECT state, cid, profit
FROM ranked
WHERE rnk = 2;
