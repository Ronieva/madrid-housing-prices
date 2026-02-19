-- 03_market_summary_outliers: market summary by district using percentiles
-- plus a quick outlier sample (top expensive per m2)

WITH base AS (
  SELECT
    LOWER(TRIM(district)) AS district,
    price,
    m2,
    SAFE_DIVIDE(price, NULLIF(m2, 0)) AS price_per_m2
  FROM `project-id.housing_project.feature_housing_madrid`
),
district_stats AS (
  SELECT
    district,
    COUNT(*) AS n_listings,
    AVG(price) AS avg_price,
    AVG(price_per_m2) AS avg_price_per_m2,
    APPROX_QUANTILES(price_per_m2, 100)[OFFSET(50)] AS median_price_per_m2,
    APPROX_QUANTILES(price_per_m2, 100)[OFFSET(75)] AS p75_price_per_m2,
    APPROX_QUANTILES(price_per_m2, 100)[OFFSET(90)] AS p90_price_per_m2
  FROM base
  WHERE price_per_m2 IS NOT NULL
  GROUP BY district
),
outliers AS (
  SELECT
    district,
    price,
    m2,
    price_per_m2
  FROM base
  WHERE price_per_m2 IS NOT NULL
  QUALIFY ROW_NUMBER() OVER (PARTITION BY district ORDER BY price_per_m2 DESC) <= 3
)
SELECT
  s.*,
  -- pack a small outlier example per district (top 3)
  ARRAY_AGG(STRUCT(o.price, o.m2, o.price_per_m2) ORDER BY o.price_per_m2 DESC) AS top_outliers_per_m2
FROM district_stats s
LEFT JOIN outliers o USING (district)
GROUP BY
  district, n_listings, avg_price, avg_price_per_m2, median_price_per_m2, p75_price_per_m2, p90_price_per_m2
ORDER BY median_price_per_m2 DESC;
