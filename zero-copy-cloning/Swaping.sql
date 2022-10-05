show tables;

//create new schema
create or replace schema PROD_SCHEMA;

//create new table using CLONE option 
create or replace table intl_db.prod_schema.currencies
clone intl_db.public.currencies;

select * from currencies;

//modify the data
update currencies 
set Currency_contry_name=Null;

//get the data from PROD SCHEMA 
alter table currencies
swap with intl_db.public.currencies;
