alter table "public"."transaction"
  add constraint "transaction_type_fkey"
  foreign key ("type")
  references "public"."transaction_type"
  ("type") on update cascade on delete restrict;
