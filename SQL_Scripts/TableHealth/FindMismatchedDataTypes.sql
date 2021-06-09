--Identify columns that have the same name, but different data types or data lengths
WITH Query as 
(
SELECT COLUMN_NAME, COUNT(DISTINCT DATA_TYPE)AS 'NumDiffTypes' ,COUNT(DISTINCT Character_Maximum_length) AS 'NumDiffLengths'
FROM INFORMATION_SCHEMA.COLUMNS
GROUP BY COLUMN_NAME
)
SELECT * FROM Query WHERE NumDiffTypes > 1 or NumDiffLengths > 1
Order by NumDiffTypes desc,NumDiffLengths desc
