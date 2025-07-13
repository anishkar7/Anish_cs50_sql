SELECT "players"."first_name", "players"."last_name", "salaries"."salary", "performances"."HR" FROM "players" JOIN "performances"
ON "players"."id"="performances"."player_id" JOIN "salaries" ON "performances"."player_id"="salaries"."player_id" AND
"performances"."year"="salaries"."year" ORDER BY "salaries"."player_id", "salaries"."year" DESC, "performances"."HR" DESC, "salaries"."salary" DESC;

