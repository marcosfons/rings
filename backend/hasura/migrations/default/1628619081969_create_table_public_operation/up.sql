CREATE TABLE "public"."operation" ("id" serial NOT NULL, "name" text NOT NULL, "employee_id" integer NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("employee_id") REFERENCES "public"."employee"("id") ON UPDATE cascade ON DELETE restrict, UNIQUE ("id"));