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
SELECT 
    MONTH(cs.datetime) AS month,
    SUM(cs.amount) AS revenue,
    IFNULL(SUM(e.amount), 0) AS expense,
    (SUM(cs.amount) - IFNULL(SUM(e.amount), 0)) AS profit,
    CASE 
        WHEN (SUM(cs.amount) - IFNULL(SUM(e.amount), 0)) > 0 
        THEN 'PROFITABLE'
        ELSE 'NOT_PROFITABLE'
    END AS status
FROM clinic_sales cs
LEFT JOIN expenses e 
    ON cs.cid = e.cid 
    AND MONTH(cs.datetime) = MONTH(e.datetime)
WHERE YEAR(cs.datetime) = 2021
GROUP BY MONTH(cs.datetime);

-- Q4: Most profitable clinic per city (Sept 2021)
SELECT c.city, cs.cid,
       SUM(cs.amount) - IFNULL(SUM(e.amount), 0) AS profit
FROM clinic_sales cs
JOIN clinics c ON cs.cid = c.cid
LEFT JOIN expenses e 
    ON cs.cid = e.cid 
    AND MONTH(cs.datetime) = MONTH(e.datetime)
WHERE MONTH(cs.datetime) = 9 AND YEAR(cs.datetime) = 2021
GROUP BY c.city, cs.cid
HAVING profit = (
    SELECT MAX(profit_val)
    FROM (
        SELECT c2.city, cs2.cid,
               SUM(cs2.amount) - IFNULL(SUM(e2.amount), 0) AS profit_val
        FROM clinic_sales cs2
        JOIN clinics c2 ON cs2.cid = c2.cid
        LEFT JOIN expenses e2 
            ON cs2.cid = e2.cid 
            AND MONTH(cs2.datetime) = MONTH(e2.datetime)
        WHERE MONTH(cs2.datetime) = 9 AND YEAR(cs2.datetime) = 2021
        GROUP BY c2.city, cs2.cid
    ) t
    WHERE t.city = c.city
);

-- Q5: Second least profitable clinic per state (Sept 2021)
SELECT state, cid, profit
FROM (
    SELECT c.state, cs.cid,
           SUM(cs.amount) - IFNULL(SUM(e.amount), 0) AS profit,
           @rank := IF(@prev_state = c.state, @rank + 1, 1) AS rnk,
           @prev_state := c.state
    FROM clinic_sales cs
    JOIN clinics c ON cs.cid = c.cid
    LEFT JOIN expenses e 
        ON cs.cid = e.cid 
        AND MONTH(cs.datetime) = MONTH(e.datetime),
        (SELECT @rank := 0, @prev_state := '') vars
    WHERE MONTH(cs.datetime) = 9 AND YEAR(cs.datetime) = 2021
    GROUP BY c.state, cs.cid
    ORDER BY c.state, profit ASC
) ranked
WHERE rnk = 2;