//create new DB 
create or replace database timetravel;

//create new schema 
create or replace schema private;

//create new table 
CREATE OR REPLACE TABLE timetravel.private.test (
id int,
first_name string,
last_name string,
email string,
gender string,
Job string,
Phone string
)

//file formar csv
create or replace file format ff_csv
type='csv'
field_delimiter=','
record_delimiter='\n'
skip_header=1;

//create external stage 
create or replace stage stg_timetravel
URL = 's3://data-snowflake-fundamentals/time-travel/'
file_format = ff_csv;

list @stg_timetravel;


//copy cmd 
copy into test
from @stg_timetravel

//data check
select * from test;