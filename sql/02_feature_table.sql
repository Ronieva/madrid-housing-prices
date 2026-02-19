-- 02_feature_table: creates a clean feature table ready for training/prediction
-- Adds: price_per_m2, cleans strings, fixes house_type_2 nulls, removes obvious invalid rows

CREATE OR REPLACE TABLE `project-id.housing_project.feature_housing_madrid` AS
SELECT
  -- Target (keep it here for training/evaluation; you can exclude later for inference files)
  price,

  -- Numeric features
  rooms,
  m2,
  SAFE_DIVIDE(price, NULLIF(m2, 0)) AS price_per_m2,

  -- Boolean features
  elevator,
  garage,

  -- Categorical (cleaned)
  LOWER(TRIM(district)) AS district,
  LOWER(TRIM(neighborhood)) AS neighborhood,
  LOWER(TRIM(house_type)) AS house_type,
  COALESCE(NULLIF(LOWER(TRIM(house_type_2)), ''), 'unknown') AS house_type_2

FROM `project-id.housing_project.ml_housing_madrid`
WHERE
  price IS NOT NULL
  AND m2 IS NOT NULL AND m2 > 0
  AND rooms IS NOT NULL AND rooms > 0
  AND district IS NOT NULL AND TRIM(district) <> ''
  AND neighborhood IS NOT NULL AND TRIM(neighborhood) <> '';
