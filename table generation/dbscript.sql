create database if not exists gameoftables;
use gameoftables;

drop table if exists characters;
create table if not exists characters(
charID varchar(5),
name varchar(50),
surname varchar(50),
gender varchar(10),
royaltyscale int,
main varchar(10),

constraint pk_characters primary key (charID)
);


drop table if exists allegiances;
create table if not exists allegiances(
charID varchar(5),
name varchar(50),
surname varchar(50),
allegiance varchar(50),

constraint pk_ally primary key (charID)
);


drop table if exists romances;
create table if not exists romances(
charID1 varchar(5),
name1 varchar(50),
surname1 varchar(50),
charID2 varchar(5),
name2 varchar(50),
surname2 varchar(50),

constraint pk_ally primary key (charID1,charID2)
);


drop table if exists kills;
create table if not exists kills(
killerID varchar(5),
killerName varchar(50),
killerSurname varchar(50),
victimID varchar(5),
victimName varchar(50),
victimSurname varchar(50),

constraint pk_ally primary key (killerID,victimID)
);


drop table if exists houses;
create table if not exists houses(
name varchar(50),
power int,
leader varchar(50),
wealth int,

constraint pk_ally primary key (name)
);

drop table if exists charlocations;
create table if not exists charlocations(
charID varchar(5),
xcoord int,
ycoord int,
name varchar(50),
surname varchar(50),

constraint pk_ally primary key (charID)
);


drop table if exists locations;
create table if not exists locations(
name varchar(50),
xcoord int,
ycoord int,
house varchar(50),

constraint pk_ally primary key (name)
);



select name from characters limit 5006;
