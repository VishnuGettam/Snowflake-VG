use database timetravel;
use schema private;

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
copy into timetravel.private.test
from @STG_TIMETRAVEL;

select * from test; --01a7652a-3200-83dd-0001-5faa00033046

//updates to table test
update test
set first_name = 'sample data';

update test 
set last_name = 'another data'; -- 01a7652f-3200-83dd-0001-5faa00033056

//using time travel data can be checked 
select * from test before (statement => '01a7652a-3200-83dd-0001-5faa00033046');

//mistakently we updated the table with statement 01a7652f-3200-83dd-0001-5faa00033056 
create or replace table timetravel.private.test as
select * from test before (statement => '01a7652f-3200-83dd-0001-5faa00033056')

//so here we cant restore back to table data to 01a7652a-3200-83dd-0001-5faa00033046 due to replaced query above (here it drops and recreates the test table)
//so the old metadata will be lost 

//this fails to fetch the data due to replaced query 
select * from test before (statement => '01a7652a-3200-83dd-0001-5faa00033046');

//Here the trick is to rename the table to new one 
alter table test
rename to test_wrong;

//undrop the table and then restore it to old version of data 
undrop table timetravel.private.test

//this works 
select * from test before (statement => '01a7652a-3200-83dd-0001-5faa00033046');
