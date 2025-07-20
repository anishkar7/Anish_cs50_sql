-- Create the cipher_triplets table
CREATE TABLE "cipher_triplets" (
    "sentence_num" INTEGER,
    "char_start" INTEGER,
    "msg_length" INTEGER
);

-- Insert the cipher data into the cipher_triplets table
INSERT INTO "cipher_triplets" ("sentence_num", "char_start", "msg_length") VALUES
(14, 98, 4),
(114, 3, 5),
(618, 72, 9),
(630, 7, 3),
(932, 12, 5),
(2230, 50, 7),
(2346, 44, 10),
(3041, 14, 5);

-- Create the message view
CREATE VIEW "message" AS
SELECT
  SUBSTR("sentences"."sentence", "cipher_triplets"."char_start", "cipher_triplets"."msg_length") AS "phrase"
FROM "cipher_triplets"
JOIN "sentences" ON "cipher_triplets"."sentence_num" = "sentences"."id"
ORDER BY "cipher_triplets"."ROWID";
