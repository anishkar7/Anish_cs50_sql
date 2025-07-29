-- ===================================================================================
-- I. INSERT Statements (Adding new data)
-- ===================================================================================

-- Query 1: Adding myself to a team
INSERT INTO "Players" ("first_name", "last_name", "date_of_birth", "nationality", "position", "team_id")
VALUES ('Anish', 'Kar', '2004-06-21', 'Indian', 'Midfielder', (SELECT "team_id" FROM "Teams" WHERE "name" = 'Liverpool'));


-- Query 2: Adding the next season
INSERT INTO "Seasons" ("season_name")
VALUES ('2025/2026');


-- Query 3: scheduling a future match
INSERT INTO "Matches" ("season_id", "home_team_id", "away_team_id", "match_date", "stadium_id")
VALUES (
  (SELECT "season_id" FROM "Seasons" WHERE "season_name" = '2025/2026'),
  (SELECT "team_id" FROM "Teams" WHERE "name" = 'Manchester United'),
  (SELECT "team_id" FROM "Teams" WHERE "name" = 'Liverpool'),
  '2025-09-20',
  (SELECT "stadium_id" FROM "Stadiums" WHERE "name" = 'Old Trafford')
);

-- ===================================================================================
-- II. UPDATE Statements (Modifying existing data)
-- ===================================================================================

-- Query 4: Updating result of a match
UPDATE "Matches"
SET "home_goals" = 2, "away_goals" = 1
WHERE "match_id" = 50;


-- Query 5: Transferring a player from one team to another.
UPDATE "Players"
SET "team_id" = (SELECT "team_id" FROM "Teams" WHERE "name" = 'Liverpool')
WHERE "first_name" = 'Alexander' AND "last_name" = 'Isak';


-- ===================================================================================
-- III. DELETE Statements (Removing data)
-- ===================================================================================

-- Query 6: Deleting a match event
DELETE FROM "Match_Events"
WHERE "match_id" = 72 AND "event_type" = 'Goal' AND "minute" = 88;


-- ===================================================================================
-- IV. SELECT Queries
-- ===================================================================================

-- Query 7: Top 10 goal scorers from the dataset.
-- uses the V_TopScorers view for simplicity.
SELECT * FROM "V_TopScorers"
ORDER BY "Goals" DESC
LIMIT 10;

-- Query 8: All matches that ended in a draw but where goals were scored/not a goalless draw.
SELECT "Date", "Home_Team", "Away_Team", "Home_Goals", "Away_Goals"
FROM "V_MatchResults"
WHERE "Home_Goals" = "Away_Goals" AND "Home_Goals" > 0
ORDER BY "Date" DESC;


-- Query 9: All Brazilian players and the teams they play for.
SELECT "p"."first_name" || ' ' || "p"."last_name" AS "Player_Name", "t"."name" AS "Team"
FROM "Players" "p"
JOIN "Teams" "t" ON "p"."team_id" = "t"."team_id"
WHERE "p"."nationality" = 'Brazilian';

-- Query 10: stadium with the highest capacity.
SELECT "name" AS "MostCapacityStadium", "capacity"
FROM "Stadiums"
ORDER BY "capacity" DESC
LIMIT 1;

-- Query 11: stadium with the lowest capacity.
SELECT "name" AS "LeastCapacityStadium", "capacity"
FROM "Stadiums"
ORDER BY "capacity"
LIMIT 1;

-- Query 12: number of matches played in each stadium.
SELECT "st"."name" AS "Stadium", COUNT("m"."match_id") AS "Matches_Played"
FROM "Matches" "m"
JOIN "Stadiums" "st" ON "m"."stadium_id" = "st"."stadium_id"
GROUP BY "Stadium"
ORDER BY "Matches_Played" DESC;

-- Query 13: All goals scored by a specific player (e.g. Salah).
SELECT "m"."match_date" AS "Date", "ht"."name" AS "Home_Team", "at"."name" AS "Away_Team", "me"."minute" AS "Minute_of_Goal"
FROM "Match_Events" "me"
JOIN "Matches" "m" ON "me"."match_id" = "m"."match_id"
JOIN "Players" "p" ON "me"."player_id" = "p"."player_id"
JOIN "Teams" "ht" ON "m"."home_team_id" = "ht"."team_id"
JOIN "Teams" "at" ON "m"."away_team_id" = "at"."team_id"
WHERE "p"."last_name" = 'Salah' AND "me"."event_type" = 'Goal'
ORDER BY "Date";


-- Query 14: Matches where a red card was given, and to which player (Corrected).
SELECT
  "m"."match_date" AS "Date",
  "ht"."name" AS "Home_Team",
  "at"."name" AS "Away_Team",
  "p"."first_name" || ' ' || "p"."last_name" AS "Player_Sent_Off",
  "t"."name" AS "Team"
FROM "Match_Events" AS "me"
JOIN "Matches" AS "m" ON "me"."match_id" = "m"."match_id"
JOIN "Players" AS "p" ON "me"."player_id" = "p"."player_id"
JOIN "Teams" AS "t" ON "me"."team_id" = "t"."team_id"
JOIN "Teams" AS "ht" ON "m"."home_team_id" = "ht"."team_id"
JOIN "Teams" AS "at" ON "m"."away_team_id" = "at"."team_id"
WHERE "me"."event_type" = 'Red'
ORDER BY "m"."match_date";

-- Query 15: Find the oldest and youngest players in the database.
SELECT 'Oldest' AS "Category", "first_name", "last_name", "date_of_birth" FROM "Players" ORDER BY "date_of_birth" LIMIT 1;
SELECT 'Youngest' AS "Category", "first_name", "last_name", "date_of_birth" FROM "Players" ORDER BY "date_of_birth" DESC LIMIT 1;
