use telegramAnalysis;

WITH weeks_with_month AS (
    SELECT 
        `Week Start`, 
        `Earnings (?)`,
        YEAR(`Week Start`) AS year,
        MONTH(`Week Start`) AS month
    FROM WeeklyData
),

first_week_per_month AS (
    SELECT 
        year,
        month,
        MIN(`Week Start`) AS first_week_start
    FROM weeks_with_month
    GROUP BY year, month
),

first_week_earnings AS (
    SELECT 
        w.year,
        w.month,
        w.`Earnings (?)` AS first_week_earning
    FROM weeks_with_month as w
    JOIN first_week_per_month as f 
        ON w.`Week Start` = f.first_week_start
),

other_weeks_earnings AS (
    SELECT 
        w.year,
        w.month,
        w.`Earnings (?)` AS other_week_earning
    FROM weeks_with_month w
    JOIN first_week_per_month f 
        ON w.year = f.year AND w.month = f.month
    WHERE w.`Week Start` != f.first_week_start
),

comparison AS (
    SELECT 
        f.year,
        f.month,
        f.first_week_earning,
        MAX(o.other_week_earning) AS rest_max
    FROM first_week_earnings f
    LEFT JOIN other_weeks_earnings o 
        ON f.year = o.year AND f.month = o.month
    GROUP BY f.year, f.month, f.first_week_earning
)

-- ✅ Final Output
SELECT 
    year,
    month,
    first_week_earning,
    rest_max,
    CASE 
        WHEN first_week_earning > rest_max THEN '✅ Yes'
        ELSE 'No'
    END AS first_week_is_higher
FROM comparison
ORDER BY year, month;
