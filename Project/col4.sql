BEGIN TRANSACTION;
CREATE TEMPORARY TABLE Attendance_backup(teamID, Team, Avg_Home_Attendance, Total_Home_Attendance, Avg_Away_Attendance, Total_Away_Attendance);
INSERT INTO Attendance_backup SELECT teamID, Team, Avg_Home_Attendance, Total_Home_Attendance, Avg_Away_Attendance, Total_Away_Attendance FROM Attendance;
DROP TABLE Attendance;
CREATE TABLE Attendance(teamID, Team, Avg_Home_Attendance, Total_Home_Attendance, Avg_Away_Attendance, Total_Away_Attendance);
INSERT INTO Attendance SELECT teamID, Team, Avg_Home_Attendance, Total_Home_Attendance, Avg_Away_Attendance, Total_Away_Attendance FROM Attendance_backup;
DROP TABLE Attendance_backup;
COMMIT;