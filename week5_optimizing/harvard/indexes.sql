CREATE INDEX "student_enrollments_idx" ON "enrollments" ("student_id");

CREATE INDEX "course_enrollments_idx" ON "enrollments" ("course_id");

CREATE INDEX "course_department_semester_idx" ON "courses" ("department", "semester");

CREATE INDEX "course_title_semester_idx" ON "courses" ("title", "semester");

CREATE INDEX "satisfies_course_idx" ON "satisfies" ("course_id");

CREATE INDEX "satisfies_requirement_idx" ON "satisfies" ("requirement_id");
