SELECT COUNT(*) AS "cross_dominant_count"
FROM "players"
WHERE ("bats" = 'R' AND "throws" = 'L') OR ("bats" = 'L' AND "throws" = 'R');
