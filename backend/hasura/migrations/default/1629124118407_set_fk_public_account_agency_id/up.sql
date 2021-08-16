alter table "public"."account"
  add constraint "account_agency_id_fkey"
  foreign key ("agency_id")
  references "public"."agency"
  ("id") on update cascade on delete restrict;
