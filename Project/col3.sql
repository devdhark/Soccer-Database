BEGIN TRANSACTION;
CREATE TEMPORARY TABLE League_backup(leagueID, league_name, number_of_teams);
INSERT INTO League_backup SELECT leagueID, league_name, number_of_teams FROM League;
DROP TABLE League;
CREATE TABLE League(leagueID int PRIMARY KEY NOT NULL, league_name varchar(20), number_of_teams int);
INSERT INTO League SELECT leagueID, league_name, number_of_teams FROM League_backup;
DROP TABLE League_backup;
COMMIT;