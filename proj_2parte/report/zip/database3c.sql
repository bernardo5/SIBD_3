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
	Esta base de dados testa a alínea 3c)
	Foram criados 8 Devices todos descritos por scale, mas com serial
	number e manufacturers diferentes. Estes 8 Devices foram divididos
	por 4 Patients correspondentes aos 3 elementos do grupo e o sem-abrigo
	Zé-Manel.
	
	O primeiro paciente Bernardo Gomes vive em Quarteira no ano de 2014,
	e veste o PAN1 durante os anos de 2013 e 2014, sendo que esse PAN 
	tem 2 Devices (Philips e RPG) conectados, um entre os anos 2013 e
	2014 e o outro no ano de 2015.
	
	O segundo paciente Diogo Martins vive em Alcochete no ano de 2014, e
	veste o PAN2 e PAN3 em duas alturas distintas, o primeiro entre 2014
	e 2015 e o segundo entre 2012 e 2013, sendo que o PAN2 tem 1 Device 
	(Panasonic) ligado nos anos 2013 a 2015 e o PAN3 também um device mas
	(LG) ligado nos anos 2014 e 2014.
	
	O terceiro paciente Diogo Proença vive no Montijo entre 2011 e 2012,
	vestindo o PAN4 entre 2013 e 2014, sendo que o PAN4 possui 2 Devices
	(Sony e Samsung) associados ambos ligados entre 2013 e 2014.
	
	O último paciente Zé Manel encontra-se de momento sem-abrigo, ou não
	vive em nenhum munícipio presente na base de dados do Medical Center.
	Porém veste o PAN5 entre 2013 e 2014 com 2 Devices (Siemens e HP)
	instalados nessePAN ambos entre 2013 e 2014.
	
	O resultado da Query será:
	Philips - pois encontra-se conectado entre 2013 e 2014 num intervalo
	contido no período em que Bernardo veste o PAN durante o ano de 2014,
	acrescentado ao facto que Bernardo vive num munícipio num intervalo
	também contido no período em que veste o PAN.
	Panasonic - pois encontra-se conectado a PAN2 entre 2014 e 2015, num
	intervalo contido no período em que Diogo veste o PAN durante o ano 
	de 2014, acrescentado ao facto que Diogo vive num munícipio num intervalo
	também contido no período em que veste o PAN,
	
	O Device RPG não cumpre a especificação de estar ligado ao PAN na mesma
	altura que Bernardo vive num município e veste esse PAN durante o ano de 2014.
	O Device LG não cumpre a especificação de Diogo vestir o PAN durante
	o ano de 2014 simultaneamente quando vive num muncicípio em 2014 e ter
	Devices ligados ao PAN.
	Os Devices Sony e Samsung não cumprem a especificação de Proença estar
	a viver num munícipio durante um ano de 2014 simultaneamente a estar
	a vestir um PAN e esse PAN ter tais Devices ligados.
	Os Devices Siemens e HP não cumprem a especificação pois Zé Manel não
	se encontra a viver num muncicípio coberto pelo Medical Center.
	
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
insert into PAN values ('www.pan5.pt', '+351 91 000 00 04');

insert into Device values (123456789, 'Philips', 'scale');
insert into Device values (123456790, 'RPG', 'scale');
insert into Device values (123456791, 'Panasonic', 'scale');
insert into Device values (123456792, 'LG', 'scale');
insert into Device values (123456793, 'Sony', 'scale');
insert into Device values (123456794, 'Samsung', 'scale');
insert into Device values (123456795, 'Siemens', 'scale');
insert into Device values (123456796, 'HP', 'scale');


insert into Period values ('2013-11-10', '2014-12-10');/*Connects Bernardo, Diogo e Proença bem*/
insert into Period values ('2015-11-10', '2015-12-10');/*Connects Bernardo Mal*/
insert into Period values ('2013-11-10', '2015-12-10');/*Connects Diogo com Wears Bem*/
insert into Period values ('2013-10-07', '2014-11-10');/*Wears Bernardo*/
insert into Period values ('2014-09-10', '2015-10-01');/*Wears Diogo Bem*/ 
insert into Period values ('2012-09-10', '2013-01-01');/*Wears Diogo Mal*/
insert into Period values ('2013-08-07', '2014-08-10');/*Wears Proença*/
insert into Period values ('2013-09-07', '2014-09-10');/*Wears Zé Manel*/
insert into Period values ('2014-10-10', '2014-12-10');/*Lives Bernardo*/
insert into Period values ('2014-09-10', '2014-10-10');/*Lives Diogo*/
insert into Period values ('2011-10-10', '2012-10-10');/*Lives Proença*/

insert into Connects values ('2013-11-10', '2014-12-10', 123456789, 'Philips', 'www.pan1.pt');
insert into Connects values ('2015-11-10', '2015-12-10', 123456790, 'RPG', 'www.pan1.pt');
insert into Connects values ('2013-11-10', '2015-12-10', 123456791, 'Panasonic', 'www.pan2.pt');
insert into Connects values ('2013-11-10', '2014-12-10', 123456792, 'LG', 'www.pan3.pt');
insert into Connects values ('2013-11-10', '2014-12-10', 123456793, 'Sony', 'www.pan4.pt');
insert into Connects values ('2013-11-10', '2014-12-10', 123456794, 'Samsung', 'www.pan4.pt');
insert into Connects values ('2013-11-10', '2014-12-10', 123456795, 'Siemens', 'www.pan5.pt');
insert into Connects values ('2013-11-10', '2014-12-10', 123456796, 'HP', 'www.pan5.pt');

insert into Wears values ('2013-10-07', '2014-11-10', '001-54245-1555555', 'www.pan1.pt');
insert into Wears values ('2014-09-10', '2015-10-01', '001-54245-1555575', 'www.pan2.pt');
insert into Wears values ('2012-09-10', '2013-01-01', '001-54245-1555575', 'www.pan3.pt'); 
insert into Wears values ('2013-08-07', '2014-08-10', '001-54745-1555556', 'www.pan4.pt'); 
insert into Wears values ('2013-09-07', '2014-09-10', '001-54245-1855555', 'www.pan5.pt');  

insert into Municipality values (2870, 'Montijo');
insert into Municipality values (2890, 'Alcochete');
insert into Municipality values (8125, 'Quarteira');

insert into Lives values ('2014-10-10', '2014-12-10', '001-54245-1555555', 8125);
insert into Lives values ('2014-09-10', '2014-10-10', '001-54245-1555575', 2890);
insert into Lives values ('2011-10-10', '2012-10-10', '001-54745-1555556', 2870);

