alter table "public"."client" add constraint "valid_cnpj" check (cnpj ~ '[0-9]{2}\.[0-9]{3}\.[0-9]{3}\/[0-9]{4}\-[0-9]{2}');
