alter table "public"."transaction"
  add constraint "transaction_favored_account_id_fkey"
  foreign key ("favored_account_id")
  references "public"."account"
  ("id") on update cascade on delete restrict;
