use gameoftables;

LOAD DATA LOCAL INFILE 'C:/Users/basis_000/OneDrive/school/rutgers/Senior fall/Databases/project/gameoftables/table generation/characters.txt'
INTO TABLE characters
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
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