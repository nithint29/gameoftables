select * from romances where surname1 like 'Lannister' and surname2 like 'Lannister';
select * from romances where surname1 like surname2;
select * from romances where surname1 like 'Targaryen';
select * from romances limit 50000;

select * from kills limit 50000;

select * from houses order by wealth desc;

select killerID,killerSurname,count(*) from kills group by killerID ORDER BY COUNT(*) DESC;

select * from kills where killerID = 4;

SELECT charID,name,surname,gender,royaltyscale FROM characters where (surname in ('Stark','Lannister')) 
and not exists(select * from kills where victimID = charID);

select * from allegiances;

select * from allegiances where surname not like allegiance and surname in 
('Stark','Targaryen','Lannister','Tyrell','Martell','Bolton','Baratheon','Arryn','Greyjoy','Frey') limit 10000;

select * from kills where victimID = 0007;
select * from characters where charID in (select victimID from kills) limit 5000;


select killerID,killerSurname,count(*) from kills group by killerID having count(*) > 5 ORDER BY count(*) DESC;

select charID1 from romances where surname1=surname2;
select charID2 from romances where surname1=surname2;
select charID1 from romances group by charID1 having count(*) >4;
SELECT * FROM characters where (characters.charID in (select charID1 from romances group by charID1 having count(*) >= 1));
select charID1 from romances group by charID1 having count(*) >= 4;
select * from romances;

SELECT count(*),killerName from kills group by killerID  order by count(*) DESC limit 5000;

select * from charlocations where surname = 'Stark';
select * from locations;


UPDATE characters set name='bububub' where charID=5;

select * from characters;

#put in main chars
#map
#game or login
#improve houses page
#best at combat

#select * from allegiances where surname like 'Tyrell' and surname<>allegiance;
#select char_length(allegiance),allegiance from allegiances where allegiance not like 'Tyrell%' and surname like 'Tyrell';