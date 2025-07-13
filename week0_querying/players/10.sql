SELECT
    "first_name" AS "First Name",
    "last_name" AS "Last Name",
    "height" AS "Height in Inches"
FROM "players"
WHERE "bats" = 'L' AND "height" > 75
ORDER BY "height" DESC;
