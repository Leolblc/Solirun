use Solirun;
show tables;
call insertClasse("2NDE 1" , 29);
call insertClasse("2NDE 2" , 32);
call insertClasse("2NDE 3" , 29);
call insertClasse("2NDE 4" , 31);
call insertClasse("2NDE 5" , 30);
call insertClasse("2NDE 6" , 33);
call insertClasse("2NDE 7" , 30);
call insertClasse("2NDE 8" , 30);
call insertClasse("2NDE 9" , 32);
call insertClasse("2NDE 10" , 30);
call insertClasse("2NDE 11" , 30);

call insertClasse("1ERE 1" , 34);
call insertClasse("1ERE 2" , 34);
call insertClasse("1ERE 3" , 33);
call insertClasse("1ERE 4" ,34);
call insertClasse("1ERE 5" , 31);
call insertClasse("1ERE 6" , 33);
call insertClasse("1ERE 7" , 32);
call insertClasse("1ERE 9" , 31); 
call insertClasse("1ERE 10" , 31);
call insertClasse("1ERE 11" , 29);
call insertClasse("1ERE 12" , 31);

call insertClasse("T1" , 33);
call insertClasse("T2" , 32);
call insertClasse("T3" , 31);
call insertClasse("T4" , 30);
call insertClasse("T5" , 32);
call insertClasse("T6" , 32);
call insertClasse("T7" , 30);
call insertClasse("T8" , 33);
call insertClasse("T10" , 32);
call insertClasse("T11" , 34);
call insertClasse("T12" , 33);
call insertClasse("T13" , 34);
#*/
/*
call insertClasse("CG1" , 22);
call insertClasse("CG2" , 16);
call insertClasse("MCO1" , 29);
call insertClasse("MCO2" , 24);
call insertClasse("NDRC1" , 30);
call insertClasse("NDRC2" , 23);
call insertClasse("SIO1" , 28);
call insertClasse("SIO2" , 22);
#*/
select * from Classes;

call insertCourse(1, 7, 13 , null );
call insertCourse(2, 10, 19 , 12 );
call insertCourse(8, 28, 20, 29 );
call insertCourse(3,27,21 , 30);
call insertCourse(4, 14, 22 , null );
call insertCourse(5, 15, 23 , 31 );
call insertCourse(11, 16, 24 , 34 );
call insertCourse(18, 17, 25 , 33);
call insertCourse(6, 9, 26 , 32 );
#*/

call startCourse(1, "2024-04-05 08:00:00" );
/*call startCourse(2, "2024-04-05 09:00:00");
call startCourse(3, "2024-04-05 10:00:00");
call startCourse(4, "2024-04-05 11:00:00");
call startCourse(5, "2024-04-05 12:00:00");
call startCourse(6, "2024-04-05 13:00:00");
call startCourse(7, "2024-04-05 14:00:00");
call startCourse(8, "2024-04-05 15:00:00");
call startCourse(9, "2024-04-05 16:00:00");
#*/


select * from Equipes;
select * from Sessions;
select * from infoSessions;