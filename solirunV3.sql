use  Solirun;
# tables
CREATE TABLE Sessions(
   idSession INT auto_increment,
   dateSession DATETIME,
   dateFin DATETIME,
   nbTours int,
   PRIMARY KEY(idSession)
);
#*/

CREATE TABLE Classes(
   idClasse int auto_increment,
   nomClasse VARCHAR(50),
   nbEtudiant INT,
   nbTours INT,
   PRIMARY KEY(idClasse)
);
CREATE TABLE Equipes(
   idSession INT,
   idClasse int,
   numero INT NOT NULL,
   nbTours int,
   PRIMARY KEY(idSession, idClasse),
   FOREIGN KEY(idSession) REFERENCES Sessions(idSession),
   FOREIGN KEY(idClasse) REFERENCES Classes(idClasse)
);

# crée a l'origine en ligne de commande(donc recration avec l'explain) 
create table utilisateur(
	login varchar(20),
    motDePasse varchar(50), # a augmenter pour pouvoir stoquer le hash
	Primary key(login, motDePasse));
#*/
/
#procedures
delimiter $$

create procedure augmenter(in idS int, in idC int )
begin
declare nombreTour int;
declare nombreTourTotal int;
declare numeroC int;

select numero into numeroC
from Equipes 
where idSession = idS and idClasse = idC;

select nbTours into nombreTourTotal
from Classes
where idClasse = idC ;

select nbTours into nombreTour
from Equipes 
where idSession = idC and numero = numeroC;

update Classes
set nbTours = nombreTourTotal + 1
where idClasse = idC;

update Equipes
set nbTours = nombreTour + 1
where idSession = idS and numero = numeroC;
end $$

create procedure reduire (in idS int, in idC int)
begin 
declare nombreTour int;
declare nombreTourTotal int;
declare num int ;

select numero into num 
from Equipes 
where idSession = idS and idClasse = idC;

select nbTours into nombreTourTotal
from Classes
where idClasse = idC;

select nbTours into nombreTour
from Equipes 
where idSession = idS and numero = num;
if (nombreTour > 0)
then 
update Classes
set nbTours = nombreTourTotal - 1
where idClasse = idC;

update Equipes
set nbTours = nombreTour - 1
where idSession = idS and numero = num;
end if;
end $$ 

create procedure insertClasse(in nom varchar(50), in nb int)
begin
insert into Classes(nomClasse, nbEtudiant, nbTours)
values(nom, nb, 0);
end $$

create procedure updateClasse(in idC int, in nom varchar(50), in nb int)
begin
if (nom is null )
then
select nomClasse into nom
from Classes where idClasse = idC;
end if;
if (nb is null)
then 
select nbEtudiant into nb
from Classes
where idClasse = idC;
end if;

update Classes
set nomClasse = nom,
nbEtudiant = nb
where idClasse = idC;
end $$

create procedure deleteClasse(in id int)
begin 
delete from Equipes where idClasse = id ;
delete from Classes where idClasse = id ;
end$$

create procedure insertCourse(in  E1 int, in E2 int, in E3 int, in E4 int) 
begin 
declare lastID int;
# id de la session actuelle
insert into Sessions(dateSession, dateFin, nbTours ) 
values(null, null, 0);

select max(idSession) into lastID
from Sessions;

if (E1 is not null) 
then 
insert into Equipes(idSession,idClasse, numero,nbTours)
values(lastID, E1, 1, 0);
end if;

if (E2 is not null) 
then 
insert into Equipes(idSession,idClasse, numero,nbTours)
values(lastID, E2, 2, 0);
end if;

if (E3 is not null) 
then 
insert into Equipes(idSession,idClasse, numero,nbTours)
values(lastID, E3, 3, 0);
end if;
if (E4 is not null) 
then 
insert into Equipes(idSession,idClasse, numero,nbTours)
values(lastID, E4, 4, 0);
end if;
end $$

create procedure updateCourse( in id int, in debut datetime, in fin datetime)
begin
if debut > fin 
then 
update Sessions
set dateSession = fin , dateFin = debut
where idSession = id;

else 
update Sessions
set dateSession = debut , dateFin = fin
where idSession = id;

end if;
end $$

create procedure startCourse(in id int, in debut datetime)
begin
update Sessions
set dateSession = debut
where idSession = id;
end $$

create procedure finCourse(in id int, in horaire dateTime)
begin
update Sessions
set dateFin = horaire
where idSession = id;
end $$

create procedure deleteCourse (in id int)
begin
delete from Sessions where idSession = id;
delete from Equipes where idSession = id;
end $$ 

delimiter ;


# vues
create view infoSessions as
select S.idSession as 'Session', dateSession as 'debutCourse', dateFin as 'finDeLaCourse',
 c1.nomClasse as 'equipe1', c1.nbTours as 'toursEquipe1',c1.nbEtudiant as 'nbEquipe1',
c2.nomClasse as 'equipe2', c2.nbTours as 'toursEquipe2',c2.nbEtudiant as 'nbEquipe2',
c3.nomClasse as 'equipe3', c3.nbTours as 'toursEquipe3',c3.nbEtudiant as 'nbEquipe3',
c4.nomClasse as 'equipe4', c4.nbTours as 'toursEquipe4',c4.nbEtudiant as 'nbEquipe4'
from Sessions as S
left join Equipes as e1 on e1.idSession = S.idSession and e1.numero = 1 
left join Equipes as e2 on e2.idSession = S.idSession and e2.numero = 2
left join Equipes as e3 on e3.idSession = S.idSession and e3.numero = 3
left join Equipes as e4 on e4.idSession = S.idSession and e4.numero = 4
left join Classes as c1 on e1.idClasse = c1.idClasse
left join Classes as c2 on e2.idClasse = c2.idClasse
left join Classes as c3 on e3.idClasse = c3.idClasse
left join Classes as c4 on e4.idClasse = c4.idClasse;

create view classementGeneral
as select idClasse, nomClasse, nbEtudiant, nbTours 
from Classes order by nbTours desc ;

create view vueProf as
select idClasse, nomClasse, nbEtudiant
from Classes order by idClasse asc;