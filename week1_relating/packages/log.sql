
-- *** The Lost Letter ***
SELECT * FROM "scans" WHERE "package_id"=(
    SELECT "id" FROM "packages" WHERE "from_address_id"=(
        SELECT "id" FROM "addresses" WHERE "address"='900 Somerville Avenue'
    ) AND "to_address_id"=(
        SELECT "id" FROM "addresses" WHERE "address"='2 Finnigan Street'
    )
) ORDER BY "timestamp" DESC;
-- *** The Devious Delivery ***
SELECT * FROM "addresses" WHERE "id"=(
    SELECT "address_id" FROM "scans" WHERE "package_id"=(
        SELECT "id" FROM "packages" WHERE "from_address_id" IS NULL
    ) AND "action"='Drop'
);
-- *** The Forgotten Gift ***
SELECT "contents" FROM "packages" WHERE "from_address_id"=(
            SELECT "id" FROM "addresses" WHERE "address"='109 Tileston Street'
        );
SELECT "name" FROM "drivers" WHERE "id"=(
    SELECT "driver_id" FROM "scans" WHERE "package_id"=(
        SELECT "id" FROM "packages" WHERE "from_address_id"=(
            SELECT "id" FROM "addresses" WHERE "address"='109 Tileston Street'
        )
    ) ORDER By "timestamp" DESC LIMIT 1
);
