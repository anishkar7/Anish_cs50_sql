SELECT "first_name", "last_name", "salary" FROM "salaries" JOIN "players" ON "salaries"."player_id"="players"."id"
 WHERE "year"=2001 ORDER By "salary", "first_name", "last_name", "player_id" LIMIT 50;
