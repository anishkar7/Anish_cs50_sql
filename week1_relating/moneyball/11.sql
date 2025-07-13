SELECT "players"."first_name", "players"."last_name", ("salaries"."salary"/"performances"."H") AS "dollars_per_hit"
FROM "players" JOIN "performances" ON "players"."id"="performances"."player_id"
JOIN "salaries" ON "performances"."player_id"="salaries"."player_id" AND "performances"."year"="salaries"."year"
WHERE "performances"."H" >0 AND "performances"."year"=2001 ORDER BY "dollars_per_hit", "first_name", "last_name" LIMIT 10;

