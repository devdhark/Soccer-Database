BEGIN TRANSACTION;
CREATE TEMPORARY TABLE team_backup(teamID, team_name, standing, games_played, wins, draws, losses, goals_scored, goals_conceded, goal_differential, 
									points, leaguename);
INSERT INTO team_backup SELECT teamID, team_name, standing, games_played, wins, draws, losses, goals_scored, goals_conceded, goal_differential,
								points, leaguename FROM Teams_Updated;
DROP TABLE Teams_Updated;
CREATE TABLE Teams(teamID int PRIMARY KEY, team_name varchar(50), standing int, games_played int,
					wins int, draws int, losses int, goals_scored int, goals_conceded int, 
					goal_differential int, points int, leaguename varchar(50));
INSERT INTO Teams SELECT teamID, team_name, standing, games_played, wins, draws, losses, goals_scored, goals_conceded, goal_differential, 
							points, leaguename FROM team_backup;
DROP TABLE team_backup;
COMMIT;