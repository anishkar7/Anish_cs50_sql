CREATE TABLE "passengers"(
      "id" INTEGER,
      "first_name" TEXT NOT NULL,
      "last_name" TEXT NOT NULL,
      "age" INTEGER NOT NULL,
      PRIMARY KEY("id")
);

CREATE TABLE "airlines"(
      "id" INTEGER,
      "name" TEXT NOT NULL,
      "concourse" TEXT,
      PRIMARY KEY("id")
);

CREATE TABLE "flights"(
      "id" INTEGER,
      "flight_no" INTEGER,
      "airline_id" INTEGER,
      "departing_airport_code" TEXT NOT NULL,
      "arrival_airport_code" TEXT NOT NULL,
      "departing_datetime" DATETIME,
      "arrival_datetime" DATETIME,
      PRIMARY KEY("id"),
      FOREIGN KEY("airline_id") REFERENCES "airlines"("id")
);

CREATE TABLE "checkIns"(
      "id" INTEGER,
      "datetime" DATETIME NOT NULL,
      "passenger_id" INTEGER,
      "flight_id" INTEGER,
      PRIMARY KEY("id"),
      FOREIGN KEY("passenger_id") REFERENCES "passengers"("id"),
      FOREIGN KEY("flight_id") REFERENCES "flights"("id")
);
