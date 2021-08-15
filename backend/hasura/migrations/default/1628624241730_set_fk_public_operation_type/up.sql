alter table "public"."operation"
  add constraint "operation_type_fkey"
  foreign key ("type")
  references "public"."operation_type"
  ("type") on update cascade on delete restrict;
