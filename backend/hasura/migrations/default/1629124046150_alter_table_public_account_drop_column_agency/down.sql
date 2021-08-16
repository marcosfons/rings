alter table "public"."account" alter column "agency" drop not null;
alter table "public"."account" add column "agency" text;
