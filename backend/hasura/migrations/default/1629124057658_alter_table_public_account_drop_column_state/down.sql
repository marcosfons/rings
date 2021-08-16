alter table "public"."account" alter column "state" drop not null;
alter table "public"."account" add column "state" text;
