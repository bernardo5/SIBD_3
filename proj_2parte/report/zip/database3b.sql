drop table if exists Reading;
drop table if exists Setting;
drop table if exists Sensor;
drop table if exists Actuator;
drop table if exists Connects;
drop table if exists Device;
drop table if exists Lives;
drop table if exists Wears;
drop table if exists Patient;
drop table if exists PAN;
drop table if exists Municipality;
drop table if exists Period;

/* ********************************************************************
	Esta base de dados testa a alínea 3b)
	Foram criados 9 Devices com manufacturer Philips com serial number
	diferentes mas consecutivos, 3 Patients correspondentes aos elementos
	do grupo, 3 Municipalities onde cada elemento viverá e 4 PANs.
	Para testar fez-se com que o Patient Bernardo vestisse 2 PANS, PAN1,
	e PAN2, Patient Diogo vestisse a PAN3 e o Patient Proença PAN4.
	A PAN1 possui 3 Devices, PAN2 apenas 1 Device, PAN3 2 Devices e por
	fim PAN4 possui 3 Devices. Todos os Devices têm descrição diferente.
	Os Patients Bernardo e Diogo vivem em Quarteira e Alcochete respecti-
	vamente num período que abrange a data actual, enquanto que o Patient
	Proença vive no Montijo num período que não abrange a data actual.
	Dos 4 Devices que se encontram nos 2 PANs que Bernardo veste, apenas
	3 cumprem as especificações todas. Bernardo veste o PAN1 numa data 
	onde a data actual se encontra contida porém tal não acontece com PAN2,
	vestino o PAN num período que não inclui a data actual.
	Todos os Devices que se encontram nas Pans do Diogo e do Proença
	cumprem todas as especificações de tempo tanto de Wears como Connects
	em relação à data actual.
	Como Bernardo possui 3 Devices que cumprem todas as especificações
	vence perante Diogo uma vez que este possui apenas 2.
	Como Bernardo vive num munícipio numa data que abrange a actual vence
	perante Proença uma vez que este não cumpre esta condição
	Assim o munícipio que possui agora o maior número de Devices Philips
	será Quarteira. Para verificar os Devices que cumprem as especificações
	subsituir no códico Select max(m.name), nut4code por:
	Select distinct description
	*******************************************************************/

create table Patient(
	number varchar(40),
	name varchar(255),
	address varchar(255),
	primary key(number));

create table PAN(
	domain varchar(255),
	phone varchar(20),
	primary key(domain));

create table Device(
	serialnum integer,
	manufacturer varchar(255),
	description varchar(255),
	primary key(serialnum, manufacturer));

create table Sensor(
	snum integer,
	manuf varchar(255),
	units varchar(255),
	primary key(snum, manuf),
	foreign key(snum, manuf) references Device(serialnum, manufacturer));

create table Actuator(
	snum integer,
	manuf varchar(255),
	units varchar(255),
	primary key(snum, manuf),
	foreign key(snum, manuf) references Device(serialnum, manufacturer));

create table Municipality(
	nut4code integer,
	name varchar(255),
	primary key(nut4code));

create table Period(
	start date,
	end date,
	check(start < end),
	primary key(start, end));

create table Reading(
	snum integer,
	manuf varchar(255),
	datetime timestamp,
	value numeric(20,2),
	primary key(snum, manuf, datetime),
	foreign key(snum, manuf) references Sensor(snum, manuf));

create table Setting(
	snum integer,
	manuf varchar(255),
	datetime timestamp,
	value numeric(20,2),
	primary key(snum, manuf, datetime),
	foreign key(snum, manuf) references Actuator(snum, manuf));

create table Wears(
	start date,
	end date,
	patient varchar(255),
	pan varchar(255),
	check(start < end),
	primary key(start, end, patient),
	foreign key(start, end) references Period(start, end),
	foreign key(patient) references Patient(number),
	foreign key(pan) references PAN(domain));

create table Lives(
	start date,
	end date,
	patient varchar(255),
	muni integer,
	check(start < end),
	primary key(start, end, patient),
	foreign key(start, end) references Period(start, end),
	foreign key(patient) references Patient(number),
	foreign key(muni) references Municipality(nut4code));

create table Connects(
	start date,
	end date,
	snum integer,
	manuf varchar(255),
	pan varchar(255),
	check(start < end),
	primary key(start, end, snum, manuf),
	foreign key(start, end) references Period(start, end),
	foreign key(snum, manuf) references Device(serialnum, manufacturer),
	foreign key(pan) references PAN(domain));



