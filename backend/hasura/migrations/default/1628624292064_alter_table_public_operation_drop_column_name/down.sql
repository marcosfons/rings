alter table "public"."operation" alter column "name" drop not null;
alter table "public"."operation" add column "name" text;
