alter table "public"."account" alter column "city" drop not null;
alter table "public"."account" add column "city" text;
