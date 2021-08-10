alter table "public"."operation"
  add constraint "operation_client_id_fkey"
  foreign key ("client_id")
  references "public"."client"
  ("id") on update cascade on delete restrict;
