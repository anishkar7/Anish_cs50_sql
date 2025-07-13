SELECT "name" FROM "schools" WHERE "district_id" In (
      SELECT "id" FROM "districts" WHERE name="Cambridge"
);
