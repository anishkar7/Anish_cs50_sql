SELECT "city", COUNT(*) AS "no_of_public_schools" FROM "schools" GROUP BY "city" HAVING "no_of_public_schools" <= 3 ORDER BY "no_of_public_schools" DESC, "city";
