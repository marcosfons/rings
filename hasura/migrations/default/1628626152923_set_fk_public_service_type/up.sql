alter table "public"."service"
  add constraint "service_type_fkey"
  foreign key ("type")
  references "public"."service_type"
  ("type") on update cascade on delete restrict;
