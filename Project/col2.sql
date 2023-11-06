BEGIN TRANSACTION;
ALTER TABLE Playerstats
ADD teamID int;
UPDATE Playerstats SET teamID = (select teamID from Teams where Playerstats.teamname = Teams.teamname);
CREATE TEMPORARY TABLE Playerstats_backup(playerID, playername, teamname, leaguename, position, appearances, starts,
                           goals, assists, cleansheets, yellowcards, sentoff);
INSERT INTO Playerstats_backup SELECT playerID, playername, teamname, leaguename, position, appearances, starts,
                           goals, assists, cleansheets, yellowcards, sentoff FROM Playerstats;
DROP TABLE Playerstats;
CREATE TABLE Playerstats(playerID int Primary Key NOT NULL, playername varchar(35), teamname varchar(30), leaguename varchar(20), position varchar(15), appearances, starts,
                           goals int, assists int, cleansheets int, yellowcards int, sentoff int);
INSERT INTO Playerstats SELECT playerID, playername, teamname, leaguename, position, appearances, starts,
                           goals, assists, cleansheets, yellowcards, sentoff FROM Playerstats_backup;
DROP TABLE Playerstats_backup;
COMMIT;