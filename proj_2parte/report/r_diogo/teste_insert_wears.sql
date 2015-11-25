source database_triggers_insert.sql
source trigger_pan_patient_insert.sql

insert into Wears values ('2010-10-10', '2011-10-10',
	'001-54245-1555575', 'www.pan1.pt');
insert into Wears values ('2011-10-10', '2012-10-10', 
	'001-54245-1555575', 'www.pan1.pt');
insert into Wears values ('2011-10-10', '2013-10-10', 
	'001-54245-1555575', 'www.pan1.pt');
insert into Wears values ('2010-10-10', '2013-10-10', 
	'001-54245-1555575', 'www.pan1.pt');
insert into Wears values ('2009-10-10', '2010-10-10', 
	'001-54245-1555575', 'www.pan1.pt');
insert into Wears values ('2016-10-10', '2017-10-10', 
	'001-54245-1555575', 'www.pan1.pt');

insert into Wears values ('2010-10-10', '2011-10-10', 
	'001-54245-1555555', 'www.pan3.pt');
insert into Wears values ('2011-10-10', '2012-10-10', 
	'001-54245-1555555', 'www.pan3.pt');
insert into Wears values ('2011-10-10', '2013-10-10', 
	'001-54245-1555555', 'www.pan3.pt');
insert into Wears values ('2010-10-10', '2013-10-10', 
	'001-54245-1555555', 'www.pan3.pt');
insert into Wears values ('2009-10-10', '2010-10-10', 
	'001-54245-1555555', 'www.pan3.pt');
insert into Wears values ('2016-10-10', '2017-10-10', 
	'001-54245-1555555', 'www.pan3.pt');
