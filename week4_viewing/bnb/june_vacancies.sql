CREATE VIEW "june_vacancies" AS
SELECT
  L."id",
  L."property_type",
  L."host_name",
  SUM(CASE WHEN A."available" = TRUE THEN 1 ELSE 0 END) AS "days_vacant"
FROM "listings" AS L
JOIN "availabilities" AS A
  ON L."id" = A."listing_id"
WHERE A."date" LIKE '2023-06-%'
GROUP BY
  L."id",
  L."property_type",
  L."host_name";
