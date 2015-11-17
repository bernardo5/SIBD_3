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
	primary key(start, end));

create table Reading(
	snum integer,
	manuf varchar(255),
	datetime timestamp,
	value numeric(20,2),
	primary key(snum, manuf),
	foreign key(snum, manuf) references Sensor(snum, manuf));

create table Setting(
	snum integer,
	manuf varchar(255),
	datetime timestamp,
	value numeric(20,2),
	primary key(snum, manuf),
	foreign key(snum, manuf) references Actuator(snum, manuf));

create table Wears(
	start date,
	end date,
	patient varchar(255),
	pan varchar(255),
	primary key(start, end),
	foreign key(start, end) references Period(start, end),
	foreign key(patient) references Patient(number),
	foreign key(pan) references PAN(domain));

create table Lives(
	start date,
	end date,
	patient varchar(255),
	muni integer,
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
insert into Device values (123456790, 'Philips', 'scale');
insert into Device values (123456791, 'Philips', 'insuline meter');
insert into Device values (123456789, 'RPG', 'blood pressure');

insert into Actuator values (123456789, 'Philips', 'blood pressure');
insert into Actuator values (123456790, 'Philips', 'scale');
insert into Actuator values (123456791, 'Philips', 'insuline meter');

insert into Sensor values (123456789, 'RPG', 'blood pressure');


insert into Period values ('2015-10-26', '2015-11-26');
insert into Period values ('2015-4-26', '2015-10-26');
insert into Period values ('2015-5-26', '2015-11-25');
insert into Period values ('2014-12-25', '2015-01-01');



