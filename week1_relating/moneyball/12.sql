SELECT "first_name", "last_name" FROM (
SELECT "first_name","last_name","id" FROM(SELECT "players"."first_name", "players"."last_name", "players"."id" AS "id"
FROM "players" JOIN "performances" ON "players"."id"="performances"."player_id"
JOIN "salaries" ON "performances"."player_id"="salaries"."player_id" AND "performances"."year"="salaries"."year"
WHERE "performances"."H">0 AND "performances"."year"=2001 ORDER BY "salary"/"H"
LIMIT 10)
INTERSECT
SELECT "first_name", "last_name", "id" FROM(SELECT "first_name", "last_name", "players"."id" AS "id"
FROM "players" JOIN "performances" ON "players"."id"="performances"."player_id"
JOIN "salaries" ON "performances"."player_id"="salaries"."player_id" AND "performances"."year"="salaries"."year"
WHERE "performances"."RBI">0 AND "performances"."year"=2001 ORDER BY "salary"/"RBI"
LIMIT 10))
ORDER BY "id";
