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
	phone integer,
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