select * from romances where surname1 like 'Lannister' and surname2 like 'Lannister';
select * from romances where surname1 like surname2;
select * from romances where surname1 like 'Targaryen';
select * from romances limit 50000;

select * from kills limit 50000;

select * from houses order by wealth desc;

select killerID,killerSurname,count(*) from kills group by killerID ORDER BY COUNT(*) DESC;

select * from kills where killerID = 4;
SELECT charID,name,surname,gender,royaltyscale FROM characters where (surname in ('Stark','Lannister')) 
and exists(select * from kills where victimID = charID);

select * from kills where victimID = 0007;
select * from characters where charID in (select victimID from kills) limit 5000;

#best at combat:

#select * from allegiances where surname like 'Tyrell' and surname<>allegiance;
#select char_length(allegiance),allegiance from allegiances where allegiance not like 'Tyrell%' and surname like 'Tyrell';