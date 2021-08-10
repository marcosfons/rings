alter table "public"."account"
  add constraint "account_type_fkey"
  foreign key ("type")
  references "public"."account_type"
  ("type") on update cascade on delete restrict;
