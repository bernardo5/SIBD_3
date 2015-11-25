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

/* *********************************************************************
	Esta base de dados testa a alínea 3a)
	Foram criados 6 Devices de marcas diferentes, sendo que metade foram
	para o PAN1(RPG, Philips, Sony)  e a outra metade é colocada no
	PAN2 (LG, Samsung, Panasonic).
	Para este teste só irá aparece como resultado query a Reading que se
	encontra associada ao Device RPG pelas seguintes razões:
	1. O Reading de RPG encontra-se dentro do período da data actual até 
	menos 6 meses, Philips também mas Sony não. Por outro lado no PAN2
	o Reading de LG encontra-se dentro do período da data actual até 
	menos 6 meses, Samsung também, mas Panasonic não;
	
	2. O Reading de RPG encontra-se no período em que o Device está 
	conectado ao PAN1, mas o Reading de Philips não. No PAN2 o Reading
	de LG encontra-se dentro do período em que o Device está conectado  
	ao PAN2, mas o Reading de Samsung não;
	
	3. O Reading de RPG encontra-se no período em que o Patient veste o
	PAN1, mas o Reading de LG não se encontra no período em que o Patient
	veste o PAN2. 
	
	Primeiro ponto exclui Sony e Panasonic
	Segundo ponto exclui Philips e Samsung
	Terceiro Ponto exclui LG, restando RPG
	
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

insert into Device values (123456789, 'RPG', 'blood pressure');
insert into Device values (123456789, 'Philips', 'blood pressure');
insert into Device values (123456789, 'Sony', 'blood pressure');
insert into Device values (123456789, 'LG', 'blood pressure');
insert into Device values (123456789, 'Samsung', 'blood pressure');
insert into Device values (123456789, 'Panasonic', 'blood pressure');
insert into Device values (123456790, 'Philips', 'insuline meter');
insert into Device values (123456791, 'Philips', 'insuline meter');

insert into Actuator values (123456790, 'Philips', 'scale');
insert into Actuator values (123456791, 'Philips', 'insuline meter');

insert into Sensor values (123456790, 'Philips', 'insuline');
insert into Sensor values (123456789, 'RPG', 'pascal');
insert into Sensor values (123456789, 'Philips', 'pascal');
insert into Sensor values (123456789, 'Sony', 'pascal');
insert into Sensor values (123456789, 'LG', 'pascal');
insert into Sensor values (123456789, 'Samsung', 'pascal');
insert into Sensor values (123456789, 'Panasonic', 'pascal');

insert into Period values ('2015-04-01', '2015-10-25');
insert into Period values ('2015-04-01', '2015-04-25');
insert into Period values ('2014-10-09', '2015-12-01');
insert into Period values ('2011-10-09', '2012-12-01');

insert into Connects values ('2015-04-01', '2015-10-25', 123456789, 'RPG', 'www.pan1.pt');
insert into Connects values ('2015-04-01', '2015-04-25', 123456789, 'Philips', 'www.pan1.pt');
insert into Connects values ('2015-04-01', '2015-10-25', 123456789, 'Sony', 'www.pan1.pt');
insert into Connects values ('2015-04-01', '2015-10-25', 123456789, 'LG', 'www.pan2.pt');
insert into Connects values ('2015-04-01', '2015-04-25', 123456789, 'Samsung', 'www.pan2.pt');
insert into Connects values ('2015-04-01', '2015-10-25', 123456789, 'Panasonic', 'www.pan2.pt');

insert into Wears values ('2014-10-09', '2015-12-01', '001-54245-1555555', 'www.pan1.pt');
insert into Wears values ('2011-10-09', '2012-12-01', '001-54245-1555555', 'www.pan2.pt');

insert into Reading values (123456789, 'RPG', '2015-10-24 09:45:00', 10);
insert into Reading values (123456789, 'Philips', '2015-10-24 09:45:00', 11);
insert into Reading values (123456789, 'Sony', '2015-01-24 09:45:00', 12);
insert into Reading values (123456789, 'LG', '2015-10-24 09:45:00', 13);
insert into Reading values (123456789, 'Samsung', '2015-10-24 09:45:00', 14);
insert into Reading values (123456789, 'Panasonic', '2015-01-24 09:45:00', 20);

