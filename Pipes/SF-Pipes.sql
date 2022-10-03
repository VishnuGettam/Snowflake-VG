show integrations;

desc integration AWS_S3_INTEGRATION; 

alter integration aws_s3_integration
set STORAGE_ALLOWED_LOCATIONS=('s3://snowflake-data-s3/csv/snowpipe/');

show tables;

create or replace stage aws_s3_pipe
url='s3://snowflake-data-s3/csv/snowpipe/'
storage_integration=aws_s3_integration;

list @aws_s3_pipe;

create or replace pipe aws_sf_employee_pipe
auto_ingest = true
comment='this is snowflake pipe for employee table'
as 
copy into aws_db.public.employees
from @aws_s3_pipe
file_format=(format_name='ff_csv');


create or replace file format ff_csv
type='csv'
field_delimiter=','
record_delimiter='\n'
skip_header=1


//
alter pipe aws_sf_employee_pipe refresh;

//validate the pipe status (will give general information)
select system$pipe_status('aws_sf_employee_pipe');

//snowpipe error 
select * from 
table(validate_pipe_load(PIPE_NAME => 'aws_sf_employee_pipe' , START_TIME =>  dateadd(HOUR,-2,current_timestamp()) ))

//check the copy history
select * from  table(Information_schema.Copy_history(
table_name => 'aws_db.public.employees',
START_TIME =>  dateadd(HOUR,-8,current_timestamp())
))

select count(*) from aws_db.public.employees;


desc pipe aws_sf_employee_pipe;



alter pipe aws_sf_employee_pipe set pipe_execution_paused = true;

select system$pipe_status('aws_sf_employee_pipe');

create or replace pipe aws_sf_employee_pipe
auto_ingest = true
comment='this is snowflake pipe for employee table'
as 
copy into aws_db.public.employees_v1
from @aws_s3_pipe
file_format=(format_name='ff_csv');

alter pipe aws_sf_employee_pipe set pipe_execution_paused = false;


alter pipe  aws_sf_employee_pipe refresh;

select count(*) from aws_db.public.employees_v1;
