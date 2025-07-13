CREATE TABLE "Users"(
      "id" INTEGER,
      "first_name" TEXT NOT NULL,
      "last_name" TEXT NOT NULL,
      "username" TEXT NOT NULL,
      "password" TEXT,
      PRIMARY KEY("id")
);

CREATE TABLE "Schools"(
      "id" INTEGER,
      "name" TEXT NOT NULL,
      "type" TEXT NOT NULL,
      "location" TEXT NOT NULL,
      "year_founded" INTEGER NOT NULL,
      PRIMARY KEY("id")
);

CREATE TABLE "Companies"(
      "id" INTEGER,
      "name" TEXT NOT NULL,
      "industry" TEXT NOT NULL,
      "location" TEXT NOT NULL,
      PRIMARY KEY("id")
);

CREATE TABLE "UserConnections"(
      "user_id1" INTEGER,
      "user_id2" INTEGER,
      PRIMARY KEY("user_id1","user_id2"),
      FOREIGN KEY("user_id1") REFERENCES "Users"("id"),
      FOREIGN KEY("user_id2") REFERENCES "Users"("id")
);

CREATE TABLE "UserSchools"(
      "user_id" INTEGER,
      "school_id" INTEGER,
      "start_date" DATE NOT NULL,
      "end_date" DATE,
      "degree" TEXT,
      PRIMARY KEY("user_id","school_id"),
      FOREIGN KEY("user_id") REFERENCES "Users"("id"),
      FOREIGN KEY("school_id") REFERENCES "Schools"("id")
);

CREATE TABLE "UserCompanies"(
      "user_id" INTEGER,
      "company_id" INTEGER,
      "start_date" DATE NOT NULL,
      "end_date" DATE,
      "title" TEXT,
      PRIMARY KEY("user_id","company_id"),
      FOREIGN KEY("user_id") REFERENCES "Users"("id"),
      FOREIGN KEY("company_id") REFERENCES "Companies"("id")
);
