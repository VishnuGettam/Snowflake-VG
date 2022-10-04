
CREATE OR REPLACE TABLE OUR_FIRST_DB.public.test (
   id int,
   first_name string,
  last_name string,
  email string,
  gender string,
  Phone string,
  Job string)


copy into test
from @STG_TIMETRAVEL;


select * from test; -- 01a7630d-3200-834c-0001-5faa000287ea

update test
set first_name = 'User First Name'; --01a7630e-3200-834c-0001-5faa000287ee

update test
set last_name = 'User Last Name'; --01a7630e-3200-8296-0001-5faa0002c292

Select * from test before (statement => '01a7630e-3200-834c-0001-5faa000287ee');

//Method 1 to restore data (direct replace the main table) - bad method
create or replace table test as 
Select * from test before (statement => '01a7630e-3200-834c-0001-5faa000287ee');

//Lost the meta data information of the main table as its replaced 
Select * from test before (statement => '01a7630e-3200-834c-0001-5faa000287ee');


//method 2 using another backup data 
update test
set first_name = 'User First Name'; --01a76313-3200-8296-0001-5faa0002c2ba

update test
set last_name = 'User Last Name'; --01a76313-3200-834c-0001-5faa0002881a

//creation of new backup table
create or replace table test_backup as
Select * from test before (statement => '01a76313-3200-8296-0001-5faa0002c2ba');

//truncate the main table
truncate table test ;

//insert the data from back up table to main table 
insert into test 
select * from test_backup;

//still holds the time travel feature 
Select * from test before (statement => '01a76313-3200-8296-0001-5faa0002c2ba');
















