
alter table "public"."employee" drop constraint "employee_email_key";

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."employee" add column "email" text
--  not null;

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."employee" add column "password" text
--  not null;

DELETE FROM "public"."transaction_type" WHERE "type" = 'transference';

DELETE FROM "public"."transaction_type" WHERE "type" = 'payment';

DELETE FROM "public"."service_type" WHERE "type" = 'auto_phone_recharge';

DELETE FROM "public"."service_type" WHERE "type" = 'loan';

DELETE FROM "public"."service_type" WHERE "type" = 'insurance';

DELETE FROM "public"."operation_type" WHERE "type" = 'hire_service';

DELETE FROM "public"."operation_type" WHERE "type" = 'make_transaction';

DELETE FROM "public"."operation_type" WHERE "type" = 'update_client_data';

DELETE FROM "public"."operation_type" WHERE "type" = 'view_client_data';

DELETE FROM "public"."operation_type" WHERE "type" = 'create_account';

DELETE FROM "public"."operation_type" WHERE "type" = 'register_client';

DELETE FROM "public"."account_type" WHERE "type" = 'savings';

DELETE FROM "public"."account_type" WHERE "type" = 'checking';

alter table "public"."client" drop constraint "valid_cnpj";

alter table "public"."client" drop constraint "valid_cpf";

alter table "public"."service" drop constraint "service_type_fkey";

DROP TABLE "public"."service_type";

alter table "public"."service" drop constraint "service_account_id_fkey";

DROP TABLE "public"."service";

alter table "public"."transaction" drop constraint "transaction_favored_account_id_fkey";

alter table "public"."transaction" drop constraint "transaction_account_id_fkey";

alter table "public"."transaction" drop constraint "transaction_type_fkey";

DROP TABLE "public"."transaction_type";

DROP TABLE "public"."transaction";

alter table "public"."account" drop constraint "account_type_fkey";

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."account" add column "type" text
--  not null;

DROP TABLE "public"."account_type";

DROP TABLE "public"."account";

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."operation" add column "service_id" integer
--  null;

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."operation" add column "transaction_id" integer
--  null;

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."operation" add column "created_at" timestamptz
--  null default now();

alter table "public"."operation" drop constraint "operation_client_id_fkey";

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."operation" add column "client_id" integer
--  not null;

alter table "public"."operation" alter column "name" drop not null;
alter table "public"."operation" add column "name" text;

alter table "public"."operation" drop constraint "operation_type_fkey";

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."operation" add column "type" text
--  not null;

DROP TABLE "public"."operation_type";

DROP TABLE "public"."operation";

DROP TABLE "public"."employee";

DROP TABLE "public"."client";

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- DROP table "public"."user";

DROP TABLE "public"."user";
