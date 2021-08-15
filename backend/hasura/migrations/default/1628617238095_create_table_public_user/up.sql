CREATE TABLE "public"."user" ("uuid" uuid NOT NULL DEFAULT gen_random_uuid(), "name" text NOT NULL, PRIMARY KEY ("uuid") );
CREATE EXTENSION IF NOT EXISTS pgcrypto;
