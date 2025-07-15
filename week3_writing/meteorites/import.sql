CREATE TABLE "met_temp"(
      "name" TEXT,
      "id" INTEGER,
      "nametype" TEXT,
      "class" TEXT,
      "mass" REAL,
      "discovery" TEXT,
      "year" INTEGER,
      "lat" REAL,
      "long" REAL,
      PRIMARY KEY("id")
);

.import --csv --skip 1 meteorites.csv "met_temp"

UPDATE "met_temp"
SET "mass" = NULL
WHERE "mass" = '0.0';
UPDATE "met_temp"
SET "year" = NULL
WHERE "year" = '';
UPDATE "met_temp"
SET "lat" = NULL
WHERE "lat" = '0.0';
UPDATE "met_temp"
SET "long" = NULL
WHERE "long" = '0.0';

DELETE FROM "met_temp"
WHERE "nametype" = 'Relict';

UPDATE "met_temp"
SET "mass" = ROUND("mass", 2)
WHERE "mass" IS NOT NULL;
UPDATE "met_temp"
SET "lat" = ROUND("lat", 2)
WHERE "lat" IS NOT NULL;
UPDATE "met_temp"
SET "long" = ROUND("long", 2)
WHERE "long" IS NOT NULL;

CREATE TABLE "meteorites"(
      "name" TEXT,
      "id" INTEGER,
      "class" TEXT,
      "mass" REAL,
      "discovery" TEXT,
      "year" INTEGER,
      "lat" REAL,
      "long" REAL,
      PRIMARY KEY("id")
);

INSERT INTO "meteorites"("name","id","class","mass","discovery","year","lat","long")
SELECT "name","id","class","mass","discovery","year","lat","long" FROM "met_temp"
ORDER BY "year", "name";
