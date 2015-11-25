source database_triggers_update.sql
source trigger_pan_patient_update.sql

/*Situação em que novo Paciente veste um PAN já usado por outro Paciente*/
/*Com overlap*/

/* Aumentar new.end com overlap*/
update Wears set start = '2013-11-25', end = '2015-12-02' where patient ='001-54245-1555575' and pan = 'www.pan1.pt';
/* Diminuir new.start com overlap*/
update Wears set start = '2012-10-25', end = '2013-12-01' where patient ='001-54245-1555575' and pan = 'www.pan1.pt';
/* Diminuir new.end e diminuir new.start com overlap*/
update Wears set start = '2011-11-24', end = '2013-11-20' where patient ='001-54245-1555575' and pan = 'www.pan1.pt';
/* Aumentar new.end e diminuir new.start com overlap*/
update Wears set start = '2011-11-24', end = '2015-12-02' where patient ='001-54245-1555575' and pan = 'www.pan1.pt';
/* Aumentar new.end e aumentar new.start com overlap*/ 
update Wears set start = '2013-11-26', end = '2015-12-02' where patient ='001-54245-1555575' and pan = 'www.pan1.pt';

/* Diminuir new.end sem overlap*/
update Wears set start = '2013-11-25', end = '2013-11-28' where patient ='001-54245-1555575' and pan = 'www.pan1.pt';
/* Aumentar new.end sem overlap*/
update Wears set start = '2013-11-25', end = '2013-12-02' where patient ='001-54245-1555575' and pan = 'www.pan1.pt';
/* Diminuir new.start sem overlap*/
update Wears set start = '2013-10-25', end = '2013-12-01' where patient ='001-54245-1555575' and pan = 'www.pan1.pt';
/* Aumentar new.start sem overlap*/
update Wears set start = '2013-11-26', end = '2013-12-01' where patient ='001-54245-1555575' and pan = 'www.pan1.pt';
/* Diminuir new.end e diminuir new.start sem overlap*/
update Wears set start = '2013-11-24', end = '2013-11-20' where patient ='001-54245-1555575' and pan = 'www.pan1.pt';
/* Diminuir new.end e aumentar new.start sem overlap*/
update Wears set start = '2013-11-26', end = '2013-11-30' where patient ='001-54245-1555575' and pan = 'www.pan1.pt';
/* Aumentar new.end e diminuir new.start sem overlap*/
update Wears set start = '2013-11-24', end = '2013-12-02' where patient ='001-54245-1555575' and pan = 'www.pan1.pt';
/* Aumentar new.end e aumentar new.start sem overlap*/
update Wears set start = '2013-11-26', end = '2013-12-02' where patient ='001-54245-1555575' and pan = 'www.pan1.pt';

/*Situação em que o mesmo Paciente veste mais do que um PAN*/
/*Com overlap*/

/* Aumentar new.end com overlap*/
update Wears set start = '2013-11-25', end = '2015-12-02' where patient ='001-54245-1555555' and pan = 'www.pan3.pt';
/* Diminuir new.start com overlap*/
update Wears set start = '2012-10-25', end = '2013-12-01' where patient ='001-54245-1555555' and pan = 'www.pan3.pt';
/* Diminuir new.end e diminuir new.start com overlap*/
update Wears set start = '2011-11-24', end = '2013-11-20' where patient ='001-54245-1555555' and pan = 'www.pan3.pt';
/* Aumentar new.end e diminuir new.start com overlap*/
update Wears set start = '2011-11-24', end = '2015-12-02' where patient ='001-54245-1555555' and pan = 'www.pan3.pt';
/* Aumentar new.end e aumentar new.start com overlap*/ 
update Wears set start = '2013-11-26', end = '2015-12-02' where patient ='001-54245-1555555' and pan = 'www.pan3.pt';

/* Diminuir new.end sem overlap*/
update Wears set start = '2013-11-25', end = '2013-11-28' where patient ='001-54245-1555555' and pan = 'www.pan3.pt';
/* Aumentar new.end sem overlap*/
update Wears set start = '2013-11-25', end = '2013-12-02' where patient ='001-54245-1555555' and pan = 'www.pan3.pt';
/* Diminuir new.start sem overlap*/
update Wears set start = '2013-10-25', end = '2013-12-01' where patient ='001-54245-1555555' and pan = 'www.pan3.pt';
/* Aumentar new.start sem overlap*/
update Wears set start = '2013-11-26', end = '2013-12-01' where patient ='001-54245-1555555' and pan = 'www.pan3.pt';
/* Diminuir new.end e diminuir new.start sem overlap*/
update Wears set start = '2013-11-24', end = '2013-11-20' where patient ='001-54245-1555555' and pan = 'www.pan3.pt';
/* Diminuir new.end e aumentar new.start sem overlap*/
update Wears set start = '2013-11-26', end = '2013-11-30' where patient ='001-54245-1555555' and pan = 'www.pan3.pt';
/* Aumentar new.end e diminuir new.start sem overlap*/
update Wears set start = '2013-11-24', end = '2013-12-02' where patient ='001-54245-1555555' and pan = 'www.pan3.pt';
/* Aumentar new.end e aumentar new.start sem overlap*/
update Wears set start = '2013-11-26', end = '2013-12-02' where patient ='001-54245-1555555' and pan = 'www.pan3.pt';


