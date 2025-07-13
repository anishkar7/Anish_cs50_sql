CREATE TABLE "donuts"(
      "id" INTEGER,
      "name" TEXT NOT NULL,
      "is_gluten_free" BOOLEAN NOT NULL,
      "price" FLOAT NOT NULL,
      PRIMARY KEY("id")
);

CREATE TABLE "ingredients"(
      "id" INTEGER,
      "name" TEXT NOT NULL,
      "price_per_unit" FLOAT NOT NULL,
      "unit" INTEGER NOT NULL,
      PRIMARY KEY("id")
);

CREATE TABLE "donut_ingredients"(
      "donut_id" INTEGER,
      "ingredient_id" INTEGER,
      PRIMARY KEY("donut_id","ingredient_id")
      FOREIGN KEY("donut_id") REFERENCES "donuts"("id"),
      FOREIGN KEY("ingredient_id") REFERENCES "ingredients"("id")
);

CREATE TABLE "customers"(
      "id" INTEGER,
      "first_name" TEXT NOT NULL,
      "last_name" TEXT,
      PRIMARY KEY("id")
);

CREATE TABLE "orders"(
      "id" INTEGER,
      "customer_id" INTEGER,
      PRIMARY KEY("id"),
      FOREIGN KEY("customer_id") REFERENCES "customers"("id")
);

CREATE TABLE "orderDonuts"(
      "donut_id" INTEGER,
      "order_id" INTEGER,
      "quantity" INTEGER,
      PRIMARY KEY("donut_id","order_id")
      FOREIGN KEY("donut_id") REFERENCES "donuts"("id"),
      FOREIGN KEY("order_id") REFERENCES "orders"("id")
);
