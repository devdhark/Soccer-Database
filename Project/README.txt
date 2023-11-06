The database_schema file shows which tables are objects and which are relationships.
Steps that were followed to create the database European Soccer 2017-18.db:

1.	The initial downloaded csv files containing the data are saved in the folder Old_CSV. (4 files)
2.	These files are then imported in the python script parsingcsv.py using the pandas module for formatting. The code creates 4 new 		CSV files that are saved in the Updated_CSV folder.
3.	These files are then imported into DB browser for sqlite and sql_code is executed. The code essentially adds Primary Keys, 			Foreign Keys and Columns Types. It also adds new columns so that Foreign keys could be created.
4.	The database is ready for answering the questions.

Note:- The sql_code contains a code that can only be executed only once after the csv files are imported. To run it again the tables 	need to be deleted.