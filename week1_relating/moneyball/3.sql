SELECT "HR", "year" FROM "players" JOIN "performances" ON "players"."id"="performances"."player_id" WHERE
"first_name"='Ken' AND "last_name"='Griffey' AND "birth_year"=1969 ORDER By "year" DESC;
