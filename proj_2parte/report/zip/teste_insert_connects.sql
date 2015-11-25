source database_triggers_insert.sql
source trigger_pan_device_insert.sql

/*Inserir mesmo Device noutro PAN*/

/*Overlap Situação 1 new.start <= Connects.start e Connects.start <= new.end <= Connects.end*/
insert into Connects values ('2010-10-10', '2011-10-10', 123456789, 'Philips', 'www.pan3.pt');
/*Overlap Situação 2 Connects.start <= new.start <= Connects.end e Connects.start <= new.end <= Connects.end*/
insert into Connects values ('2011-10-10', '2012-10-10', 123456789, 'Philips', 'www.pan3.pt');
/*Overlap Situação 3 Connects.start <= new.start <= Connects.end e new.end >= Connects.end*/
insert into Connects values ('2011-10-10', '2013-10-10', 123456789, 'Philips', 'www.pan3.pt');
/*Overlap Situação 4 new.start <= Connects.start e new.end >= Connects.end*/
insert into Connects values ('2010-10-10', '2013-10-10', 123456789, 'Philips', 'www.pan3.pt');
/*Sem Overlap Situação 5 new.start <= Connects.start e new.end <= Connects.start*/
insert into Connects values ('2009-10-10', '2010-10-10', 123456789, 'Philips', 'www.pan3.pt');
/*Sem Overlap Situação 6 new.start >= Connects.end e new.end >= Connects.end*/
insert into Connects values ('2016-10-10', '2017-10-10', 123456789, 'Philips', 'www.pan3.pt');
