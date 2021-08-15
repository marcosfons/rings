alter table "public"."service"
  add constraint "service_account_id_fkey"
  foreign key ("account_id")
  references "public"."account"
  ("id") on update cascade on delete restrict;