insert into Patient values ('001-54245-1555555', 'Bernardo Gomes', 'Rua Alves Redol');
insert into Patient values ('001-54245-1555575', 'Diogo Martins', 'Avenida João Crisóstomo');
insert into Patient values ('001-54745-1555556', 'Diogo Proença', 'Avenida Praia da Vitória');
insert into Patient values ('001-54245-1855555', 'Zé Manel', 'Avenida Duque de Ávila');

insert into PAN values ('www.pan1.pt', '+351 91 000 00 00');
insert into PAN values ('www.pan2.pt', '+351 91 000 00 01');
insert into PAN values ('www.pan3.pt', '+351 91 000 00 02');
insert into PAN values ('www.pan4.pt', '+351 91 000 00 03');

insert into Device values (123456789, 'Philips', 'blood pressure');
insert into Device values (123456790, 'Philips', 'insuline meter');
insert into Device values (123456791, 'Philips', 'heart rate');
insert into Device values (123456792, 'Philips', 'scale');
insert into Device values (123456793, 'Philips', 'temperature');
insert into Device values (123456794, 'Philips', 'respiratory rate');
insert into Device values (123456795, 'Philips', 'oxygen saturation');
insert into Device values (123456796, 'Philips', 'urea meter');
insert into Device values (123456797, 'Philips', 'lymphocites rate');

insert into Period values ('2015-11-10', '2015-12-10'); /*Period Devices connects PAN1,2,4*/
insert into Period values ('2015-10-10', '2015-11-30'); /*Period Devices Connects PAN3*/
insert into Period values ('2015-09-10', '2016-01-01'); /*Period Bernardo wears PAN1*/
insert into Period values ('2015-04-10', '2015-05-10'); /*Period Bernardo wears PAN2*/
insert into Period values ('2015-10-25', '2015-11-25'); /*Period Diogo wears PAN3*/
insert into Period values ('2015-11-15', '2015-11-25'); /*Period Proença wears PAN4*/
insert into Period values ('2015-10-10', '2016-10-10'); /*Period Bernardo and Diogo live in their Munis*/
insert into Period values ('2011-10-10', '2013-10-10'); /*Period Proença lives in his Muni*/

insert into Connects values ('2015-11-10', '2015-12-10', 123456789, 'Philips', 'www.pan1.pt');/*BP*/
insert into Connects values ('2015-11-10', '2015-12-10', 123456790, 'Philips', 'www.pan1.pt');/*IM*/
insert into Connects values ('2015-11-10', '2015-12-10', 123456791, 'Philips', 'www.pan1.pt');/*HR*/
insert into Connects values ('2015-11-10', '2015-12-10', 123456792, 'Philips', 'www.pan2.pt');/*Scale*/
insert into Connects values ('2015-10-10', '2015-11-30', 123456793, 'Philips', 'www.pan3.pt');/*Temperature*/
insert into Connects values ('2015-10-10', '2015-11-30', 123456794, 'Philips', 'www.pan3.pt');/*RR*/
insert into Connects values ('2015-11-10', '2015-12-10', 123456795, 'Philips', 'www.pan4.pt');/*OS*/
insert into Connects values ('2015-11-10', '2015-12-10', 123456796, 'Philips', 'www.pan4.pt');/*UM*/
insert into Connects values ('2015-11-10', '2015-12-10', 123456797, 'Philips', 'www.pan4.pt');/*LR*/

insert into Wears values ('2015-09-10', '2016-01-01', '001-54245-1555555', 'www.pan1.pt'); /*Bernardo*/
insert into Wears values ('2015-04-10', '2015-05-10', '001-54245-1555555', 'www.pan2.pt'); /*Bernardo*/ /*Bernardo*/
insert into Wears values ('2015-10-25', '2015-11-25', '001-54245-1555575', 'www.pan3.pt'); /*Diogo*/
insert into Wears values ('2015-11-15', '2015-11-25', '001-54745-1555556', 'www.pan4.pt'); /*Proença*/

insert into Municipality values (2870, 'Montijo');
insert into Municipality values (2890, 'Alcochete');
insert into Municipality values (8125, 'Quarteira');

insert into Lives values ('2015-10-10', '2016-10-10', '001-54245-1555555', 8125);
insert into Lives values ('2015-10-10', '2016-10-10', '001-54245-1555575', 2890);
insert into Lives values ('2011-10-10', '2013-10-10', '001-54745-1555556', 2870);

