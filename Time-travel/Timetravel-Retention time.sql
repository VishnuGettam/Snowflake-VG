//check the retention_time property 
show tables like '%test%';


//Method 1  - Modify the retention_time using alter statement
alter table test
set data_retention_time_in_days= 3;

//Method 2 - during table creation
create or replace TABLE TEST (
	ID NUMBER(38,0),
	FIRST_NAME VARCHAR,
	LAST_NAME VARCHAR,
	EMAIL VARCHAR,
	GENDER VARCHAR,
	PHONE VARCHAR,
	JOB VARCHAR
)
data_retention_time_in_days= 2;

//data load
copy into test
from @STG_TIMETRAVEL;


//data retention to zero,time travel doesn't work
alter table test
set data_retention_time_in_days= 0;

//drop table
drop table test;

//undrop table (which makes to either default value or fails to work)
undrop table test;

//validate the data
select * from test;
