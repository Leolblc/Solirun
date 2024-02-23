use  Solirun;
# tables

drop tables Equipes ;
drop table Sessions;
drop table Classes;
CREATE TABLE Sessions(
   idSession INT,
   dateSession DATETIME,
   dateFin DATETIME,
   nbTours int,
   PRIMARY KEY(idSession)
);
insert into Sessions (idSession,dateSession,dateFin)
values
(1,'2023-12-10 10:10:10',null),
(2,'2024-01-19 16:36',null),
(3,'2024-01-19 16:36',null),
(4,'2024-01-19 16:36',null),
(5,'2024-01-19 16:36',null);

CREATE TABLE Classes(
   idClasse int auto_increment,
   nomClasse VARCHAR(50),
   nbEtudiant INT,
   nbTours INT,
   PRIMARY KEY(idClasse)
);
insert into Classes (nomClasse,nbEtudiant,nbTours)
values("classe1",20,0),
("classe2",20,0),
("classe4",20,0),
("classe3024",20,0),
("classeA",20,0),
("classe20",20,0),
('SISR',15,20),
('SIO',27,668),
('SLAM',12,60);

CREATE TABLE Equipes(
   idSession INT,
   idClasse int,
   numero INT NOT NULL,
   nbTours int,
   PRIMARY KEY(idSession, idClasse),
   FOREIGN KEY(idSession) REFERENCES Sessions(idSession),
   FOREIGN KEY(idClasse) REFERENCES Classes(idClasse)
);
insert into Equipes (idSession, idClasse ,numero)
values(1,'1',1),
(1,'2',2),
(1,'6',3),
(1,'3',4),
(2,'4',4),
(2,'2',2);
/*
# crée a l'origine en ligne de commande(donc recration avec l'explain) 
create table utilisateur(
	login varchar(20),
    motDePasse varchar(50), # a augmenter pour pouvoir stoquer le hash
	Primary key(login, motDePasse));
#*/  
#procedures
delimiter $$
drop procedure augmenter$$
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
drop procedure reduire$$ 
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
drop procedure insertClasse$$
create procedure insertClasse(in nom varchar(50), in nb int)
begin
insert into Classes(nomClasse, nbEtudiant, nbTours)
values(nom, nb, 0);
end $$
drop procedure updateClasse$$
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
where nomClasse like ancienNom;
end $$
drop procedure deleteClasse $$
create procedure deleteClasse(in id int)
begin 
delete from Equipes where idClasse = id ;
delete from Classes where idClasse = id ;
end$$

# non testée
create procedure insertCourse(in  E1 int, in E2 int, in E3 int, in E4 int) 
begin 
declare N1 varchar (50);
declare N2 varchar (50);
declare N3 varchar (50);
declare N4 varchar (50);
declare lastID int;
select max(idSession)+1 into lastID
from Sessions;

insert into Sessions(idSession, dateSession, dateFin) 
values(lastID, null, null);

if (E1 is not null) 
then 
select nomClasse into N1 from Classe where idClasse = E1;
insert into Equipes(idSession,nomClasse, numero,nbTours)
values(lastID, N1, 1, 0);
end if;

if (E2 is not null) 
then 
select nomClasse into N2 from Classe where idClasse = E2;
insert into Equipes(idSession,nomClasse, numero,nbTours)
values(lastID, N2, 2, 0);
end if;

if (E3 is not null) 
then 
select nomClasse into N3 from Classe where idClasse = E3;
insert into Equipes(idSession,nomClasse, numero,nbTours)
values(lastID, N3, 3, 0);
end if;
if (E4 is not null) 
then 
select nomClasse into N4 from Classe where idClasse = E4;

insert into Equipes(idSession,nomClasse, numero,nbTours)
values(lastID, N4, 4, 0);
end if;
end $$
delimiter ;


# vues
drop view infoSessions;
create view infoSessions as
select S.idSession as 'Session', dateSession as 'début course', dateFin as 'fin de la course', c1.nomClasse as 'equipe 1', e1.nbTours as 'tours équipe 1',c1.nbEtudiant as 'nbEquipe1',
c2.nomClasse as 'equipe 2', e2.nbTours as 'tours équipe 2',c2.nbEtudiant as 'nbEquipe2',c3.nomClasse as 'equipe 3', e3.nbTours as 'tours équipe 3',c3.nbEtudiant as 'nbEquipe3',
c4.nomClasse as 'equipe 4', e4.nbTours as 'tours équipe 4',c4.nbEtudiant as 'nbEquipe4'
from Sessions as S
left join Equipes as e1 on e1.idSession = S.idSession and e1.numero = 1 
left join Equipes as e2 on e2.idSession = S.idSession and e2.numero = 2
left join Equipes as e3 on e3.idSession = S.idSession and e3.numero = 3
left join Equipes as e4 on e4.idSession = S.idSession and e4.numero = 4
left join Classes as c1 on e1.idClasse = c1.idClasse
left join Classes as c2 on e2.idClasse = c2.idClasse
left join Classes as c3 on e3.idClasse = c3.idClasse
left join Classes as c4 on e4.idClasse = c4.idClasse;

drop view classementGeneral;
create view classementGeneral
as select idClasse, nomClasse, nbEtudiant,nbTours 
from Classes order by nbTours desc ;

drop view vueProf;
create view vueProf as
select idClasse, nomClasse, nbEtudiant
from Classes order by idClasse asc;