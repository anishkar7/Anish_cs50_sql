SELECT "districts"."name", "expenditures"."per_pupil_expenditure", "staff_evaluations"."exemplary"
FROM "districts" JOIN "expenditures" ON "districts"."id"="expenditures"."district_id"
JOIN "staff_evaluations" ON "staff_evaluations"."district_id"="districts"."id"
WHERE "districts"."type" LIKE 'Public School%' AND "per_pupil_expenditure" >=(
      SELECT ROUND(AVG("per_pupil_expenditure"),2) FROM "expenditures"
) AND "exemplary" >= (
      SELECT ROUND(AVG("exemplary"),2) FROM "staff_evaluations"
) ORDER BY "exemplary" DESC, "per_pupil_expenditure" DESC;
