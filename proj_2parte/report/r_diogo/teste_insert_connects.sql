source database_triggers_insert.sql
source trigger_pan_device_insert.sql

insert into Connects values ('2010-10-10', '2011-10-10',
		123456789, 'Philips', 'www.pan3.pt');
insert into Connects values ('2011-10-10', '2012-10-10', 
		123456789, 'Philips', 'www.pan3.pt');
insert into Connects values ('2011-10-10', '2013-10-10', 
		123456789, 'Philips', 'www.pan3.pt');
insert into Connects values ('2010-10-10', '2013-10-10', 
		123456789, 'Philips', 'www.pan3.pt');
insert into Connects values ('2009-10-10', '2010-10-10', 
		123456789, 'Philips', 'www.pan3.pt');
insert into Connects values ('2016-10-10', '2017-10-10', 
		123456789, 'Philips', 'www.pan3.pt');
