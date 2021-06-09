--Identify columns that have the same name, but different data types or data lengths
WITH Query as 
(
SELECT COLUMN_NAME, COUNT(DISTINCT DATA_TYPE)AS 'Type_Count' ,COUNT(DISTINCT Character_Maximum_length) AS 'Length_Count', STRING_AGG(Table_Name, ', ') AS Found_In_Tables
FROM INFORMATION_SCHEMA.COLUMNS
GROUP BY COLUMN_NAME
)
SELECT * FROM Query WHERE Type_Count > 1 or Length_Count > 1
Order by Type_Count desc,Length_Count desc

--Use this query to see all individual uses of a specific column name including data type and length
SELECT TABLE_SCHEMA,TABLE_NAME, COLUMN_NAME, DATA_TYPE, Character_Maximum_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'DateID' --Change to column name to investigate