
CREATE TABLE "public"."user" ("uuid" uuid NOT NULL DEFAULT gen_random_uuid(), "name" text NOT NULL, PRIMARY KEY ("uuid") );
CREATE EXTENSION IF NOT EXISTS pgcrypto;

DROP table "public"."user";

CREATE TABLE "public"."client" ("id" serial NOT NULL, "name" text NOT NULL, "cpf" text NOT NULL, "cnpj" text, "nickname" text NOT NULL, "email" text NOT NULL, "address" text NOT NULL, "occupation" text NOT NULL, "phone" text NOT NULL, "address_receipt_image" text NOT NULL, "profit_receipt_image" text NOT NULL, "updated_at" timestamptz NOT NULL DEFAULT now(), "created_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") , UNIQUE ("id"));
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_client_updated_at"
BEFORE UPDATE ON "public"."client"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_client_updated_at" ON "public"."client" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

CREATE TABLE "public"."employee" ("id" serial NOT NULL, "name" text NOT NULL, "image" text NOT NULL, "updated_at" timestamptz NOT NULL DEFAULT now(), "created_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") , UNIQUE ("id"));
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_employee_updated_at"
BEFORE UPDATE ON "public"."employee"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_employee_updated_at" ON "public"."employee" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

CREATE TABLE "public"."operation" ("id" serial NOT NULL, "name" text NOT NULL, "employee_id" integer NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("employee_id") REFERENCES "public"."employee"("id") ON UPDATE cascade ON DELETE restrict, UNIQUE ("id"));

CREATE TABLE "public"."operation_type" ("type" text NOT NULL, PRIMARY KEY ("type") , UNIQUE ("type"));

alter table "public"."operation" add column "type" text
 not null;

alter table "public"."operation"
  add constraint "operation_type_fkey"
  foreign key ("type")
  references "public"."operation_type"
  ("type") on update cascade on delete restrict;

alter table "public"."operation" drop column "name" cascade;

alter table "public"."operation" add column "client_id" integer
 not null;

alter table "public"."operation"
  add constraint "operation_client_id_fkey"
  foreign key ("client_id")
  references "public"."client"
  ("id") on update cascade on delete restrict;

alter table "public"."operation" add column "created_at" timestamptz
 null default now();

alter table "public"."operation" add column "transaction_id" integer
 null;

alter table "public"."operation" add column "service_id" integer
 null;

CREATE TABLE "public"."account" ("id" serial NOT NULL, "balance" integer NOT NULL DEFAULT 0, "number" text NOT NULL, "agency" text NOT NULL, "city" text NOT NULL, "state" text NOT NULL, "updated_at" timestamptz NOT NULL DEFAULT now(), "created_at" timestamptz NOT NULL DEFAULT now(), "client_id" integer NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("client_id") REFERENCES "public"."client"("id") ON UPDATE cascade ON DELETE restrict, UNIQUE ("id"));
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_account_updated_at"
BEFORE UPDATE ON "public"."account"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_account_updated_at" ON "public"."account" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

CREATE TABLE "public"."account_type" ("type" text NOT NULL, PRIMARY KEY ("type") , UNIQUE ("type"));

alter table "public"."account" add column "type" text
 not null;

alter table "public"."account"
  add constraint "account_type_fkey"
  foreign key ("type")
  references "public"."account_type"
  ("type") on update cascade on delete restrict;

CREATE TABLE "public"."transaction" ("id" serial NOT NULL, "value" integer NOT NULL, "receipt" text, "created_at" timestamptz NOT NULL DEFAULT now(), "type" text NOT NULL, "boleto_number" text, "account_id" integer NOT NULL, "favored_account_id" integer, PRIMARY KEY ("id") );

CREATE TABLE "public"."transaction_type" ("type" text NOT NULL, PRIMARY KEY ("type") , UNIQUE ("type"));

alter table "public"."transaction"
  add constraint "transaction_type_fkey"
  foreign key ("type")
  references "public"."transaction_type"
  ("type") on update cascade on delete restrict;

alter table "public"."transaction"
  add constraint "transaction_account_id_fkey"
  foreign key ("account_id")
  references "public"."account"
  ("id") on update cascade on delete restrict;

alter table "public"."transaction"
  add constraint "transaction_favored_account_id_fkey"
  foreign key ("favored_account_id")
  references "public"."account"
  ("id") on update cascade on delete restrict;

CREATE TABLE "public"."service" ("id" serial NOT NULL, "name" text NOT NULL, "tax" integer NOT NULL, "hired_at" timestamptz NOT NULL, "canceled_at" timestamptz, "value" integer, "due_at" timestamptz, "insurance" text, "type" text NOT NULL, "account_id" integer NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") , UNIQUE ("id"));

alter table "public"."service"
  add constraint "service_account_id_fkey"
  foreign key ("account_id")
  references "public"."account"
  ("id") on update cascade on delete restrict;

CREATE TABLE "public"."service_type" ("type" text NOT NULL, PRIMARY KEY ("type") , UNIQUE ("type"));

alter table "public"."service"
  add constraint "service_type_fkey"
  foreign key ("type")
  references "public"."service_type"
  ("type") on update cascade on delete restrict;

alter table "public"."client" add constraint "valid_cpf" check (cpf ~ '[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}');

alter table "public"."client" add constraint "valid_cnpj" check (cnpj ~ '[0-9]{2}\.[0-9]{3}\.[0-9]{3}\/[0-9]{4}\-[0-9]{2}');

INSERT INTO "public"."account_type"("type") VALUES (E'checking');

INSERT INTO "public"."account_type"("type") VALUES (E'savings');

INSERT INTO "public"."operation_type"("type") VALUES (E'register_client');

INSERT INTO "public"."operation_type"("type") VALUES (E'create_account');

INSERT INTO "public"."operation_type"("type") VALUES (E'view_client_data');

INSERT INTO "public"."operation_type"("type") VALUES (E'update_client_data');

INSERT INTO "public"."operation_type"("type") VALUES (E'make_transaction');

INSERT INTO "public"."operation_type"("type") VALUES (E'hire_service');

INSERT INTO "public"."service_type"("type") VALUES (E'insurance');

INSERT INTO "public"."service_type"("type") VALUES (E'loan');

INSERT INTO "public"."service_type"("type") VALUES (E'auto_phone_recharge');

INSERT INTO "public"."transaction_type"("type") VALUES (E'payment');

INSERT INTO "public"."transaction_type"("type") VALUES (E'transference');

alter table "public"."employee" add column "password" text
 not null;

alter table "public"."employee" add column "email" text
 not null;

alter table "public"."employee" add constraint "employee_email_key" unique ("email");
