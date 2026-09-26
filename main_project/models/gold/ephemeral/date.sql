{{
  config(
    materialized = 'table',
    )
}}

WITH dates AS (

    SELECT
        EXPLODE(
            SEQUENCE(
                DATE('2020-01-01'),
                DATE('2030-12-31'),
                INTERVAL 1 DAY
            )
        ) AS full_date

)

SELECT
    CAST(DATE_FORMAT(full_date, 'yyyyMMdd') AS INT) AS date_id,
    full_date,
    DAY(full_date) AS day,
    DAYOFWEEK(full_date) AS day_of_week,
    DATE_FORMAT(full_date, 'EEEE') AS day_name,
    WEEKOFYEAR(full_date) AS week,
    MONTH(full_date) AS month,
    DATE_FORMAT(full_date, 'MMMM') AS month_name,
    QUARTER(full_date) AS quarter,
    YEAR(full_date) AS year

FROM dates