-- 01_data_profiling linker: checks row count + null rates + distinct counts
WITH base AS (
  SELECT * 
  FROM `project-id.housing_project.ml_housing_madrid`
)
SELECT
  COUNT(*) AS total_rows,

  -- Null rates
  SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS null_price,
  SUM(CASE WHEN rooms IS NULL THEN 1 ELSE 0 END) AS null_rooms,
  SUM(CASE WHEN m2 IS NULL THEN 1 ELSE 0 END) AS null_m2,
  SUM(CASE WHEN elevator IS NULL THEN 1 ELSE 0 END) AS null_elevator,
  SUM(CASE WHEN garage IS NULL THEN 1 ELSE 0 END) AS null_garage,
  SUM(CASE WHEN district IS NULL OR TRIM(district) = '' THEN 1 ELSE 0 END) AS null_or_blank_district,
  SUM(CASE WHEN neighborhood IS NULL OR TRIM(neighborhood) = '' THEN 1 ELSE 0 END) AS null_or_blank_neighborhood,
  SUM(CASE WHEN house_type IS NULL OR TRIM(house_type) = '' THEN 1 ELSE 0 END) AS null_or_blank_house_type,
  SUM(CASE WHEN house_type_2 IS NULL OR TRIM(house_type_2) = '' THEN 1 ELSE 0 END) AS null_or_blank_house_type_2,

  -- Distincts (cardinality)
  COUNT(DISTINCT district) AS distinct_districts,
  COUNT(DISTINCT neighborhood) AS distinct_neighborhoods,
  COUNT(DISTINCT house_type) AS distinct_house_types,
  COUNT(DISTINCT house_type_2) AS distinct_house_type_2
FROM base;
