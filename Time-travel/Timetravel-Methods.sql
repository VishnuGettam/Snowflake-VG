//update the table mistakenly
update test
set FIRST_NAME= 'Sample';

//Method 1 - Offset 
Select * from test at (offset => -60 * 0.5) ; -- fetch the data which was 30 sec back 

//Method 2 - timestamp 

update test
set first_name = 'User Name'; 

Select * from test before (timestamp => '2022-10-03T12:30:03.264-07:00'::timestamp );

//Method 3 - before Query Id
 
Update test 
set last_name='user last name';

Select * from test before (statement => '01a762ff-3200-8296-0001-5faa0002c206');
