alter table "public"."client" add constraint "valid_cpf" check (cpf ~ '[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}');
