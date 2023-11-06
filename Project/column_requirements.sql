BEGIN TRANSACTION;
CREATE TEMPORARY TABLE League_backup(leagueID, league_name, number_of_teams);
INSERT INTO League_backup SELECT leagueID, league_name, number_of_teams FROM League;
DROP TABLE League;
CREATE TABLE League(leagueID int PRIMARY KEY NOT NULL, league_name varchar(20), number_of_teams int);
INSERT INTO League SELECT leagueID, league_name, number_of_teams FROM League_backup;
DROP TABLE League_backup;
COMMIT;

BEGIN TRANSACTION;
CREATE TEMPORARY TABLE Attendance_backup(teamID, teamname, Avg_Home_Attendance, Total_Home_Attendance, Avg_Away_Attendance, Total_Away_Attendance);
INSERT INTO Attendance_backup SELECT teamID, teamname, Avg_Home_Attendance, Total_Home_Attendance,
			Avg_Away_Attendance, Total_Away_Attendance FROM Attendance;
DROP TABLE Attendance;
CREATE TABLE Attendance(teamID int PRIMARY KEY NOT NULL, teamname varchar(25), Avg_Home_Attendance int, Total_Home_Attendance int,
						Avg_Away_Attendance int, Total_Away_Attendance int);
INSERT INTO Attendance SELECT teamID, teamname, Avg_Home_Attendance, Total_Home_Attendance,
								Avg_Away_Attendance, Total_Away_Attendance FROM Attendance_backup;
DROP TABLE Attendance_backup;
COMMIT;

BEGIN TRANSACTION;
ALTER TABLE Teams
ADD leagueID int;
UPDATE Teams SET leagueID = (select leagueID from League where Teams.leaguename = League.league_name);
CREATE TEMPORARY TABLE team_backup(teamID, team_name, standing, games_played, wins, draws, losses, goals_scored, goals_conceded, goal_differential, 
									points, leagueID);
INSERT INTO team_backup SELECT teamID, team_name, standing, games_played, wins, draws, losses, goals_scored, goals_conceded, goal_differential,
								points, leagueID FROM Teams;
DROP TABLE Teams;
CREATE TABLE Teams(teamID int PRIMARY KEY NOT NULL REFERENCES Attendance(teamID), team_name varchar(30), standing int, games_played int,
					wins int, draws int, losses int, goals_scored int, goals_conceded int, 
					goal_differential int, points int, leagueID int REFERENCES League(leagueID));
INSERT INTO Teams SELECT teamID, team_name, standing, games_played, wins, draws, losses, goals_scored, goals_conceded, goal_differential, 
							points, leagueID FROM team_backup;
DROP TABLE team_backup;
COMMIT;

BEGIN TRANSACTION;
ALTER TABLE Playerstats
ADD teamID int;
UPDATE Playerstats SET teamID = (select teamID from Teams where Playerstats.teamname = Teams.team_name);
CREATE TEMPORARY TABLE Playerstats_backup(playerID, playername, teamID, leaguename, position, appearances, starts,
                           goals, assists, cleansheets, yellowcards, sentoff);
INSERT INTO Playerstats_backup SELECT playerID, playername, teamID, leaguename, position, appearances, starts,
                           goals, assists, cleansheets, yellowcards, sentoff FROM Playerstats;
DROP TABLE Playerstats;
CREATE TABLE Playerstats(playerID int Primary Key NOT NULL, playername varchar(35), teamID int REFERENCES teams, leaguename varchar(20), position varchar(15), appearances, starts,
                           goals int, assists int, cleansheets int, yellowcards int, sentoff int);
INSERT INTO Playerstats SELECT playerID, playername, teamID, leaguename, position, appearances, starts,
                           goals, assists, cleansheets, yellowcards, sentoff FROM Playerstats_backup;
DROP TABLE Playerstats_backup;
COMMIT;