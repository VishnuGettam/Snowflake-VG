//table creation
CREATE OR REPLACE TABLE timetravel.private.test (
id int,
first_name string,
last_name string,
email string,
gender string,
Phone string,
Job string
);

//data load to table 
copy into test
from @STG_TIMETRAVEL;

//validate the data
select * from test; -- 01a7650b-3200-838c-0001-5faa000310de

//drop table 
drop table test;

//undrop table 
undrop table test;


//drop schema 
drop schema private;

//undrop schema 
undrop schema private;

//drop database 
drop database timetravel;

//undrop database 
undrop database timetravel;