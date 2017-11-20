use gameoftables;

LOAD DATA LOCAL INFILE 'C:/Users/basis_000/OneDrive/school/rutgers/Senior fall/Databases/project/gameoftables/table generation/characters.txt'
INTO TABLE characters
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/basis_000/OneDrive/school/rutgers/Senior fall/Databases/project/gameoftables/table generation/allegiances.txt'
INTO TABLE allegiances
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/basis_000/OneDrive/school/rutgers/Senior fall/Databases/project/gameoftables/table generation/romances.txt'
INTO TABLE romances
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/basis_000/OneDrive/school/rutgers/Senior fall/Databases/project/gameoftables/table generation/kills.txt'
INTO TABLE kills
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/Users/basis_000/OneDrive/school/rutgers/Senior fall/Databases/project/gameoftables/table generation/houses.txt'
INTO TABLE houses
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

select * from romances where surname1 like 'Lannister' and surname2 like 'Lannister';
select * from romances where surname1 like surname2;
select * from romances where surname1 like 'Targaryen';
select * from romances limit 50000;

select * from kills limit 50000;

select * from houses order by wealth desc;

select killerID,killerSurname,count(*) from kills group by killerID ORDER BY COUNT(*) DESC;

select * from kills where victimSurname like "Lannister";

#select * from allegiances where surname like 'Tyrell' and surname<>allegiance;
#select char_length(allegiance),allegiance from allegiances where allegiance not like 'Tyrell%' and surname like 'Tyrell';