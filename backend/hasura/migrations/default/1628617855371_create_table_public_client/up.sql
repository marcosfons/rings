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
