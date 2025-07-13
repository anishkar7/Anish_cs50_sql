--Which public school has the highest graduation rate, and what district does it belong to?
SELECT "schools"."name", "districts"."name", "graduated"
FROM "schools"
JOIN "graduation_rates" ON "schools"."id" = "graduation_rates"."school_id"
JOIN "districts" ON "schools"."district_id" = "districts"."id"
WHERE "schools"."type" LIKE 'Public School%'
  AND "graduation_rates"."graduated" = (
    SELECT MAX("graduation_rates"."graduated")
    FROM "schools"
    JOIN "graduation_rates" ON "schools"."id" = "graduation_rates"."school_id"
    WHERE "schools"."type" LIKE 'Public School%'
);

