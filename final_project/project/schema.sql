-- SQLite Schema for the Premier League Database
-- -----------------------------------------------------
-- Table `Seasons`
-- Stores information about some Premier League seasons.
-- -----------------------------------------------------
CREATE TABLE "Seasons" (
  "season_id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "season_name" TEXT NOT NULL UNIQUE
);

-- -----------------------------------------------------
-- Table `Stadiums`
-- Stores information about the stadiums.
-- -----------------------------------------------------
CREATE TABLE "Stadiums" (
  "stadium_id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL UNIQUE,
  "city" TEXT NOT NULL,
  "capacity" INTEGER
);

-- -----------------------------------------------------
-- Table `Teams`
-- Stores information about each team.
-- -----------------------------------------------------
CREATE TABLE "Teams" (
  "team_id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL UNIQUE,
  "stadium_id" INTEGER,
  "founded_year" INTEGER,
  FOREIGN KEY ("stadium_id") REFERENCES "Stadiums" ("stadium_id")
);

-- -----------------------------------------------------
-- Table `Players`
-- Stores information about each player.
-- -----------------------------------------------------
CREATE TABLE "Players" (
  "player_id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "first_name" TEXT NOT NULL,
  "last_name" TEXT NOT NULL,
  "date_of_birth" DATE,
  "nationality" TEXT,
  "position" TEXT,
  "team_id" INTEGER NOT NULL,
  FOREIGN KEY ("team_id") REFERENCES "Teams" ("team_id")
);

-- -----------------------------------------------------
-- Table `Matches`
-- Stores information about each match played.
-- -----------------------------------------------------
CREATE TABLE "Matches" (
  "match_id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "season_id" INTEGER NOT NULL,
  "home_team_id" INTEGER NOT NULL,
  "away_team_id" INTEGER NOT NULL,
  "match_date" DATE NOT NULL,
  "stadium_id" INTEGER NOT NULL,
  "home_goals" INTEGER DEFAULT 0,
  "away_goals" INTEGER DEFAULT 0,
  FOREIGN KEY ("season_id") REFERENCES "Seasons" ("season_id"),
  FOREIGN KEY ("home_team_id") REFERENCES "Teams" ("team_id"),
  FOREIGN KEY ("away_team_id") REFERENCES "Teams" ("team_id"),
  FOREIGN KEY ("stadium_id") REFERENCES "Stadiums" ("stadium_id")
);

-- -----------------------------------------------------
-- Table `Match_Events`
-- Logs significant events during a match.
-- -----------------------------------------------------
CREATE TABLE "Match_Events" (
  "event_id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "match_id" INTEGER NOT NULL,
  "player_id" INTEGER,
  "team_id" INTEGER NOT NULL,
  "event_type" TEXT NOT NULL, -- e.g., 'Goal', 'Yellow', 'Red', 'Injury'
  "minute" INTEGER NOT NULL,
  FOREIGN KEY ("match_id") REFERENCES "Matches" ("match_id"),
  FOREIGN KEY ("player_id") REFERENCES "Players" ("player_id"),
  FOREIGN KEY ("team_id") REFERENCES "Teams" ("team_id")
);

-- SQLite Views and Indexes for the Premier League Database

-- =================================================================
-- INDEXES
-- =================================================================

-- Index on Players table for faster lookups by team
CREATE INDEX "idx_players_team_id" ON "Players" ("team_id");

-- Indexes on Matches table for faster filtering by teams, season, and date
CREATE INDEX "idx_matches_season_id" ON "Matches" ("season_id");
CREATE INDEX "idx_matches_home_team_id" ON "Matches" ("home_team_id");
CREATE INDEX "idx_matches_away_team_id" ON "Matches" ("away_team_id");
CREATE INDEX "idx_matches_match_date" ON "Matches" ("match_date");

-- Indexes on Match_Events for faster lookups by match, player, and event type
CREATE INDEX "idx_match_events_match_id" ON "Match_Events" ("match_id");
CREATE INDEX "idx_match_events_player_id" ON "Match_Events" ("player_id");
CREATE INDEX "idx_match_events_event_type" ON "Match_Events" ("event_type");

-- Index on Teams table for faster lookups by stadium
CREATE INDEX "idx_teams_stadium_id" ON "Teams" ("stadium_id");


-- =================================================================
-- VIEWS
-- =================================================================

-- View `V_MatchResults`
-- Provides a clean, readable summary of all match results.
-- -----------------------------------------------------------------
CREATE VIEW "V_MatchResults" AS
SELECT
    "m"."match_date" AS "Date",
    "s"."season_name" AS "Season",
    "ht"."name" AS "Home_Team",
    "m"."home_goals" AS "Home_Goals",
    "at"."name" AS "Away_Team",
    "m"."away_goals" AS "Away_Goals",
    "st"."name" AS "Stadium"
FROM "Matches" AS "m"
JOIN "Teams" AS "ht" ON "m"."home_team_id" = "ht"."team_id"
JOIN "Teams" AS "at" ON "m"."away_team_id" = "at"."team_id"
JOIN "Stadiums" AS "st" ON "m"."stadium_id" = "st"."stadium_id"
JOIN "Seasons" AS "s" ON "m"."season_id" = "s"."season_id";

-- -----------------------------------------------------------------
-- View `V_TopScorers`
-- Calculates the total number of goals for each player.
-- Example query: SELECT * FROM "V_TopScorers" ORDER BY "Goals" DESC LIMIT 10;
-- -----------------------------------------------------------------
CREATE VIEW "V_TopScorers" AS
SELECT
    "p"."first_name" || ' ' || "p"."last_name" AS "Player",
    "t"."name" AS "Team",
    COUNT("me"."event_id") AS "Goals"
FROM "Match_Events" AS "me"
JOIN "Players" AS "p" ON "me"."player_id" = "p"."player_id"
JOIN "Teams" AS "t" ON "me"."team_id" = "t"."team_id"
WHERE "me"."event_type" = 'Goal'
GROUP BY "Player", "Team";

-- -----------------------------------------------------------------
-- View `V_StadiumDetails`
-- Provides a list of stadiums along with their home teams.
-- -----------------------------------------------------------------
CREATE VIEW "V_StadiumDetails" AS
SELECT
    "st"."name" AS "Stadium",
    "st"."city" AS "City",
    "st"."capacity" AS "Capacity",
    "t"."name" AS "Home_Team"
FROM "Stadiums" AS "st"
LEFT JOIN "Teams" AS "t" ON "st"."stadium_id" = "t"."stadium_id";

-- +++++
-- END +
-- +++++
