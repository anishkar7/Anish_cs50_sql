SELECT "city", COUNT(*) AS "no_of_public_schools" FROM "schools" GROUP BY "city" ORDER BY "no_of_public_schools" DESC, "city" LIMIT 10;
